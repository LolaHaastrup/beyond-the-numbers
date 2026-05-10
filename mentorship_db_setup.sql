-- ============================================================
-- MENTORSHIP_DB — Practice Dataset
-- Data Analytics 
-- ============================================================
-- HOW TO USE:
-- 1. Open DBeaver and connect to your MySQL server
-- 2. Open a new SQL Console
-- 3. Copy and paste this entire file into the console
-- 4. Press Ctrl+Enter (or click the Run button) to execute
-- 5. Check the Database Navigator — you should see
--    mentorship_db with 4 tables inside
-- ============================================================

-- Create and select the database
CREATE DATABASE IF NOT EXISTS mentorship_db;
USE mentorship_db;

-- Drop tables if they already exist (safe re-run)
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS branches;
DROP TABLE IF EXISTS customers;


-- ============================================================
-- TABLE 1: customers
-- ============================================================
CREATE TABLE customers (
    customer_id     INT PRIMARY KEY,
    name            VARCHAR(100),
    account_type    VARCHAR(20),   -- 'savings' or 'current'
    state           VARCHAR(50),
    date_joined     DATE
);

INSERT INTO customers VALUES
(1,  'Chukwuemeka Obi',       'savings', 'Lagos',        '2019-03-15'),
(2,  'Fatima Aliyu',           'current', 'Kano',         '2020-07-22'),
(3,  'Bola Adeyemi',           'savings', 'Lagos',        '2021-01-10'),
(4,  'Ngozi Eze',              'savings', 'Enugu',        '2021-04-05'),
(5,  'Musa Ibrahim',           'current', 'Abuja',        '2018-11-30'),
(6,  'Amaka Nwosu',            'savings', 'Lagos',        '2021-06-18'),
(7,  'Tunde Fashola',          'savings', 'Ogun',         '2022-02-14'),
(8,  'Halima Bello',           'current', 'Kaduna',       '2020-09-01'),
(9,  'Emeka Dike',             'savings', 'Anambra',      '2021-08-25'),
(10, 'Sola Adesanya',          'current', 'Lagos',        '2019-05-12'),
(11, 'Zainab Yusuf',           'savings', 'Kano',         '2021-03-30'),
(12, 'Chidi Okonkwo',          'current', 'Rivers',       '2020-12-20'),
(13, 'Aisha Mohammed',         'savings', 'Abuja',        '2022-01-07'),
(14, 'Kunle Bakare',           'savings', 'Lagos',        '2021-11-19'),
(15, 'Obiageli Nwachukwu',     'current', 'Imo',          '2020-06-03'),
(16, 'Yusuf Garba',            'savings', 'Kano',         '2021-02-28'),
(17, 'Adaeze Okafor',          'savings', 'Enugu',        '2022-05-16'),
(18, 'Rotimi Adeleke',         'current', 'Oyo',          '2019-08-09'),
(19, 'Blessing Effiong',       'savings', 'Lagos',        '2021-07-04'),
(20, 'Salisu Musa',            'current', 'Kaduna',       '2020-10-11'),
(21, 'Chiamaka Aneke',         'savings', 'Lagos',        '2021-09-22'),
(22, 'Danjuma Lawal',          'current', 'Abuja',        '2018-04-17'),
(23, 'Ifeoma Ugwu',            'savings', 'Enugu',        '2022-03-08'),
(24, 'Babatunde Ogunleye',     'savings', 'Lagos',        '2021-12-01'),
(25, 'Rakiya Suleiman',        'current', 'Kano',         '2020-05-25'),
(26, 'Chinedu Eze',            'savings', 'Anambra',      '2021-10-14'),
(27, 'Folashade Adebayo',      'savings', 'Ogun',         '2022-04-20'),
(28, 'Usman Maikudi',          'current', 'Kaduna',       '2019-07-31'),
(29, 'Nkechi Obi',             'savings', 'Lagos',        '2021-05-17'),
(30, 'Emmanuel Akpan',         'current', 'Rivers',       '2020-03-06'),
(31, 'Hauwa Sani',             'savings', 'Abuja',        '2022-06-12'),
(32, 'Tochukwu Nweze',         'savings', 'Imo',          '2021-08-08'),
(33, 'Opeyemi Olawale',        'current', 'Lagos',        '2019-02-21'),
(34, 'Abdullahi Tanko',        'savings', 'Kaduna',       '2021-04-30'),
(35, 'Chisom Onyeka',          'savings', 'Enugu',        '2022-07-03'),
(36, 'Ayodele Bankole',        'current', 'Oyo',          '2020-01-15'),
(37, 'Maryam Abdullahi',       'savings', 'Kano',         '2021-06-09'),
(38, 'Ifeanyi Osuji',          'savings', 'Anambra',      '2021-11-27'),
(39, 'Grace Okonkwo',          'current', 'Rivers',       '2020-08-19'),
(40, 'Seun Adeniyi',           'savings', 'Lagos',        '2021-03-03');


