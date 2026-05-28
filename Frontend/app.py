from flask import Flask, render_template, request, redirect, url_for, session, flash
from db import get_connection
import hashlib

app = Flask(__name__)
app.secret_key = 'marketplacesecretkey123'

# ─────────────────────────────────────────
# HELPER: hash password
# ─────────────────────────────────────────
def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

# ─────────────────────────────────────────
# HOME
# ─────────────────────────────────────────
@app.route('/')
def home():
    return redirect(url_for('login'))

# ─────────────────────────────────────────
# REGISTER
# ─────────────────────────────────────────
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name     = request.form['name']
        email    = request.form['email']
        password = hash_password(request.form['password'])
        phone    = request.form['phone']
        role     = request.form['role']

        conn   = get_connection()
        cursor = conn.cursor()
        try:
            cursor.execute("""
                INSERT INTO [User] (name, email, password_hash, phone)
                VALUES (?, ?, ?, ?)
            """, (name, email, password, phone))
            conn.commit()

            cursor.execute("SELECT user_id FROM [User] WHERE email = ?", (email,))
            user_id = cursor.fetchone()[0]

            if role == 'buyer':
                dob = request.form['dob']
                cursor.execute("""
                    INSERT INTO Buyer (user_id, date_of_birth) VALUES (?, ?)
                """, (user_id, dob))
                cursor.execute("INSERT INTO Cart (buyer_id) VALUES (?)", (user_id,))

            elif role == 'seller':
                shop_name = request.form['shop_name']
                cursor.execute("""
                    INSERT INTO Seller (user_id, shop_name) VALUES (?, ?)
                """, (user_id, shop_name))

            conn.commit()
            flash('Registration successful! Please login.', 'success')
            return redirect(url_for('login'))

        except Exception as e:
            conn.rollback()
            flash(f'Registration error: {str(e)}', 'danger')
        finally:
            conn.close()

    return render_template('register.html')

