USE MarketHubDB;
GO

--  [User]  
INSERT INTO [User] (name, email, password_hash, phone) VALUES
('Ali Hassan',        'ali.hassan@email.com',        'hash_ah_001', '0311-1234567'),
('Sara Khan',         'sara.khan@email.com',         'hash_sk_002', '0322-2345678'),
('Usman Tariq',       'usman.tariq@email.com',       'hash_ut_003', '0333-3456789'),
('Fatima Malik',      'fatima.malik@email.com',      'hash_fm_004', '0344-4567890'),
('Bilal Ahmed',       'bilal.ahmed@email.com',       'hash_ba_005', '0355-5678901'),
('Ayesha Siddiqui',   'ayesha.siddiqui@email.com',  'hash_as_006', '0366-6789012'),
('Omar Sheikh',       'omar.sheikh@email.com',       'hash_os_007', '0377-7890123'),
('Hina Nawaz',        'hina.nawaz@email.com',        'hash_hn_008', '0388-8901234'),
('Zain Butt',         'zain.butt@email.com',         'hash_zb_009', '0399-9012345'),
('Nadia Qureshi',     'nadia.qureshi@email.com',     'hash_nq_010', '0311-0123456'),
('Kamran Iqbal',      'kamran.iqbal@email.com',      'hash_ki_011', '0322-1234560'),
('Sana Rauf',         'sana.rauf@email.com',         'hash_sr_012', '0333-2345601'),
('Faisal Chaudhry',   'faisal.chaudhry@email.com',  'hash_fc_013', '0344-3456012'),
('Mehwish Javed',     'mehwish.javed@email.com',     'hash_mj_014', '0355-4560123'),
('Tariq Mahmood',     'tariq.mahmood@email.com',     'hash_tm_015', '0366-5601234'),
('Rabia Farooq',      'rabia.farooq@email.com',      'hash_rf_016', '0377-6012345'),
('Imran Zahid',       'imran.zahid@email.com',       'hash_iz_017', '0388-7123456'),
('Asma Gillani',      'asma.gillani@email.com',      'hash_ag_018', '0399-8234567'),
('Danish Mirza',      'danish.mirza@email.com',      'hash_dm_019', '0311-9345678'),
('Lubna Saeed',       'lubna.saeed@email.com',       'hash_ls_020', '0322-0456789'),
('Aamir Raza',        'aamir.raza@email.com',        'hash_ar_021', '0333-1567890'),
('Samina Yousuf',     'samina.yousuf@email.com',     'hash_sy_022', '0344-2678901'),
('Junaid Pervaiz',    'junaid.pervaiz@email.com',    'hash_jp_023', '0355-3789012'),
('Kiran Aslam',       'kiran.aslam@email.com',       'hash_ka_024', '0366-4890123'),
('Waseem Akram',      'waseem.akram@email.com',      'hash_wa_025', '0377-5901234');
GO

--  Buyer  
INSERT INTO Buyer (user_id, loyalty_points, preferred_payment, date_of_birth) VALUES
(1,  120,  'Credit Card',  '1995-03-12'),
(2,  350,  'EasyPaisa',    '1998-07-22'),
(3,   80,  'Cash on Del',  '1990-11-05'),
(4,  500,  'Credit Card',  '1993-01-18'),
(5,   60,  'JazzCash',     '2000-06-30'),
(6,  200,  'Debit Card',   '1997-09-14'),
(7,   15,  'Cash on Del',  '1996-04-25'),
(8,  430,  'Credit Card',  '1994-12-02'),
(9,   90,  'EasyPaisa',    '1999-08-17'),
(10, 275,  'JazzCash',     '1992-05-08'),
(11,  45,  'Debit Card',   '2001-02-28'),
(12, 680,  'Credit Card',  '1988-10-19'),
(13, 110,  'Cash on Del',  '2002-03-07'),
(14, 320,  'EasyPaisa',    '1991-07-13'),
(15,  55,  'Credit Card',  '2003-11-21');
GO

