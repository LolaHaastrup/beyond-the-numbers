-- ============================================================
-- MENTORSHIP_DB — Week 2 Data Refresh
-- Data Analytics Mentorship 
-- ============================================================
-- IMPORTANT: Run this AFTER your Week 1 setup script.
-- If you have already run the Week 1 script, this file adds
-- more transactions to make all 10 Week 2 queries return
-- rich, meaningful results.
--
-- If you are starting fresh, run the Week 1 setup script
-- (mentorship_db_setup.sql) first, then run this file.
-- ============================================================

USE mentorship_db;

-- ============================================================
-- STEP 1: Add more monthly transactions for 2023
-- This ensures Q7 (monthly breakdown) returns data for
-- every month and shows a clear seasonal pattern.
-- ============================================================

INSERT INTO transactions VALUES
-- January 2023 (already has some — adding more)
(1101, 14, '2023-01-03', 'deposit',    2100000.00, 1),
(1102, 33, '2023-01-08', 'deposit',    3400000.00, 2),
(1103, 22, '2023-01-11', 'deposit',    1800000.00, 7),
(1104, 6,  '2023-01-16', 'withdrawal',  600000.00, 3),
(1105, 5,  '2023-01-20', 'deposit',    2500000.00, 8),
(1106, 1,  '2023-01-25', 'transfer',    400000.00, 1),
(1107, 12, '2023-01-28', 'deposit',    1200000.00, 12),

-- February 2023
(1108, 24, '2023-02-02', 'deposit',    1600000.00, 3),
(1109, 10, '2023-02-06', 'withdrawal',  350000.00, 2),
(1110, 19, '2023-02-10', 'deposit',     780000.00, 4),
(1111, 33, '2023-02-15', 'deposit',    2200000.00, 1),
(1112, 5,  '2023-02-18', 'transfer',    900000.00, 7),
(1113, 36, '2023-02-23', 'deposit',    1050000.00, 14),
(1114, 22, '2023-02-27', 'deposit',    2700000.00, 8),

-- March 2023
(1115, 6,  '2023-03-04', 'deposit',    3100000.00, 3),
(1116, 1,  '2023-03-08', 'deposit',    1400000.00, 2),
(1117, 14, '2023-03-13', 'withdrawal',  500000.00, 1),
(1118, 22, '2023-03-17', 'deposit',    3900000.00, 7),
(1119, 30, '2023-03-21', 'deposit',     720000.00, 13),
(1120, 39, '2023-03-25', 'deposit',     480000.00, 12),
(1121, 18, '2023-03-29', 'transfer',    640000.00, 14),

-- April 2023
(1122, 33, '2023-04-03', 'deposit',    4100000.00, 1),
(1123, 6,  '2023-04-07', 'deposit',    2800000.00, 3),
(1124, 24, '2023-04-12', 'withdrawal',  700000.00, 2),
(1125, 5,  '2023-04-16', 'deposit',    3200000.00, 7),
(1126, 10, '2023-04-20', 'deposit',    1100000.00, 4),
(1127, 16, '2023-04-24', 'transfer',    420000.00, 5),
(1128, 23, '2023-04-28', 'deposit',     860000.00, 9),

-- May 2023
(1129, 1,  '2023-05-02', 'deposit',    1700000.00, 1),
(1130, 22, '2023-05-06', 'deposit',    2900000.00, 8),
(1131, 33, '2023-05-10', 'withdrawal', 1100000.00, 2),
(1132, 14, '2023-05-14', 'deposit',    2400000.00, 1),
(1133, 6,  '2023-05-18', 'deposit',    3600000.00, 3),
(1134, 12, '2023-05-22', 'transfer',    540000.00, 13),
(1135, 28, '2023-05-26', 'deposit',     960000.00, 6),

