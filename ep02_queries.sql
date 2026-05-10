-- ============================================================
-- BEYOND THE NUMBERS 
-- Your First SQL Query — Using Real Nigerian Banking Data
-- youtube.com/@Beyond_d_Numbers | Omolola Haastrup
-- ============================================================
-- HOW TO USE THIS FILE:
-- 1. Make sure you have run mentorship_db_setup.sql first
-- 2. Select a query block and press Ctrl+Enter to run it
-- 3. Read the -- So what: comment after every result
-- 4. Write your OWN so what before reading mine
-- ============================================================

USE mentorship_db;


-- ============================================================
-- BEFORE YOU START — 5 exploration queries
-- Run these to get familiar with the database before the lesson
-- ============================================================

-- Preview the customers table
SELECT * FROM customers LIMIT 10;

-- Preview the transactions table
SELECT * FROM transactions LIMIT 10;

-- Preview the branches table
SELECT * FROM branches;

-- Preview the products table
SELECT * FROM products LIMIT 10;

-- How many rows does each table have?
SELECT 'customers'    AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'transactions',               COUNT(*)              FROM transactions
UNION ALL
SELECT 'branches',                   COUNT(*)              FROM branches
UNION ALL
SELECT 'products',                   COUNT(*)              FROM products;


-- ============================================================
-- QUERY 1 — SELECT + FROM
-- Business question: What are the names and states of all
-- our customers?
-- ============================================================

SELECT
    name,
    state
FROM customers;

-- So what: This query returns all 40 customers showing where
-- they are based. At a glance we can see that Lagos and
-- northern states (Kano, Kaduna) dominate the customer list.
-- Before running any marketing campaign, this is the first
-- query to run — you need to know who your customers are
-- and where they are before you can segment them.

-- ── Key lesson ───────────────────────────────────────────────
-- SELECT * returns EVERY column — avoid it in real work.
-- Always name the columns you actually need. It is faster,
-- cleaner, and tells the next analyst exactly what you wanted.
-- Wrong:  SELECT * FROM customers;
-- Right:  SELECT name, state FROM customers;


-- ============================================================
-- QUERY 2 — WHERE + AND
-- Business question: How many customers do we have in Lagos
-- with a savings account — and who are they?
-- ============================================================

SELECT
    name,
    account_type,
    date_joined
FROM customers
WHERE state         = 'Lagos'
  AND account_type  = 'savings'
ORDER BY date_joined DESC;

-- So what: 10 of our 40 customers are Lagos savings holders —
-- 25% of the customer base. For a targeted loyalty or upsell
-- campaign (e.g. a fixed deposit promotion), this is your
-- starting list. Sending the campaign to all 40 customers
-- would mean 75% wasted reach and higher cost per conversion.
-- Precision targeting starts with a precise WHERE clause.

-- ── Key lesson ───────────────────────────────────────────────
-- WHERE rules to remember:
--   Text values:  use single quotes  WHERE state = 'Lagos'
--   Numbers:      no quotes          WHERE amount > 1000000
--   AND:          narrows results    (must match ALL conditions)
--   OR:           widens results     (must match ANY condition)
--   Dates:        quote them         WHERE date_joined > '2021-01-01'


-- ============================================================
-- QUERY 3 — COUNT + GROUP BY + ORDER BY
-- Business question: How many customers do we have in each
-- state — and which state has the most?
-- ============================================================

SELECT
    state,
    COUNT(customer_id) AS num_customers
FROM customers
GROUP BY state
ORDER BY num_customers DESC;

-- So what: Lagos holds 12 customers — 30% of the entire base,
-- more than Kano (5) and Abuja (4) combined. Any national
-- initiative must weight Lagos branch operations heavily.
-- States like Rivers and Anambra each have only 3 customers —
-- these represent untapped growth markets where a targeted
-- acquisition push could meaningfully move the needle without
-- competing for already-saturated Lagos customers.


-- ============================================================
-- QUERY 4 — Adding more columns to GROUP BY
-- Business question: How many savings vs current account
-- customers do we have in each state?
-- ============================================================

SELECT
    state,
    account_type,
    COUNT(customer_id) AS num_customers
FROM customers
GROUP BY state, account_type
ORDER BY state, num_customers DESC;

-- So what: This tells us not just where our customers are
-- but what product they hold by location. In Lagos for example
-- you can see whether savings or current account holders
-- dominate — which should drive which product to lead with
-- in any Lagos-specific campaign.

-- ── Key lesson ───────────────────────────────────────────────
-- GROUP BY must list EVERY column in your SELECT that is NOT
-- inside an aggregate function like COUNT() or SUM().
-- If you SELECT state and account_type, both must appear
-- in the GROUP BY. Forgetting one causes an error.


-- ============================================================
-- QUERY 5 — LIMIT
-- Business question: Who are our 5 most recently joined
-- customers?
-- ============================================================

SELECT
    name,
    state,
    account_type,
    date_joined
FROM customers
ORDER BY date_joined DESC
LIMIT 5;

-- So what: These are our newest customers. The bank should
-- trigger an onboarding sequence for any customer who joined
-- in the last 6 months — welcome communication, product
-- education, and an early cross-sell attempt within 90 days
-- of joining (when engagement is highest).


-- ============================================================
-- PRACTICE QUERY — Your turn
-- Write this yourself before looking at the answer below.
-- ============================================================

-- Business question:
-- Find all customers who joined AFTER 1 January 2021.
-- Show their name, account type, state, and date joined.
-- Order by date joined, newest first.

-- Write your query here:
-- SELECT ?,  ?,  ?,  ?
-- FROM ?
-- WHERE date_joined > ?
-- ORDER BY ? DESC;

-- After you run it, write your so what:
-- -- So what: ...


-- ── ANSWER ── (try yours first before reading this)
SELECT
    name,
    account_type,
    state,
    date_joined
FROM customers
WHERE date_joined > '2021-01-01'
ORDER BY date_joined DESC;

-- So what: 22 of our 40 customers (55%) joined after
-- January 2021 — meaning the majority of our base is
-- relatively new. This tells us two things. First, the
-- bank has been growing its customer acquisition in recent
-- years. Second, these newer customers have not yet had
-- time to build long transaction histories, so their
-- lifetime value is still to be realised. The bank should
-- invest in early-stage retention programmes specifically
-- targeted at the post-2021 cohort.


-- ============================================================
-- BONUS QUERY — Combining everything
-- How many customers joined after 2021 by state?
-- ============================================================

SELECT
    state,
    COUNT(customer_id)  AS recent_customers
FROM customers
WHERE date_joined > '2021-01-01'
GROUP BY state
ORDER BY recent_customers DESC;

-- So what: This shows which states have the most growth-stage
-- customers — those who joined after 2021 and whose accounts
-- are still maturing. States with high recent acquisition
-- (like Lagos) need strong onboarding resources right now.
-- States with low recent numbers (like Imo or Ogun) may need
-- acquisition campaigns before onboarding becomes the focus.


-- ============================================================
-- NEXT EPISODE PREVIEW — SQL JOINs
-- ============================================================
-- In Episode 03 we connect TWO tables together for the
-- first time. Here is a taste of what you will write:
--
-- SELECT
--     c.name,
--     c.state,
--     SUM(t.amount) AS total_transactions
-- FROM customers c
-- JOIN transactions t ON c.customer_id = t.customer_id
-- WHERE YEAR(t.txn_date) = 2023
-- GROUP BY c.customer_id, c.name, c.state
-- ORDER BY total_transactions DESC
-- LIMIT 10;
--
-- Subscribe so you don't miss it.
-- @Beyond_d_Numbers
-- ============================================================