--  Seller 
INSERT INTO Seller (user_id, shop_name, description, bank_account, rating) VALUES
(16, 'TechZone PK',       'Electronics & gadgets at best prices',     'PK36HABB0000001234567890', 4.50),
(17, 'FashionHub',        'Trendy clothing for men and women',         'PK36MEZN0000002345678901', 4.20),
(18, 'HomeNest',          'Quality home & kitchen products',           'PK36MUCB0000003456789012', 3.90),
(19, 'BookWorld',         'New and used books, all genres',            'PK36BAHL0000004567890123', 4.70),
(20, 'SportsKing',        'Sports gear and fitness equipment',         'PK36HABB0000005678901234', 4.10),
(21, 'BeautyBox',         'Skincare, makeup and wellness products',    'PK36MEZN0000006789012345', 4.60),
(22, 'GroceryDirect',     'Fresh and packaged grocery items',          'PK36MUCB0000007890123456', 3.80),
(23, 'ToyLand',           'Toys and games for all ages',              'PK36BAHL0000008901234567', 4.30),
(24, 'AutoParts Plus',    'Genuine and aftermarket auto parts',        'PK36HABB0000009012345678', 3.70),
(25, 'PetCorner',         'Pet food, accessories, and care products',  'PK36MEZN0000000123456789', 4.40);
GO

--  Address 
INSERT INTO Address (user_id, street, city, country, zip_code, is_default) VALUES
(1,  'House 5, Gulberg III',          'Lahore',      'Pakistan', '54000', 1),
(2,  'Flat 12, F-8 Markaz',           'Islamabad',   'Pakistan', '44000', 1),
(3,  'Plot 7, PECHS Block 2',         'Karachi',     'Pakistan', '75400', 1),
(4,  'House 33, Hayatabad Ph-3',      'Peshawar',    'Pakistan', '25000', 1),
(5,  'Street 9, Satellite Town',      'Rawalpindi',  'Pakistan', '46000', 1),
(6,  'Bungalow 2, DHA Phase 6',       'Lahore',      'Pakistan', '54810', 1),
(7,  'Room 4, Johar Town Block Q',    'Lahore',      'Pakistan', '54782', 1),
(8,  'House 19, G-11/3',              'Islamabad',   'Pakistan', '44100', 1),
(9,  'Shop 3, Tariq Road',            'Karachi',     'Pakistan', '74400', 1),
(10, 'House 88, Bahria Town Ph-4',    'Rawalpindi',  'Pakistan', '46220', 1),
(11, 'Flat 6, Clifton Block 5',       'Karachi',     'Pakistan', '75600', 1),
(12, 'House 11, Model Town Ext.',     'Lahore',      'Pakistan', '54700', 1),
(13, 'Plot 44, I-10/2',               'Islamabad',   'Pakistan', '44000', 1),
(14, 'House 72, Askari 10',           'Lahore',      'Pakistan', '54792', 1),
(15, 'Street 17, Qasimabad',          'Hyderabad',   'Pakistan', '71000', 1),
(16, 'Office 301, MM Alam Road',      'Lahore',      'Pakistan', '54600', 1),
(17, 'Shop 14, Liberty Market',       'Lahore',      'Pakistan', '54000', 1),
(18, 'Warehouse A, I-9 Industrial',   'Islamabad',   'Pakistan', '44090', 1),
(19, 'House 9, Gulshan-e-Iqbal',      'Karachi',     'Pakistan', '75300', 1),
(20, 'Unit 7, Korangi Industrial',    'Karachi',     'Pakistan', '74900', 1),
(1,  'Office 5, Blue Area',           'Islamabad',   'Pakistan', '44000', 0),
(2,  'Flat 3, E-11/4',                'Islamabad',   'Pakistan', '44000', 0),
(3,  'House 22, North Nazimabad',     'Karachi',     'Pakistan', '74700', 0),
(4,  'House 66, Ring Road',           'Peshawar',    'Pakistan', '25124', 0),
(5,  'Plot 18, Commercial Area CDA',  'Rawalpindi',  'Pakistan', '46300', 0);
GO