-- June 2023
(1136, 5,  '2023-06-01', 'deposit',    4400000.00, 7),
(1137, 24, '2023-06-05', 'deposit',    2200000.00, 3),
(1138, 33, '2023-06-09', 'deposit',    3800000.00, 1),
(1139, 22, '2023-06-13', 'withdrawal',  800000.00, 7),
(1140, 1,  '2023-06-17', 'deposit',    1500000.00, 2),
(1141, 10, '2023-06-21', 'deposit',     870000.00, 4),
(1142, 36, '2023-06-25', 'deposit',    1300000.00, 14),
(1143, 21, '2023-06-29', 'transfer',    310000.00, 1),

-- July 2023 (mid-year — typically lower)
(1144, 14, '2023-07-04', 'deposit',    1100000.00, 1),
(1145, 6,  '2023-07-08', 'deposit',    1900000.00, 3),
(1146, 22, '2023-07-12', 'deposit',    2100000.00, 7),
(1147, 5,  '2023-07-16', 'withdrawal',  600000.00, 8),
(1148, 33, '2023-07-20', 'deposit',    2600000.00, 2),
(1149, 3,  '2023-07-24', 'deposit',     540000.00, 4),
(1150, 9,  '2023-07-28', 'transfer',    290000.00, 10),

-- August 2023
(1151, 1,  '2023-08-02', 'deposit',    1300000.00, 1),
(1152, 24, '2023-08-06', 'deposit',    2500000.00, 2),
(1153, 5,  '2023-08-10', 'deposit',    3700000.00, 7),
(1154, 22, '2023-08-14', 'withdrawal',  950000.00, 8),
(1155, 6,  '2023-08-18', 'deposit',    4200000.00, 3),
(1156, 15, '2023-08-22', 'deposit',     830000.00, 11),
(1157, 26, '2023-08-26', 'transfer',    460000.00, 10),

-- September 2023
(1158, 33, '2023-09-02', 'deposit',    3300000.00, 1),
(1159, 14, '2023-09-06', 'deposit',    2900000.00, 2),
(1160, 22, '2023-09-10', 'deposit',    4100000.00, 7),
(1161, 6,  '2023-09-14', 'withdrawal',  700000.00, 3),
(1162, 1,  '2023-09-18', 'deposit',    1600000.00, 1),
(1163, 30, '2023-09-22', 'deposit',     990000.00, 12),
(1164, 37, '2023-09-26', 'deposit',    1100000.00, 5),

-- October 2023 (pre-festive build-up — higher deposits)
(1165, 5,  '2023-10-03', 'deposit',    5100000.00, 7),
(1166, 33, '2023-10-07', 'deposit',    4700000.00, 1),
(1167, 22, '2023-10-11', 'deposit',    5500000.00, 8),
(1168, 6,  '2023-10-15', 'deposit',    4900000.00, 3),
(1169, 24, '2023-10-19', 'deposit',    3200000.00, 2),
(1170, 1,  '2023-10-23', 'deposit',    2800000.00, 1),
(1171, 14, '2023-10-27', 'deposit',    3600000.00, 2),
(1172, 10, '2023-10-31', 'transfer',   1400000.00, 4),

-- November 2023 (festive season — highest deposits)
(1173, 33, '2023-11-02', 'deposit',    6200000.00, 1),
(1174, 22, '2023-11-05', 'deposit',    5900000.00, 7),
(1175, 5,  '2023-11-08', 'deposit',    6800000.00, 8),
(1176, 6,  '2023-11-11', 'deposit',    5400000.00, 3),
(1177, 24, '2023-11-14', 'deposit',    4100000.00, 2),
(1178, 1,  '2023-11-17', 'deposit',    3700000.00, 1),
(1179, 14, '2023-11-20', 'deposit',    4500000.00, 2),
(1180, 22, '2023-11-23', 'withdrawal', 1200000.00, 7),
(1181, 12, '2023-11-26', 'deposit',    2100000.00, 13),
(1182, 18, '2023-11-29', 'deposit',    1800000.00, 14),