-- ============================================================
-- TABLE 2: branches
-- ============================================================
CREATE TABLE branches (
    branch_id       INT PRIMARY KEY,
    branch_name     VARCHAR(100),
    state           VARCHAR(50),
    region          VARCHAR(30)   -- North, South-West, South-East, South-South
);

INSERT INTO branches VALUES
(1,  'Lagos Island Main',      'Lagos',    'South-West'),
(2,  'Ikeja Commercial',       'Lagos',    'South-West'),
(3,  'Victoria Island',        'Lagos',    'South-West'),
(4,  'Surulere',               'Lagos',    'South-West'),
(5,  'Kano Central',           'Kano',     'North'),
(6,  'Kaduna Main',            'Kaduna',   'North'),
(7,  'Abuja Central',          'Abuja',    'North'),
(8,  'Wuse 2',                 'Abuja',    'North'),
(9,  'Enugu Main',             'Enugu',    'South-East'),
(10, 'Onitsha',                'Anambra',  'South-East'),
(11, 'Owerri',                 'Imo',      'South-East'),
(12, 'Port Harcourt Main',     'Rivers',   'South-South'),
(13, 'GRA Port Harcourt',      'Rivers',   'South-South'),
(14, 'Ibadan Main',            'Oyo',      'South-West'),
(15, 'Sagamu',                 'Ogun',     'South-West');


-- ============================================================
-- TABLE 3: transactions
-- ============================================================
CREATE TABLE transactions (
    txn_id          INT PRIMARY KEY,
    customer_id     INT,
    txn_date        DATE,
    txn_type        VARCHAR(20),   -- 'deposit', 'withdrawal', 'transfer'
    amount          DECIMAL(15,2),
    branch_id       INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id)   REFERENCES branches(branch_id)
);