--  Category
INSERT INTO Category (name, description) VALUES
('Electronics',   'Gadgets, devices, and accessories'),
('Fashion',       'Clothing, footwear, and accessories'),
('Home & Living', 'Furniture, kitchenware, and décor'),
('Books',         'Fiction, non-fiction, and educational'),
('Sports',        'Equipment, apparel, and accessories'),
('Beauty',        'Skincare, makeup, and wellness'),
('Groceries',     'Food, beverages, and daily essentials'),
('Toys & Games',  'Educational and recreational products');
GO

--  Subcategory 
INSERT INTO Subcategory (category_id, name) VALUES
(1, 'Mobile Phones'),
(1, 'Laptops'),
(1, 'Headphones'),
(1, 'Smartwatches'),
(1, 'Cameras'),
(2, 'Men Clothing'),
(2, 'Women Clothing'),
(2, 'Footwear'),
(2, 'Bags & Wallets'),
(3, 'Kitchen Appliances'),
(3, 'Bedding'),
(3, 'Home Décor'),
(3, 'Furniture'),
(4, 'Fiction'),
(4, 'Self-Help'),
(4, 'Academic'),
(5, 'Cricket'),
(5, 'Football'),
(5, 'Fitness Equipment'),
(6, 'Skincare'),
(6, 'Makeup'),
(7, 'Packaged Food'),
(7, 'Fresh Produce'),
(8, 'Board Games'),
(8, 'Educational Toys');
GO

--  Carrier
INSERT INTO Carrier (name, tracking_url, contact_email) VALUES
('TCS Courier',    'https://track.tcs.com.pk/?id=',       'support@tcs.com.pk'),
('Leopards',       'https://leopardscourier.com/track/?', 'cs@leopardscourier.com'),
('M&P Express',    'https://mpak.com/track/?id=',         'info@mpak.com'),
('BlueEx',         'https://blueex.com/tracking/?id=',    'help@blueex.com'),
('Trax Logistics', 'https://app.traxlogistics.com/?id=',  'ops@traxlogistics.com');
GO

--  Warehouse  
INSERT INTO Warehouse (name, location, capacity) VALUES
('Lahore Central WH',    'Quaid-e-Azam Industrial Estate, Lahore',   5000),
('Karachi South WH',     'Korangi Industrial Area, Karachi',          8000),
('Islamabad North WH',   'I-9 Industrial Zone, Islamabad',            3000),
('Rawalpindi WH',        'Chakra Road Industrial, Rawalpindi',        2000),
('Peshawar WH',          'Hayatabad Industrial Estate, Peshawar',     1500);
GO

--  Product 
INSERT INTO Product (seller_id, subcategory_id, name, price, stock, status) VALUES
(16,  1, 'Samsung Galaxy A55 5G',              89999.00, 120, 'active'),
(16,  2, 'HP Pavilion 15 Laptop i5',          149999.00,  45, 'active'),
(16,  3, 'Sony WH-1000XM5 Headphones',         74999.00,  60, 'active'),
(16,  4, 'Xiaomi Smart Watch Pro',             19999.00,  90, 'active'),
(16,  5, 'Canon EOS 1500D DSLR',             119999.00,  20, 'active'),
(17,  6, 'Men Linen Kurta – Navy Blue',         3499.00, 200, 'active'),
(17,  7, 'Women Lawn Suit – Floral Print',      2999.00, 350, 'active'),
(17,  8, 'Running Shoes – White (Men)',         6999.00, 150, 'active'),
(17,  9, 'Leather Messenger Bag',               5499.00,  80, 'active'),
(18, 10, 'Anex Juicer & Blender AG-179',        4999.00, 110, 'active'),
(18, 11, 'Soft Microfiber Comforter King Size', 7999.00,  70, 'active'),
(18, 12, 'Ceramic Vase Set – 3 Pieces',         2499.00, 160, 'active'),
(18, 13, 'Wooden 6-Seater Dining Table',       49999.00,  10, 'active'),
(19, 14, 'The Kite Runner – Khaled Hosseini',    999.00, 300, 'active'),
(19, 15, 'Atomic Habits – James Clear',         1299.00, 250, 'active'),
(19, 16, 'O/A Level Mathematics Guide',         1799.00, 180, 'active'),
(20, 17, 'Gray Nicolls Cricket Bat GN500',      8999.00,  55, 'active'),
(20, 18, 'Nike Strike Football Size 5',         3499.00, 100, 'active'),
(20, 19, 'Adjustable Dumbbell Set 20kg',        9999.00,  40, 'active'),
(21, 20, 'Neutrogena Hydro Boost Moisturizer',  3299.00, 220, 'active'),
(21, 21, 'Maybelline Fit Me Foundation',        2199.00, 310, 'active'),
(22, 22, 'Knorr Chicken Noodles Pack of 12',    1199.00, 500, 'active'),
(23, 24, 'Ludo & Snake Ladder Family Edition',   799.00, 130, 'active'),
(23, 25, 'Building Blocks Set 200pcs',          2499.00,  95, 'active'),
(24,  1, 'Realme C67 – 128GB',                 42999.00, 175, 'active');
GO