# ─────────────────────────────────────────
# LOGIN
# ─────────────────────────────────────────
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email    = request.form['email']
        password = hash_password(request.form['password'])

        conn   = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT user_id, name FROM [User]
            WHERE email = ? AND password_hash = ?
        """, (email, password))
        user = cursor.fetchone()

        if user:
            session['user_id'] = user[0]
            session['name']    = user[1]

            cursor.execute("SELECT user_id FROM Buyer  WHERE user_id = ?", (user[0],))
            is_buyer = cursor.fetchone()
            cursor.execute("SELECT user_id FROM Seller WHERE user_id = ?", (user[0],))
            is_seller = cursor.fetchone()
            conn.close()

            if is_buyer:
                session['role'] = 'buyer'
                return redirect(url_for('buyer_home'))
            elif is_seller:
                session['role'] = 'seller'
                return redirect(url_for('seller_dashboard'))
            else:
                session['role'] = 'admin'
                return redirect(url_for('admin_dashboard'))
        else:
            conn.close()
            flash('Invalid email or password.', 'danger')

    return render_template('login.html')

# ─────────────────────────────────────────
# LOGOUT
# ─────────────────────────────────────────
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

# ─────────────────────────────────────────
# BUYER — HOME
# ─────────────────────────────────────────
@app.route('/buyer')
def buyer_home():
    if session.get('role') != 'buyer':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    search   = request.args.get('search', '')
    category = request.args.get('category', '')

    query = """
        SELECT p.product_id, p.name, p.price, p.stock,
               c.name AS category, s.shop_name, p.image_filename
        FROM Product p
        JOIN Subcategory sc ON p.subcategory_id = sc.subcategory_id
        JOIN Category c     ON sc.category_id   = c.category_id
        JOIN Seller s       ON p.seller_id       = s.user_id
        WHERE p.status = 'active'
    """
    params = []
    if search:
        query += " AND p.name LIKE ?"
        params.append(f'%{search}%')
    if category:
        query += " AND c.name = ?"
        params.append(category)

    cursor.execute(query, params)
    products = cursor.fetchall()

    cursor.execute("SELECT name FROM Category")
    categories = cursor.fetchall()
    conn.close()

    return render_template('buyer_home.html',
                           products=products,
                           categories=categories,
                           search=search,
                           selected_category=category)

# ─────────────────────────────────────────
# BUYER — CART
# ─────────────────────────────────────────
@app.route('/cart')
def cart():
    if session.get('role') != 'buyer':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT cart_id FROM Cart WHERE buyer_id = ?", (session['user_id'],))
    cart_row = cursor.fetchone()

    items = []
    total = 0
    if cart_row:
        cart_id = cart_row[0]
        cursor.execute("""
            SELECT p.product_id, p.name, p.price, ci.quantity,
                   (p.price * ci.quantity) AS subtotal
            FROM CartItem ci
            JOIN Product p ON ci.product_id = p.product_id
            WHERE ci.cart_id = ?
        """, (cart_id,))
        items = cursor.fetchall()
        total = sum(row[4] for row in items)

    conn.close()
    return render_template('cart.html', items=items, total=total)

# ─────────────────────────────────────────
# BUYER — ADD TO CART
# ─────────────────────────────────────────
@app.route('/add_to_cart/<int:product_id>')
def add_to_cart(product_id):
    if session.get('role') != 'buyer':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT cart_id FROM Cart WHERE buyer_id = ?", (session['user_id'],))
    cart_row = cursor.fetchone()
    cart_id  = cart_row[0]

    cursor.execute("SELECT quantity FROM CartItem WHERE cart_id=? AND product_id=?",
                   (cart_id, product_id))
    existing = cursor.fetchone()

    if existing:
        cursor.execute("""
            UPDATE CartItem SET quantity = quantity + 1
            WHERE cart_id = ? AND product_id = ?
        """, (cart_id, product_id))
    else:
        cursor.execute("""
            INSERT INTO CartItem (cart_id, product_id, quantity)
            VALUES (?, ?, 1)
        """, (cart_id, product_id))

    conn.commit()
    conn.close()
    flash('Item added to cart!', 'success')
    return redirect(url_for('buyer_home'))

# ─────────────────────────────────────────
# BUYER — ADD ADDRESS
# ─────────────────────────────────────────
@app.route('/add_address', methods=['POST'])
def add_address():
    if session.get('role') != 'buyer':
        return redirect(url_for('login'))

    street   = request.form['street']
    city     = request.form['city']
    country  = request.form['country']
    zip_code = request.form.get('zip_code', '')

    conn   = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("""
            INSERT INTO Address (user_id, street, city, country, zip_code)
            VALUES (?, ?, ?, ?, ?)
        """, (session['user_id'], street, city, country, zip_code))
        conn.commit()
        flash('Address saved!', 'success')
    except Exception as e:
        conn.rollback()
        flash(f'Error saving address: {str(e)}', 'danger')
    finally:
        conn.close()

    return redirect(url_for('place_order'))

# ─────────────────────────────────────────
# BUYER — PLACE ORDER
# ─────────────────────────────────────────
@app.route('/place_order', methods=['GET', 'POST'])
def place_order():
    if session.get('role') != 'buyer':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        address_id     = request.form['address_id']
        payment_method = request.form['payment_method']

        cursor.execute("SELECT cart_id FROM Cart WHERE buyer_id = ?", (session['user_id'],))
        cart_id = cursor.fetchone()[0]

        cursor.execute("""
            SELECT ci.product_id, ci.quantity, p.price
            FROM CartItem ci
            JOIN Product p ON ci.product_id = p.product_id
            WHERE ci.cart_id = ?
        """, (cart_id,))
        items = cursor.fetchall()

        if not items:
            flash('Your cart is empty!', 'warning')
            return redirect(url_for('cart'))

        total = sum(row[1] * row[2] for row in items)

        try:
            cursor.execute("SELECT TOP 1 carrier_id FROM Carrier")
            carrier_row = cursor.fetchone()
            carrier_id  = carrier_row[0] if carrier_row else 1

            cursor.execute("""
                INSERT INTO Shipment (carrier_id, status)
                OUTPUT INSERTED.shipment_id
                VALUES (?, 'pending')
            """, (carrier_id,))
            shipment_id = cursor.fetchone()[0]

            cursor.execute("""
                INSERT INTO [Order] (buyer_id, address_id, shipment_id, total_amount, status)
                OUTPUT INSERTED.order_id
                VALUES (?, ?, ?, ?, 'pending')
            """, (session['user_id'], address_id, shipment_id, total))
            order_id = cursor.fetchone()[0]

            for item in items:
                cursor.execute("""
                    INSERT INTO OrderItem (order_id, product_id, quantity, unit_price)
                    VALUES (?, ?, ?, ?)
                """, (order_id, item[0], item[1], item[2]))

            cursor.execute("""
                INSERT INTO Buyer_Order (buyer_id, order_id) VALUES (?, ?)
            """, (session['user_id'], order_id))

            cursor.execute("""
                INSERT INTO Payment (order_id, method, status, amount)
                VALUES (?, ?, 'completed', ?)
            """, (order_id, payment_method, total))

            cursor.execute("DELETE FROM CartItem WHERE cart_id = ?", (cart_id,))

            conn.commit()
            flash(f'✅ Order placed successfully! Order ID: #{order_id}', 'success')
            return redirect(url_for('my_orders'))

        except Exception as e:
            conn.rollback()
            flash(f'Error placing order: {str(e)}', 'danger')

    cursor.execute("""
        SELECT address_id, street, city, country
        FROM Address WHERE user_id = ?
    """, (session['user_id'],))
    addresses = cursor.fetchall()
    conn.close()

    return render_template('place_order.html', addresses=addresses)

# ─────────────────────────────────────────
# BUYER — MY ORDERS
# ─────────────────────────────────────────
@app.route('/my_orders')
def my_orders():
    if session.get('role') != 'buyer':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT o.order_id, o.order_date, o.total_amount, o.status,
               p.method, p.status AS pay_status
        FROM [Order] o
        LEFT JOIN Payment p ON o.order_id = p.order_id
        WHERE o.buyer_id = ?
        ORDER BY o.order_date DESC
    """, (session['user_id'],))
    orders = cursor.fetchall()
    conn.close()
    return render_template('my_orders.html', orders=orders)