-- December 2023 (year-end — high withdrawals for spending)
(1183, 33, '2023-12-02', 'deposit',    3900000.00, 1),
(1184, 22, '2023-12-05', 'withdrawal', 2100000.00, 7),
(1185, 5,  '2023-12-08', 'deposit',    4300000.00, 8),
(1186, 6,  '2023-12-11', 'withdrawal', 1800000.00, 3),
(1187, 24, '2023-12-14', 'deposit',    2700000.00, 2),
(1188, 1,  '2023-12-17', 'withdrawal', 1100000.00, 1),
(1189, 14, '2023-12-20', 'deposit',    3200000.00, 1),
(1190, 10, '2023-12-23', 'withdrawal',  900000.00, 4),
(1191, 33, '2023-12-27', 'withdrawal', 1500000.00, 2),
(1192, 22, '2023-12-30', 'deposit',    2400000.00, 7);


-- ============================================================
-- STEP 2: Add products for customers who currently have none
-- This ensures Q10 (products cross-sell) returns
-- meaningful data for the top 10 customers.
-- ============================================================

INSERT INTO products VALUES
-- Top customers who were missing products
(201, 33, 'current_account', '2019-02-21', 'active'),
(202, 33, 'fixed_deposit',   '2021-06-15', 'active'),
(203, 22, 'current_account', '2018-04-17', 'active'),
(204, 22, 'loan',            '2020-03-10', 'active'),
(205, 5,  'loan',            '2020-09-01', 'active'),
(206, 5,  'fixed_deposit',   '2022-02-28', 'active'),
(207, 6,  'savings_account', '2021-06-18', 'active'),
(208, 6,  'loan',            '2022-11-05', 'active'),
(209, 24, 'savings_account', '2021-12-01', 'active'),
(210, 24, 'fixed_deposit',   '2023-03-15', 'active'),
(211, 14, 'savings_account', '2021-11-19', 'active'),
(212, 10, 'current_account', '2019-05-12', 'active'),
(213, 1,  'fixed_deposit',   '2022-04-20', 'active'),
-- Savings-only customers with no loan (useful for Q8 from Week 1 + cross-sell)
(214, 11, 'fixed_deposit',   '2023-02-01', 'active'),
(215, 37, 'fixed_deposit',   '2022-08-10', 'active'),
(216, 40, 'loan',            '2023-04-12', 'active'),
(217, 29, 'fixed_deposit',   '2022-12-05', 'active'),
(218, 21, 'loan',            '2023-05-20', 'active'),
(219, 31, 'fixed_deposit',   '2022-09-30', 'active'),
(220, 35, 'loan',            '2023-06-01', 'active');


-- ============================================================
-- VERIFICATION
-- Run this to confirm everything loaded correctly.
-- ============================================================
SELECT
    'customers'     AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL SELECT 'branches',     COUNT(*) FROM branches
UNION ALL SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL SELECT 'products',     COUNT(*) FROM products;

-- Expected after BOTH scripts:
-- customers     | 40
-- branches      | 15
-- transactions  | 192  (94 from Week 1 + 98 new)
-- products      | 76   (56 from Week 1 + 20 new)


-- ============================================================
-- QUICK QUERY PREVIEWS
-- Run these to confirm your 10 Week 2 queries will work.
-- ============================================================

-- Q7 preview: monthly deposit pattern should show Nov as peak
SELECT
    MONTHNAME(txn_date) AS month,
    SUM(amount)         AS total_deposits
FROM transactions
WHERE txn_type = 'deposit'
  AND YEAR(txn_date) = 2023
GROUP BY MONTH(txn_date), MONTHNAME(txn_date)
ORDER BY MONTH(txn_date);

-- Q10 preview: top customers and their products
SELECT
    c.name,
    SUM(t.amount)  AS total_2023,
    p.product_name
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN products  p ON c.customer_id = p.customer_id
WHERE YEAR(t.txn_date) = 2023
GROUP BY c.customer_id, c.name, p.product_name
ORDER BY total_2023 DESC
LIMIT 15;