-- ProductImage  
INSERT INTO ProductImage (product_id, image_url) VALUES
(1,  'https://cdn.markethub.pk/products/samsung-a55-front.jpg'),
(1,  'https://cdn.markethub.pk/products/samsung-a55-back.jpg'),
(2,  'https://cdn.markethub.pk/products/hp-pavilion-15.jpg'),
(3,  'https://cdn.markethub.pk/products/sony-xm5.jpg'),
(4,  'https://cdn.markethub.pk/products/xiaomi-watch-pro.jpg'),
(5,  'https://cdn.markethub.pk/products/canon-1500d.jpg'),
(6,  'https://cdn.markethub.pk/products/linen-kurta-navy.jpg'),
(7,  'https://cdn.markethub.pk/products/lawn-suit-floral.jpg'),
(8,  'https://cdn.markethub.pk/products/running-shoes-white.jpg'),
(9,  'https://cdn.markethub.pk/products/leather-bag.jpg'),
(10, 'https://cdn.markethub.pk/products/anex-juicer.jpg'),
(11, 'https://cdn.markethub.pk/products/comforter-king.jpg'),
(12, 'https://cdn.markethub.pk/products/ceramic-vase-set.jpg'),
(13, 'https://cdn.markethub.pk/products/dining-table-wooden.jpg'),
(14, 'https://cdn.markethub.pk/products/kite-runner.jpg'),
(15, 'https://cdn.markethub.pk/products/atomic-habits.jpg'),
(16, 'https://cdn.markethub.pk/products/maths-guide.jpg'),
(17, 'https://cdn.markethub.pk/products/gn500-bat.jpg'),
(18, 'https://cdn.markethub.pk/products/nike-football.jpg'),
(19, 'https://cdn.markethub.pk/products/dumbbell-set.jpg'),
(20, 'https://cdn.markethub.pk/products/neutrogena-boost.jpg'),
(21, 'https://cdn.markethub.pk/products/maybelline-fitme.jpg'),
(22, 'https://cdn.markethub.pk/products/knorr-noodles.jpg'),
(23, 'https://cdn.markethub.pk/products/ludo-snakes.jpg'),
(24, 'https://cdn.markethub.pk/products/building-blocks.jpg');
GO

-- ProductAttribute  
INSERT INTO ProductAttribute (product_id, attr_name) VALUES
(1,  'Color: Awesome Iceblue'),
(1,  'RAM: 8GB'),
(2,  'Storage: 512GB SSD'),
(2,  'Display: 15.6 inch FHD'),
(3,  'Noise Cancellation: Yes'),
(4,  'Battery Life: 14 days'),
(5,  'Sensor: 24.1 MP APS-C'),
(6,  'Material: 100% Linen'),
(7,  'Fabric: Printed Lawn'),
(8,  'Sole: Rubber Outsole'),
(9,  'Material: Genuine Leather'),
(10, 'Power: 400W'),
(11, 'Fill: Microfiber Hollow'),
(12, 'Finish: Glossy White'),
(13, 'Wood: Sheesham Solid'),
(14, 'Language: English'),
(15, 'Format: Paperback'),
(16, 'Edition: 2024'),
(17, 'Weight: 1.2 kg'),
(18, 'Size: 5'),
(19, 'Material: Cast Iron'),
(20, 'Skin Type: All Skin Types'),
(21, 'Finish: Natural Matte'),
(22, 'Weight: 80g each'),
(23, 'Players: 2–4');
GO