# ─────────────────────────────────────────
# BUYER — WRITE REVIEW
# ─────────────────────────────────────────
@app.route('/review/<int:product_id>', methods=['GET', 'POST'])
def write_review(product_id):
    if session.get('role') != 'buyer':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        rating  = request.form['rating']
        comment = request.form['comment']
        try:
            cursor.execute("""
                INSERT INTO Review (buyer_id, product_id, rating, comment)
                VALUES (?, ?, ?, ?)
            """, (session['user_id'], product_id, rating, comment))
            conn.commit()
            flash('Review submitted! Thank you.', 'success')
        except Exception as e:
            conn.rollback()
            flash(f'Error submitting review: {str(e)}', 'danger')
        finally:
            conn.close()
        return redirect(url_for('buyer_home'))

    cursor.execute("SELECT name FROM Product WHERE product_id = ?", (product_id,))
    product = cursor.fetchone()
    conn.close()
    return render_template('review.html', product=product, product_id=product_id)

# ─────────────────────────────────────────
# SELLER — DASHBOARD
# ─────────────────────────────────────────
@app.route('/seller')
def seller_dashboard():
    if session.get('role') != 'seller':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT product_id, name, price, stock, status
        FROM Product WHERE seller_id = ?
        ORDER BY product_id DESC
    """, (session['user_id'],))
    products = cursor.fetchall()

    cursor.execute("""
        SELECT COUNT(*) FROM Product
        WHERE seller_id = ? AND status = 'active'
    """, (session['user_id'],))
    active_count = cursor.fetchone()[0]

    cursor.execute("""
        SELECT ISNULL(SUM(oi.quantity * oi.unit_price), 0)
        FROM OrderItem oi
        JOIN Product p ON oi.product_id = p.product_id
        WHERE p.seller_id = ?
    """, (session['user_id'],))
    total_revenue = cursor.fetchone()[0]

    conn.close()
    return render_template('seller_dashboard.html',
                           products=products,
                           active_count=active_count,
                           total_revenue=total_revenue)

# ─────────────────────────────────────────
# SELLER — ADD PRODUCT
# ─────────────────────────────────────────
@app.route('/seller/add_product', methods=['GET', 'POST'])
def add_product():
    if session.get('role') != 'seller':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        name           = request.form['name']
        price          = request.form['price']
        stock          = request.form['stock']
        subcategory_id = request.form['subcategory_id']
        try:
            cursor.execute("""
                INSERT INTO Product (seller_id, subcategory_id, name, price, stock, status)
                VALUES (?, ?, ?, ?, ?, 'active')
            """, (session['user_id'], subcategory_id, name, price, stock))
            conn.commit()
            flash('Product added successfully!', 'success')
            return redirect(url_for('seller_dashboard'))
        except Exception as e:
            conn.rollback()
            flash(f'Error: {str(e)}', 'danger')

    cursor.execute("""
        SELECT sc.subcategory_id, c.name + ' > ' + sc.name
        FROM Subcategory sc
        JOIN Category c ON sc.category_id = c.category_id
    """)
    subcategories = cursor.fetchall()
    conn.close()
    return render_template('add_product.html', subcategories=subcategories)

# ─────────────────────────────────────────
# SELLER — EDIT PRODUCT
# ─────────────────────────────────────────
@app.route('/seller/edit_product/<int:product_id>', methods=['GET', 'POST'])
def edit_product(product_id):
    if session.get('role') != 'seller':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    if request.method == 'POST':
        name   = request.form['name']
        price  = request.form['price']
        stock  = request.form['stock']
        status = request.form['status']
        try:
            cursor.execute("""
                UPDATE Product SET name=?, price=?, stock=?, status=?
                WHERE product_id=? AND seller_id=?
            """, (name, price, stock, status, product_id, session['user_id']))
            conn.commit()
            flash('Product updated!', 'success')
            return redirect(url_for('seller_dashboard'))
        except Exception as e:
            conn.rollback()
            flash(f'Error: {str(e)}', 'danger')

    cursor.execute("""
        SELECT product_id, name, price, stock, status
        FROM Product WHERE product_id = ? AND seller_id = ?
    """, (product_id, session['user_id']))
    product = cursor.fetchone()
    conn.close()

    if not product:
        flash('Product not found.', 'danger')
        return redirect(url_for('seller_dashboard'))

    return render_template('edit_product.html', product=product)

# ─────────────────────────────────────────
# SELLER — DELETE PRODUCT (soft delete)
# ─────────────────────────────────────────
@app.route('/seller/delete_product/<int:product_id>')
def delete_product(product_id):
    if session.get('role') != 'seller':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE Product SET status = 'deleted'
        WHERE product_id = ? AND seller_id = ?
    """, (product_id, session['user_id']))
    conn.commit()
    conn.close()
    flash('Product removed.', 'info')
    return redirect(url_for('seller_dashboard'))