INSERT INTO transactions VALUES
-- Lagos customers (high volume)
(1001, 1,  '2023-01-05', 'deposit',    1500000.00, 1),
(1002, 1,  '2023-03-12', 'withdrawal',  450000.00, 2),
(1003, 1,  '2023-06-20', 'deposit',    2200000.00, 1),
(1004, 1,  '2023-09-14', 'transfer',    800000.00, 3),
(1005, 3,  '2023-02-08', 'deposit',     320000.00, 2),
(1006, 3,  '2023-05-19', 'deposit',     780000.00, 2),
(1007, 3,  '2023-08-30', 'withdrawal',  150000.00, 4),
(1008, 6,  '2023-01-22', 'deposit',    4500000.00, 3),
(1009, 6,  '2023-04-11', 'deposit',    3200000.00, 3),
(1010, 6,  '2023-07-07', 'transfer',   1100000.00, 1),
(1011, 10, '2023-02-14', 'deposit',     950000.00, 4),
(1012, 10, '2023-06-01', 'withdrawal',  200000.00, 2),
(1013, 14, '2023-03-25', 'deposit',    1800000.00, 1),
(1014, 14, '2023-08-16', 'deposit',    2600000.00, 2),
(1015, 19, '2023-01-30', 'deposit',     500000.00, 4),
(1016, 19, '2023-05-05', 'transfer',    300000.00, 3),
(1017, 21, '2023-04-18', 'deposit',    1200000.00, 1),
(1018, 21, '2023-09-22', 'withdrawal',  400000.00, 2),
(1019, 24, '2023-02-27', 'deposit',    3100000.00, 3),
(1020, 24, '2023-07-15', 'deposit',    1700000.00, 1),
(1021, 29, '2023-03-09', 'deposit',     680000.00, 4),
(1022, 29, '2023-06-28', 'transfer',    220000.00, 2),
(1023, 33, '2023-01-17', 'deposit',    5500000.00, 1),
(1024, 33, '2023-04-24', 'withdrawal', 1000000.00, 3),
(1025, 33, '2023-08-03', 'deposit',    2900000.00, 2),
(1026, 40, '2023-02-11', 'deposit',     740000.00, 4),
(1027, 40, '2023-07-29', 'deposit',     560000.00, 1),
-- Kano customers
(1028, 2,  '2023-01-14', 'deposit',     900000.00, 5),
(1029, 2,  '2023-05-22', 'transfer',    350000.00, 5),
(1030, 11, '2023-02-03', 'deposit',     420000.00, 5),
(1031, 11, '2023-06-17', 'deposit',     630000.00, 5),
(1032, 16, '2023-03-28', 'deposit',    1100000.00, 5),
(1033, 16, '2023-09-05', 'withdrawal',  280000.00, 5),
(1034, 25, '2023-04-13', 'deposit',     750000.00, 5),
(1035, 25, '2023-08-21', 'transfer',    490000.00, 5),
(1036, 37, '2023-01-26', 'deposit',     510000.00, 5),
(1037, 37, '2023-07-08', 'deposit',     830000.00, 5),
-- Abuja customers
(1038, 5,  '2023-02-19', 'deposit',    2800000.00, 7),
(1039, 5,  '2023-06-06', 'withdrawal',  700000.00, 8),
(1040, 5,  '2023-09-18', 'deposit',    1900000.00, 7),
(1041, 13, '2023-01-31', 'deposit',     660000.00, 8),
(1042, 13, '2023-05-14', 'transfer',    180000.00, 7),
(1043, 22, '2023-03-07', 'deposit',    4200000.00, 7),
(1044, 22, '2023-07-24', 'deposit',    3300000.00, 8),
(1045, 31, '2023-04-02', 'deposit',     870000.00, 7),
(1046, 31, '2023-08-11', 'withdrawal',  230000.00, 8),
-- Kaduna customers
(1047, 8,  '2023-01-09', 'deposit',     590000.00, 6),
(1048, 8,  '2023-06-23', 'transfer',    310000.00, 6),
(1049, 20, '2023-02-16', 'deposit',     440000.00, 6),
(1050, 20, '2023-07-01', 'deposit',     720000.00, 6),
(1051, 28, '2023-03-21', 'deposit',    1300000.00, 6),
(1052, 28, '2023-09-09', 'withdrawal',  460000.00, 6),
(1053, 34, '2023-04-28', 'deposit',     380000.00, 6),
(1054, 34, '2023-08-06', 'deposit',     550000.00, 6),
-- Enugu customers
(1055, 4,  '2023-01-20', 'deposit',     810000.00, 9),
(1056, 4,  '2023-05-08', 'transfer',    290000.00, 9),
(1057, 17, '2023-02-25', 'deposit',     470000.00, 9),
(1058, 17, '2023-07-13', 'deposit',     640000.00, 9),
(1059, 23, '2023-03-16', 'deposit',     920000.00, 9),
(1060, 23, '2023-08-27', 'withdrawal',  340000.00, 9),
(1061, 35, '2023-04-07', 'deposit',     560000.00, 9),
(1062, 35, '2023-09-01', 'deposit',     780000.00, 9),
-- Anambra customers
(1063, 9,  '2023-02-04', 'deposit',     670000.00, 10),
(1064, 9,  '2023-06-11', 'transfer',    240000.00, 10),
(1065, 26, '2023-03-19', 'deposit',     530000.00, 10),
(1066, 26, '2023-08-14', 'deposit',     890000.00, 10),
(1067, 38, '2023-01-28', 'deposit',     410000.00, 10),
(1068, 38, '2023-07-20', 'deposit',     730000.00, 10),
-- Rivers customers
(1069, 12, '2023-02-10', 'deposit',    1600000.00, 12),
(1070, 12, '2023-06-29', 'withdrawal',  520000.00, 13),
(1071, 30, '2023-03-23', 'deposit',     850000.00, 12),
(1072, 30, '2023-08-04', 'deposit',    1100000.00, 13),
(1073, 39, '2023-01-15', 'deposit',     480000.00, 12),
(1074, 39, '2023-07-10', 'transfer',    270000.00, 13),
-- Oyo customers
(1075, 18, '2023-02-22', 'deposit',     960000.00, 14),
(1076, 18, '2023-07-06', 'withdrawal',  350000.00, 14),
(1077, 36, '2023-04-15', 'deposit',    1400000.00, 14),
(1078, 36, '2023-09-11', 'deposit',     780000.00, 14),
-- Ogun / Imo customers
(1079, 7,  '2023-03-01', 'deposit',     620000.00, 15),
(1080, 7,  '2023-08-18', 'deposit',     990000.00, 15),
(1081, 27, '2023-04-26', 'deposit',     540000.00, 15),
(1082, 27, '2023-09-15', 'transfer',    310000.00, 15),
(1083, 15, '2023-02-07', 'deposit',     730000.00, 11),
(1084, 15, '2023-07-25', 'deposit',    1050000.00, 11),
(1085, 32, '2023-03-12', 'deposit',     490000.00, 11),
(1086, 32, '2023-08-30', 'withdrawal',  160000.00, 11),
-- Additional 2022 transactions (for year-filter questions)
(2001, 1,  '2022-04-10', 'deposit',     750000.00, 1),
(2002, 6,  '2022-09-18', 'deposit',    2100000.00, 3),
(2003, 10, '2022-11-05', 'withdrawal',  300000.00, 4),
(2004, 5,  '2022-06-14', 'deposit',    1200000.00, 7),
(2005, 22, '2022-08-27', 'deposit',    3600000.00, 7),
(2006, 33, '2022-03-02', 'deposit',    4800000.00, 1),
(2007, 2,  '2022-07-19', 'deposit',     680000.00, 5),
(2008, 12, '2022-10-08', 'deposit',     920000.00, 12);