-- Cart 
INSERT INTO Cart (buyer_id) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15);
GO

--  CartItem  
INSERT INTO CartItem (cart_id, product_id, quantity) VALUES
(1,  1,  1),
(1,  3,  1),
(2,  7,  2),
(2,  8,  1),
(3,  14, 1),
(3,  15, 2),
(4,  10, 1),
(4,  12, 3),
(5,  18, 1),
(5,  19, 1),
(6,  20, 2),
(6,  21, 1),
(7,  6,  1),
(7,  9,  1),
(8,  2,  1),
(8,  4,  1),
(9,  22, 4),
(9,  23, 1),
(10, 17, 1),
(10, 11, 1),
(11, 24, 1),
(12, 5,  1),
(13, 16, 2),
(14, 13, 1),
(15, 25, 2);
GO

--  Inventory 
INSERT INTO Inventory (product_id, warehouse_id, quantity, min_threshold) VALUES
(1,  1, 60,  10),
(1,  2, 60,  10),
(2,  1, 25,   5),
(2,  3, 20,   5),
(3,  1, 30,   5),
(4,  2, 50,  10),
(5,  1, 10,   3),
(6,  1, 100,  20),
(7,  1, 175,  30),
(8,  2, 75,   10),
(9,  2, 40,    5),
(10, 1, 55,   10),
(11, 1, 35,    5),
(12, 3, 80,   15),
(13, 1,  5,    2),
(14, 4, 150,  20),
(15, 4, 125,  20),
(16, 3,  90,  15),
(17, 5,  30,   5),
(18, 2,  50,   8),
(19, 2,  20,   4),
(20, 1, 110,  20),
(21, 1, 155,  25),
(22, 2, 250,  40),
(25, 3,  45,   8);
GO

-- Shipment  
INSERT INTO Shipment (carrier_id, tracking_num, shipped_at, status) VALUES
(1, 'TCS-2024-00001', '2024-11-01 10:00:00', 'delivered'),
(2, 'LEO-2024-00002', '2024-11-03 11:30:00', 'delivered'),
(3, 'MNP-2024-00003', '2024-11-05 09:00:00', 'delivered'),
(4, 'BLX-2024-00004', '2024-11-07 14:00:00', 'delivered'),
(5, 'TRX-2024-00005', '2024-11-09 08:30:00', 'delivered'),
(1, 'TCS-2024-00006', '2024-11-11 10:30:00', 'delivered'),
(2, 'LEO-2024-00007', '2024-11-13 12:00:00', 'in_transit'),
(3, 'MNP-2024-00008', '2024-11-15 09:45:00', 'dispatched'),
(4, 'BLX-2024-00009', NULL,                   'pending'),
(5, 'TRX-2024-00010', NULL,                   'pending'),
(1, 'TCS-2024-00011', '2024-11-18 13:00:00', 'delivered'),
(2, 'LEO-2024-00012', '2024-11-20 10:00:00', 'delivered'),
(3, 'MNP-2024-00013', '2024-11-22 11:30:00', 'in_transit'),
(4, 'BLX-2024-00014', NULL,                   'pending'),
(5, 'TRX-2024-00015', '2024-11-25 09:00:00', 'delivered'),
(1, 'TCS-2024-00016', '2024-11-27 14:30:00', 'delivered'),
(2, 'LEO-2024-00017', '2024-11-29 10:45:00', 'returned'),
(3, 'MNP-2024-00018', NULL,                   'pending'),
(4, 'BLX-2024-00019', '2024-12-01 08:00:00', 'dispatched'),
(5, 'TRX-2024-00020', '2024-12-03 11:00:00', 'in_transit');
GO