# ─────────────────────────────────────────
# ADMIN — DASHBOARD
# ─────────────────────────────────────────
@app.route('/admin')
def admin_dashboard():
    conn   = get_connection()
    cursor = conn.cursor()

    # Using VIEW: vw_TopSellingProducts
    cursor.execute("""
        SELECT TOP 5 name, total_sold
        FROM vw_TopSellingProducts
        ORDER BY total_sold DESC
    """)
    top_products = cursor.fetchall()

    # Using VIEW: vw_MonthlyRevenue
    cursor.execute("""
        SELECT month, revenue
        FROM vw_MonthlyRevenue
        ORDER BY month
    """)
    monthly_revenue = cursor.fetchall()

    cursor.execute("""
        SELECT TOP 5 u.name, COUNT(o.order_id) AS total_orders
        FROM [Order] o
        JOIN [User] u ON o.buyer_id = u.user_id
        GROUP BY u.name
        ORDER BY total_orders DESC
    """)
    active_buyers = cursor.fetchall()

    cursor.execute("SELECT COUNT(*) FROM [User]")
    total_users = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM Product WHERE status='active'")
    total_products = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM [Order]")
    total_orders = cursor.fetchone()[0]
    cursor.execute("SELECT ISNULL(SUM(total_amount),0) FROM [Order]")
    total_revenue = cursor.fetchone()[0]

    conn.close()
    return render_template('admin_dashboard.html',
                           top_products=top_products,
                           monthly_revenue=monthly_revenue,
                           active_buyers=active_buyers,
                           total_users=total_users,
                           total_products=total_products,
                           total_orders=total_orders,
                           total_revenue=total_revenue)
# ─────────────────────────────────────────
# BUYER — PRODUCT DETAIL
# ─────────────────────────────────────────
@app.route('/product/<int:product_id>')
def product_detail(product_id):
    if session.get('role') != 'buyer':
        return redirect(url_for('login'))

    conn   = get_connection()
    cursor = conn.cursor()

    # Product details
    cursor.execute("""
        SELECT p.product_id, p.name, p.price, p.stock,
               c.name AS category, s.shop_name,
               p.image_filename, sc.name AS subcategory
        FROM Product p
        JOIN Subcategory sc ON p.subcategory_id = sc.subcategory_id
        JOIN Category c     ON sc.category_id   = c.category_id
        JOIN Seller s       ON p.seller_id       = s.user_id
        WHERE p.product_id = ? AND p.status = 'active'
    """, (product_id,))
    product = cursor.fetchone()

    if not product:
        flash('Product not found.', 'danger')
        return redirect(url_for('buyer_home'))

    # Reviews for this product
    cursor.execute("""
        SELECT u.name, r.rating, r.comment, r.created_at
        FROM Review r
        JOIN [User] u ON r.buyer_id = u.user_id
        WHERE r.product_id = ?
        ORDER BY r.created_at DESC
    """, (product_id,))
    reviews = cursor.fetchall()

    # Average rating
    cursor.execute("""
        SELECT AVG(CAST(rating AS DECIMAL(3,2))), COUNT(*)
        FROM Review WHERE product_id = ?
    """, (product_id,))
    rating_row  = cursor.fetchone()
    avg_rating  = rating_row[0] or 0
    review_count= rating_row[1]

    conn.close()
    return render_template('product_detail.html',
                           product=product,
                           reviews=reviews,
                           avg_rating=avg_rating,
                           review_count=review_count)
# ─────────────────────────────────────────
# RUN
# ─────────────────────────────────────────
if __name__ == '__main__':
    app.run(debug=True)