-- ============================================================
-- TABLE 4: products
-- ============================================================
CREATE TABLE products (
    product_id      INT PRIMARY KEY,
    customer_id     INT,
    product_name    VARCHAR(50),   -- 'savings_account', 'loan', 'fixed_deposit', 'current_account'
    date_opened     DATE,
    status          VARCHAR(10),   -- 'active' or 'closed'
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO products VALUES
-- Customers with savings accounts only (no loans) — useful for Q4
(101,  3,  'savings_account', '2021-01-10', 'active'),
(102,  6,  'savings_account', '2021-06-18', 'active'),
(103,  7,  'savings_account', '2022-02-14', 'active'),
(104,  11, 'savings_account', '2021-03-30', 'active'),
(105,  17, 'savings_account', '2022-05-16', 'active'),
(106,  21, 'savings_account', '2021-09-22', 'active'),
(107,  26, 'savings_account', '2021-10-14', 'active'),
(108,  27, 'savings_account', '2022-04-20', 'active'),
(109,  29, 'savings_account', '2021-05-17', 'active'),
(110,  31, 'savings_account', '2022-06-12', 'active'),
(111,  34, 'savings_account', '2021-04-30', 'active'),
(112,  35, 'savings_account', '2022-07-03', 'active'),
(113,  37, 'savings_account', '2021-06-09', 'active'),
(114,  40, 'savings_account', '2021-03-03', 'active'),
-- Customers with savings + loan
(115,  1,  'savings_account', '2019-03-15', 'active'),
(116,  1,  'loan',            '2020-08-01', 'active'),
(117,  4,  'savings_account', '2021-04-05', 'active'),
(118,  4,  'loan',            '2022-02-10', 'active'),
(119,  9,  'savings_account', '2021-08-25', 'active'),
(120,  9,  'loan',            '2022-09-15', 'active'),
(121,  13, 'savings_account', '2022-01-07', 'active'),
(122,  13, 'loan',            '2022-11-20', 'active'),
(123,  14, 'savings_account', '2021-11-19', 'active'),
(124,  14, 'loan',            '2023-01-05', 'active'),
(125,  19, 'savings_account', '2021-07-04', 'active'),
(126,  19, 'loan',            '2022-06-30', 'closed'),
(127,  23, 'savings_account', '2022-03-08', 'active'),
(128,  23, 'loan',            '2023-02-14', 'active'),
(129,  24, 'savings_account', '2021-12-01', 'active'),
(130,  24, 'loan',            '2022-07-22', 'active'),
-- Customers with savings + fixed deposit
(131,  16, 'savings_account', '2021-02-28', 'active'),
(132,  16, 'fixed_deposit',   '2022-05-01', 'active'),
(133,  32, 'savings_account', '2021-08-08', 'active'),
(134,  32, 'fixed_deposit',   '2023-01-15', 'active'),
(135,  38, 'savings_account', '2021-11-27', 'active'),
(136,  38, 'fixed_deposit',   '2022-10-10', 'active'),
-- Current account customers
(137,  2,  'current_account', '2020-07-22', 'active'),
(138,  5,  'current_account', '2018-11-30', 'active'),
(139,  5,  'loan',            '2021-04-01', 'active'),
(140,  8,  'current_account', '2020-09-01', 'active'),
(141,  10, 'current_account', '2019-05-12', 'active'),
(142,  12, 'current_account', '2020-12-20', 'active'),
(143,  12, 'loan',            '2021-09-08', 'closed'),
(144,  15, 'current_account', '2020-06-03', 'active'),
(145,  18, 'current_account', '2019-08-09', 'active'),
(146,  20, 'current_account', '2020-10-11', 'active'),
(147,  22, 'current_account', '2018-04-17', 'active'),
(148,  22, 'loan',            '2019-12-01', 'active'),
(149,  25, 'current_account', '2020-05-25', 'active'),
(150,  28, 'current_account', '2019-07-31', 'active'),
(151,  28, 'loan',            '2021-08-15', 'active'),
(152,  30, 'current_account', '2020-03-06', 'active'),
(153,  33, 'current_account', '2019-02-21', 'active'),
(154,  33, 'fixed_deposit',   '2022-01-10', 'active'),
(155,  36, 'current_account', '2020-01-15', 'active'),
(156,  39, 'current_account', '2020-08-19', 'active');


-- ============================================================
-- VERIFICATION QUERIES
-- Run these to confirm everything loaded correctly
-- ============================================================
SELECT 'customers'    AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'branches',    COUNT(*) FROM branches
UNION ALL
SELECT 'transactions',COUNT(*) FROM transactions
UNION ALL
SELECT 'products',    COUNT(*) FROM products;

-- Expected output:
-- customers     | 40
-- branches      | 15
-- transactions  | 94
-- products      | 56

-- ============================================================
-- QUICK DATA PREVIEW
-- ============================================================
SELECT 'Sample from customers:' AS info;
SELECT customer_id, name, account_type, state, date_joined
FROM customers LIMIT 5;

SELECT 'Sample from transactions:' AS info;
SELECT txn_id, customer_id, txn_date, txn_type, amount, branch_id
FROM transactions LIMIT 5;