--  [Order] 
INSERT INTO [Order] (buyer_id, address_id, shipment_id, total_amount, status) VALUES
(1,   1,  1,  89999.00, 'delivered'),
(2,   2,  2,   5998.00, 'delivered'),
(3,   3,  3,   2298.00, 'delivered'),
(4,   4,  4,  12498.00, 'delivered'),
(5,   5,  5,  13498.00, 'delivered'),
(6,   6,  6,   5498.00, 'delivered'),
(7,   7,  7,  11498.00, 'confirmed'),
(8,   8,  8, 149999.00, 'shipped'),
(9,   9,  9,   4796.00, 'pending'),
(10, 10, 10,  12498.00, 'pending'),
(11, 11, 11,  42999.00, 'delivered'),
(12, 12, 12, 119999.00, 'delivered'),
(13, 13, 13,   3598.00, 'shipped'),
(14, 14, 14,  49999.00, 'pending'),
(15, 15, 15,   4998.00, 'delivered'),
(1,  21, 16,  74999.00, 'delivered'),
(2,  22, 17,   7998.00, 'returned'),
(3,  23, 18,   9999.00, 'pending'),
(4,  24, 19,  19999.00, 'shipped'),
(5,  25, 20,   3499.00, 'confirmed');
GO

-- Buyer_Order  
INSERT INTO Buyer_Order (buyer_id, order_id) VALUES
(1,  1),
(2,  2),
(3,  3),
(4,  4),
(5,  5),
(6,  6),
(7,  7),
(8,  8),
(9,  9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(1,  16),
(2,  17),
(3,  18),
(4,  19),
(5,  20);
GO

-- OrderItem  
INSERT INTO OrderItem (order_id, product_id, quantity, unit_price) VALUES
(1,   1,  1,  89999.00),
(2,   7,  2,   2999.00),
(3,  14,  1,    999.00),
(3,  15,  1,   1299.00),
(4,  10,  1,   4999.00),
(4,  12,  3,   2499.00),
(5,  18,  1,   3499.00),
(5,  19,  1,   9999.00),
(6,   8,  1,   6999.00),
(6,  20,  1,   3499.00),
(7,   6,  1,   3499.00),
(7,   9,  1,   5499.00),
(8,   2,  1, 149999.00),
(9,  22,  4,   1199.00),
(10, 17,  1,   8999.00),
(10, 11,  1,   7999.00),
(11, 25,  1,  42999.00),
(12,  5,  1, 119999.00),
(13, 16,  2,   1799.00),
(14, 13,  1,  49999.00),
(15, 24,  2,   2499.00),
(16,  3,  1,  74999.00),
(17,  7,  2,   2999.00),
(18, 19,  1,   9999.00),
(20, 18,  1,   3499.00);
GO

-- Payment 
INSERT INTO Payment (order_id, method, status, amount, paid_at) VALUES
(1,  'Credit Card',  'completed',  89999.00, '2024-11-01 09:45:00'),
(2,  'EasyPaisa',    'completed',   5998.00, '2024-11-03 11:00:00'),
(3,  'Cash on Del',  'completed',   2298.00, '2024-11-08 15:00:00'),
(4,  'Credit Card',  'completed',  12498.00, '2024-11-07 13:30:00'),
(5,  'JazzCash',     'completed',  13498.00, '2024-11-09 08:00:00'),
(6,  'Debit Card',   'completed',   5498.00, '2024-11-11 10:00:00'),
(7,  'Cash on Del',  'pending',    11498.00, NULL),
(8,  'Credit Card',  'completed', 149999.00, '2024-11-15 09:30:00'),
(9,  'EasyPaisa',    'pending',     4796.00, NULL),
(10, 'JazzCash',     'pending',    12498.00, NULL),
(11, 'Debit Card',   'completed',  42999.00, '2024-11-18 12:30:00'),
(12, 'Credit Card',  'completed', 119999.00, '2024-11-20 09:45:00'),
(13, 'EasyPaisa',    'completed',   3598.00, '2024-11-22 11:00:00'),
(14, 'Cash on Del',  'pending',    49999.00, NULL),
(15, 'Credit Card',  'completed',   4998.00, '2024-11-25 08:30:00'),
(16, 'Credit Card',  'completed',  74999.00, '2024-11-27 14:00:00'),
(17, 'EasyPaisa',    'refunded',    7998.00, '2024-11-29 10:30:00'),
(18, 'JazzCash',     'pending',     9999.00, NULL),
(19, 'Credit Card',  'completed',  19999.00, '2024-12-01 07:45:00'),
(20, 'Debit Card',   'completed',   3499.00, '2024-12-03 10:30:00');
GO

--[Transaction]
INSERT INTO [Transaction] (payment_id, gateway, reference_no, status) VALUES
(1,  'HBL PayConnect',   'HBL-REF-00001', 'success'),
(2,  'EasyPaisa API',    'EZP-REF-00002', 'success'),
(3,  'COD Internal',     'COD-REF-00003', 'success'),
(4,  'MCB PayGate',      'MCB-REF-00004', 'success'),
(5,  'JazzCash API',     'JZC-REF-00005', 'success'),
(6,  'Meezan PayOnline', 'MEZ-REF-00006', 'success'),
(7,  'COD Internal',     'COD-REF-00007', 'pending'),
(8,  'HBL PayConnect',   'HBL-REF-00008', 'success'),
(9,  'EasyPaisa API',    'EZP-REF-00009', 'pending'),
(10, 'JazzCash API',     'JZC-REF-00010', 'pending'),
(11, 'MCB PayGate',      'MCB-REF-00011', 'success'),
(12, 'HBL PayConnect',   'HBL-REF-00012', 'success'),
(13, 'EasyPaisa API',    'EZP-REF-00013', 'success'),
(14, 'COD Internal',     'COD-REF-00014', 'pending'),
(15, 'HBL PayConnect',   'HBL-REF-00015', 'success'),
(16, 'MCB PayGate',      'MCB-REF-00016', 'success'),
(17, 'EasyPaisa API',    'EZP-REF-00017', 'failed'),
(18, 'JazzCash API',     'JZC-REF-00018', 'pending'),
(19, 'HBL PayConnect',   'HBL-REF-00019', 'success'),
(20, 'Meezan PayOnline', 'MEZ-REF-00020', 'success');
GO

-- Review 
INSERT INTO Review (buyer_id, product_id, rating, comment) VALUES
(1,   1, 5, 'Excellent phone! Battery life is outstanding, camera is top notch.'),
(2,   7, 4, 'Fabric quality is great, stitching could be a bit better.'),
(3,  14, 5, 'A masterpiece. Cannot put it down!'),
(4,  10, 4, 'Works perfectly. Makes juice in seconds. Easy to clean.'),
(5,  18, 5, 'Great football, holds air really well. Good grip on the field.'),
(6,   8, 3, 'Decent shoes, but sizing runs a bit small. Order one size up.'),
(7,   6, 4, 'Comfortable kurta, colour is exactly as shown in the picture.'),
(8,   2, 5, 'Fast laptop, smooth performance for work and editing.'),
(9,  22, 4, 'Great taste and very convenient for quick meals.'),
(10, 17, 4, 'Bat has a good pickup, great for club-level cricket.'),
(11, 25, 5, 'My son loves it! Keeps him busy for hours. Worth every rupee.'),
(12,  5, 5, 'Superb camera. Photos are razor sharp. Highly recommended.'),
(13, 16, 4, 'Clear explanations. Helped me prepare well for exams.'),
(14, 13, 3, 'Good quality table but delivery took longer than expected.'),
(15, 24, 5, 'Great building blocks, my daughter enjoys playing with them.'),
(1,   3, 5, 'The noise cancellation is incredible. Worth every penny.'),
(2,  15, 5, 'Life-changing book. Very practical and inspiring.'),
(3,  12, 4, 'Beautiful vases, nice addition to our living room decor.'),
(4,  11, 4, 'Very soft and warm. Exactly what was needed for winter.'),
(5,   4, 4, 'Stylish watch with many useful features. Battery lasts long.');
GO
