Use MarketHubDB;

CREATE TABLE [User] (
    user_id       INT IDENTITY(1,1) PRIMARY KEY,
    name          VARCHAR(100)  NOT NULL,
    email         VARCHAR(150)  NOT NULL UNIQUE,
    password_hash VARCHAR(150)  NOT NULL,
    phone         VARCHAR(20),
    created_at    DATETIME      NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Buyer (
    user_id           INT PRIMARY KEY,
    loyalty_points    INT          NOT NULL DEFAULT 0,
    preferred_payment VARCHAR(50),
    date_of_birth     DATE         NOT NULL,

    CONSTRAINT chk_buyer_age CHECK (
        DATEDIFF(YEAR, date_of_birth, GETDATE()) >= 16
    ),

    CONSTRAINT fk_buyer_user
        FOREIGN KEY (user_id) REFERENCES [User](user_id)
        ON DELETE CASCADE
);

CREATE TABLE Seller (
    user_id      INT PRIMARY KEY,
    shop_name    VARCHAR(150) NOT NULL,
    description  TEXT,
    bank_account VARCHAR(50),
    rating       DECIMAL(3,2) CHECK (rating >= 0 AND rating <= 5),

    CONSTRAINT fk_seller_user
        FOREIGN KEY (user_id) REFERENCES [User](user_id)
        ON DELETE CASCADE
);

CREATE TABLE Address (
    address_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id    INT          NOT NULL,
    street     VARCHAR(200) NOT NULL,
    city       VARCHAR(100) NOT NULL,
    country    VARCHAR(100) NOT NULL,
    zip_code   VARCHAR(20),
    is_default BIT          NOT NULL DEFAULT 0,

    CONSTRAINT fk_address_user
        FOREIGN KEY (user_id) REFERENCES [User](user_id)
        ON DELETE CASCADE
);

CREATE TABLE Category (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE Subcategory (
    subcategory_id INT IDENTITY(1,1) PRIMARY KEY,
    category_id    INT          NOT NULL,
    name           VARCHAR(100) NOT NULL,

    CONSTRAINT fk_subcategory_category
        FOREIGN KEY (category_id) REFERENCES Category(category_id)
        ON DELETE CASCADE
);

CREATE TABLE Carrier (
    carrier_id    INT IDENTITY(1,1) PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    tracking_url  VARCHAR(255),
    contact_email VARCHAR(150)
);

CREATE TABLE Warehouse (
    warehouse_id INT IDENTITY(1,1) PRIMARY KEY,
    name         VARCHAR(150) NOT NULL,
    location     VARCHAR(255),
    capacity     INT          CHECK (capacity > 0)
);

CREATE TABLE Product (
    product_id     INT IDENTITY(1,1) PRIMARY KEY,
    seller_id      INT           NOT NULL,
    subcategory_id INT           NOT NULL,
    name           VARCHAR(200)  NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    stock          INT           NOT NULL DEFAULT 0,
    status         VARCHAR(20)   NOT NULL DEFAULT 'active',

    CONSTRAINT chk_product_price  CHECK (price > 0),
    CONSTRAINT chk_product_stock  CHECK (stock >= 0),
    CONSTRAINT chk_product_status CHECK (status IN ('active','inactive','deleted')),

    CONSTRAINT fk_product_seller
        FOREIGN KEY (seller_id) REFERENCES Seller(user_id),

    CONSTRAINT fk_product_subcategory
        FOREIGN KEY (subcategory_id) REFERENCES Subcategory(subcategory_id)
);

CREATE TABLE ProductImage (
    image_id    INT IDENTITY(1,1) PRIMARY KEY,
    product_id  INT          NOT NULL,
    image_url   VARCHAR(255) NOT NULL,

    CONSTRAINT fk_productimage_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE
);

CREATE TABLE ProductAttribute (
    attribute_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id   INT          NOT NULL,
    attr_name    VARCHAR(100) NOT NULL,

    CONSTRAINT fk_productattr_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON DELETE CASCADE
);

CREATE TABLE Cart (
    cart_id    INT IDENTITY(1,1) PRIMARY KEY,
    buyer_id   INT      NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT fk_cart_buyer
        FOREIGN KEY (buyer_id) REFERENCES Buyer(user_id)
        ON DELETE CASCADE
);

CREATE TABLE CartItem (
    cart_id    INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL DEFAULT 1,
    added_at   DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT pk_cartitem PRIMARY KEY (cart_id, product_id),
    CONSTRAINT chk_cartitem_qty CHECK (quantity >= 1),

    CONSTRAINT fk_cartitem_cart
        FOREIGN KEY (cart_id) REFERENCES Cart(cart_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cartitem_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Inventory (
    inventory_id  INT IDENTITY(1,1) PRIMARY KEY,
    product_id    INT NOT NULL,
    warehouse_id  INT NOT NULL,
    quantity      INT NOT NULL DEFAULT 0,
    min_threshold INT NOT NULL DEFAULT 5,
    last_updated  DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT uq_inventory UNIQUE (product_id, warehouse_id),
    CONSTRAINT chk_inventory_qty CHECK (quantity >= 0),
    CONSTRAINT chk_inventory_threshold CHECK (min_threshold >= 0),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id),

    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
);

CREATE TABLE Shipment (
    shipment_id  INT IDENTITY(1,1) PRIMARY KEY,
    carrier_id   INT          NOT NULL,
    tracking_num VARCHAR(100),
    shipped_at   DATETIME,
    status       VARCHAR(20)  NOT NULL DEFAULT 'pending',

    CONSTRAINT chk_shipment_status
        CHECK (status IN ('pending','dispatched','in_transit','delivered','returned')),

    CONSTRAINT fk_shipment_carrier
        FOREIGN KEY (carrier_id) REFERENCES Carrier(carrier_id)
);

CREATE TABLE [Order] (
    order_id     INT IDENTITY(1,1) PRIMARY KEY,
    buyer_id     INT           NOT NULL,
    address_id   INT           NOT NULL,
    shipment_id  INT           NOT NULL UNIQUE,
    order_date   DATETIME      NOT NULL DEFAULT GETDATE(),
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0,
    status       VARCHAR(20)   NOT NULL DEFAULT 'pending',

    CONSTRAINT chk_order_status
        CHECK (status IN ('pending','confirmed','shipped','delivered','cancelled','returned')),

    CONSTRAINT fk_order_buyer
        FOREIGN KEY (buyer_id) REFERENCES Buyer(user_id),

    CONSTRAINT fk_order_address
        FOREIGN KEY (address_id) REFERENCES Address(address_id),

    CONSTRAINT fk_order_shipment
        FOREIGN KEY (shipment_id) REFERENCES Shipment(shipment_id)
);

CREATE TABLE Buyer_Order (
    id       INT IDENTITY(1,1) PRIMARY KEY,
    buyer_id INT NOT NULL,
    order_id INT NOT NULL,

    CONSTRAINT uq_buyer_order UNIQUE (buyer_id, order_id),

    CONSTRAINT fk_buyerorder_buyer
        FOREIGN KEY (buyer_id) REFERENCES Buyer(user_id),

    CONSTRAINT fk_buyerorder_order
        FOREIGN KEY (order_id) REFERENCES [Order](order_id)
);

CREATE TABLE OrderItem (
    order_id   INT           NOT NULL,
    product_id INT           NOT NULL,
    quantity   INT           NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_orderitem PRIMARY KEY (order_id, product_id),
    CONSTRAINT chk_orderitem_qty   CHECK (quantity >= 1),
    CONSTRAINT chk_orderitem_price CHECK (unit_price > 0),

    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (order_id) REFERENCES [Order](order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_orderitem_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id   INT           NOT NULL UNIQUE,
    method     VARCHAR(50)   NOT NULL,
    status     VARCHAR(20)   NOT NULL DEFAULT 'pending',
    amount     DECIMAL(12,2) NOT NULL,
    paid_at    DATETIME,

    CONSTRAINT chk_payment_status
        CHECK (status IN ('pending','completed','failed','refunded')),
    CONSTRAINT chk_payment_amount CHECK (amount > 0),

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id) REFERENCES [Order](order_id)
);

CREATE TABLE [Transaction] (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    payment_id     INT          NOT NULL,
    gateway        VARCHAR(100) NOT NULL,
    reference_no   VARCHAR(100),
    status         VARCHAR(20)  NOT NULL DEFAULT 'pending',
    created_at     DATETIME     NOT NULL DEFAULT GETDATE(),

    CONSTRAINT chk_transaction_status
        CHECK (status IN ('pending','success','failed')),

    CONSTRAINT fk_transaction_payment
        FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
        ON DELETE CASCADE
);

CREATE TABLE Review (
    review_id  INT IDENTITY(1,1) PRIMARY KEY,
    buyer_id   INT      NOT NULL,
    product_id INT      NOT NULL,
    rating     TINYINT  NOT NULL,
    comment    TEXT,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT uq_review UNIQUE (buyer_id, product_id),
    CONSTRAINT chk_review_rating CHECK (rating >= 1 AND rating <= 5),

    CONSTRAINT fk_review_buyer
        FOREIGN KEY (buyer_id) REFERENCES Buyer(user_id),

    CONSTRAINT fk_review_product
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
);