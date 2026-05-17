-- ============================================================
-- BEYOND THE NUMBERS — Episode 03
-- SQL JOINs — Combining Tables to Answer Real Questions
-- youtube.com/@Beyond_d_Numbers | Omolola Haastrup
-- ============================================================
-- HOW TO USE THIS FILE:
-- 1. Make sure mentorship_db is loaded (run mentorship_db_setup.sql first)
-- 2. Select any query block and press Ctrl+Enter to run it in DBeaver
-- 3. Write your own -- So what: BEFORE reading mine
-- 4. Post your so what in the YouTube comments
-- ============================================================

USE mentorship_db;


-- ============================================================
-- WARM-UP — Understand the tables we are joining
-- ============================================================

-- What is in the customers table?
SELECT * FROM customers LIMIT 5;

-- What is in the transactions table?
SELECT * FROM transactions LIMIT 5;

-- What is in the branches table?
SELECT * FROM branches;

-- Notice: transactions has customer_id AND branch_id
-- These are the bridge columns that connect to the other tables


-- ============================================================
-- QUERY 1 — INNER JOIN
-- Business question: Which customers generated the most
-- transaction value in 2023 — and where are they?
-- ============================================================

SELECT
    c.name,
    c.state,
    c.account_type,
    COUNT(t.txn_id)      AS num_transactions,
    SUM(t.amount)        AS total_value
FROM customers c
INNER JOIN transactions t
    ON  c.customer_id = t.customer_id
    AND YEAR(t.txn_date) = 2023
GROUP BY c.customer_id, c.name, c.state, c.account_type
ORDER BY total_value DESC
LIMIT 5;

-- So what: Lagos and Abuja dominate the top 5 — 3 Lagos
-- customers and 2 from Abuja account for the bank's highest
-- value relationships. Any VIP programme, premium product
-- launch, or relationship manager assignment should be
-- concentrated in these two cities before expanding nationally.
-- Do not spread resources evenly — follow the value.

-- ── Key lessons from Query 1 ─────────────────────────────────
-- 1. Table aliases: c = customers, t = transactions
--    Use aliases whenever two tables share a column name
--    (both have customer_id). c.customer_id vs t.customer_id.
-- 2. Year filter goes in the ON clause, not WHERE.
--    Putting it in WHERE would still work for INNER JOIN,
--    but it is best practice to filter join conditions in ON.
-- 3. GROUP BY must include all non-aggregated SELECT columns.


-- ============================================================
-- QUERY 2 — LEFT JOIN
-- Business question: Which customers have NEVER made a
-- transaction — and should the bank be concerned?
-- ============================================================

SELECT
    c.name,
    c.state,
    c.account_type,
    c.date_joined,
    t.txn_id       -- will be NULL if no transactions exist
FROM customers c
LEFT JOIN transactions t
    ON c.customer_id = t.customer_id
WHERE t.txn_id IS NULL
ORDER BY c.date_joined;

-- So what: These are dormant accounts. Each one represents
-- an acquisition cost the bank has already paid — onboarding,
-- KYC, account setup — with zero transaction return so far.
-- The retention team needs this list immediately. A targeted
-- reactivation campaign (e.g. zero-fee first transaction,
-- savings bonus offer) sent within 30 days has the highest
-- conversion probability for recently dormant accounts.

-- ── Key lessons from Query 2 ─────────────────────────────────
-- LEFT JOIN + IS NULL = the "anti-join" pattern.
-- Find rows that exist in the LEFT table but NOT the right.
-- This is one of the most used patterns in professional SQL.
--
-- IMPORTANT — the WHERE vs ON rule:
-- WHERE t.txn_id IS NULL is safe here (finding missing records)
-- But WHERE t.txn_type = 'deposit' would BREAK the LEFT JOIN
-- by removing all NULL rows — silently turning it into INNER JOIN
-- Value filters on the RIGHT table always go in the ON clause.


-- ============================================================
-- QUERY 3 — THREE-TABLE JOIN
-- Business question: Which region generated the highest
-- deposit value in 2023 — and how many customers drove it?
-- ============================================================

SELECT
    b.region,
    COUNT(DISTINCT c.customer_id)  AS num_customers,
    COUNT(t.txn_id)                AS num_deposits,
    SUM(t.amount)                  AS total_deposits
FROM transactions t
JOIN customers c
    ON  t.customer_id = c.customer_id
JOIN branches b
    ON  t.branch_id = b.branch_id
WHERE t.txn_type  = 'deposit'
  AND YEAR(t.txn_date) = 2023
GROUP BY b.region
ORDER BY total_deposits DESC;

-- So what: South-West drives 54% of total 2023 deposit value
-- with only 12 of the bank's 40 customers. South-East and
-- South-South are active regions with real branches but
-- contribute less than 7% of total deposits combined.
-- These are not failing markets — they are untapped ones.
-- A dedicated regional growth strategy (local branch incentives,
-- state-specific campaigns) could meaningfully shift this split
-- within 12 months without acquiring new customers nationally.

-- ── Key lessons from Query 3 ─────────────────────────────────
-- Three-table JOIN pattern:
--   FROM transactions t          (has both customer_id + branch_id)
--   JOIN customers c ON ...      (adds customer info via customer_id)
--   JOIN branches b ON ...       (adds region info via branch_id)
--
-- Always start FROM the table that has the most shared keys.
-- Chain each JOIN one at a time using the appropriate shared column.
-- COUNT(DISTINCT c.customer_id) avoids counting the same
-- customer multiple times when they have multiple transactions.


-- ============================================================
-- PRACTICE QUERY — Your turn
-- Write this yourself before looking at the answer below.
-- ============================================================

-- Business question:
-- Find all savings customers who joined after 2020.
-- Show their total transaction value in 2023.
-- INCLUDE customers who made zero transactions (show NULL or 0).
-- Order by total value, highest first.

-- Hints:
-- 1. Which JOIN type do you use — and why?
--    What happens to your result if you use INNER JOIN instead?
-- 2. Where does the 2023 filter go — ON or WHERE?
--    What is the difference in what gets returned?
-- 3. After running it, write your -- So what:

-- Write your query here:
-- SELECT ...
-- FROM customers c
-- ? JOIN transactions t
--     ON c.customer_id = t.customer_id
--     AND ? -- where does the year filter go?
-- WHERE c.account_type = 'savings'
--   AND c.date_joined > '2020-12-31'
-- GROUP BY c.customer_id, c.name, c.state, c.date_joined
-- ORDER BY ? DESC;

-- -- So what: ...


-- ── ANSWER ── (try yours first before reading this) ──────────
SELECT
    c.name,
    c.state,
    c.date_joined,
    SUM(t.amount)  AS total_2023_value
FROM customers c
LEFT JOIN transactions t                -- LEFT JOIN: keep all savings customers
    ON  c.customer_id = t.customer_id
    AND YEAR(t.txn_date) = 2023         -- year filter in ON, not WHERE
WHERE c.account_type = 'savings'
  AND c.date_joined  > '2020-12-31'
GROUP BY c.customer_id, c.name, c.state, c.date_joined
ORDER BY total_2023_value DESC;

-- Why LEFT JOIN?
-- Because the question says "include customers with zero transactions."
-- INNER JOIN would silently exclude any savings customer who joined
-- after 2020 but made no 2023 transactions — giving you a different
-- (and incorrect) answer to the business question.

-- Why year filter in ON?
-- If you put YEAR(t.txn_date) = 2023 in WHERE, it would remove all
-- rows where txn_date is NULL — which are the dormant customers.
-- LEFT JOIN effect would be lost. Put it in ON to preserve it.

-- So what: Among savings customers who joined after 2020, some have
-- already built significant transaction value while others show NULL
-- (zero activity). The split tells you which new savings customers
-- are engaged and which are at risk of permanent dormancy.
-- New customers with zero activity within the first 2 years rarely
-- become active later — the bank needs an intervention now, before
-- these accounts become permanently dormant write-offs.


-- ============================================================
-- BONUS — The WHERE vs ON mistake demonstrated
-- Run both and compare the row counts
-- ============================================================

-- WRONG: Filter in WHERE — destroys LEFT JOIN
SELECT
    c.name,
    c.state,
    COUNT(t.txn_id) AS deposit_count
FROM customers c
LEFT JOIN transactions t
    ON  c.customer_id = t.customer_id
WHERE t.txn_type = 'deposit'            -- this kills LEFT JOIN!
GROUP BY c.customer_id, c.name, c.state
ORDER BY deposit_count DESC;

-- CORRECT: Filter in ON — preserves LEFT JOIN
SELECT
    c.name,
    c.state,
    COUNT(t.txn_id) AS deposit_count
FROM customers c
LEFT JOIN transactions t
    ON  c.customer_id = t.customer_id
    AND t.txn_type = 'deposit'          -- filter in ON = correct
GROUP BY c.customer_id, c.name, c.state
ORDER BY deposit_count DESC;

-- Compare the two results.
-- The WRONG version will have fewer rows (it excludes non-depositors).
-- The CORRECT version includes ALL customers — those with 0 deposits
-- will show deposit_count = 0.
-- Same query, two characters different, completely different result.


-- ============================================================
-- NEXT EPISODE PREVIEW — GROUP BY, HAVING & Window Functions
-- ============================================================
-- In Episode 4 we go deeper on aggregation.
-- HAVING filters on aggregated values (WHERE cannot).
-- Window functions rank, sum, and compare without collapsing rows.
-- Here is a taste:
--
-- SELECT
--     c.name,
--     SUM(t.amount)                                    AS total_value,
--     RANK() OVER (ORDER BY SUM(t.amount) DESC)        AS value_rank,
--     ROUND(SUM(t.amount) * 100.0
--           / SUM(SUM(t.amount)) OVER (), 1)           AS pct_of_total
-- FROM customers c
-- JOIN transactions t ON c.customer_id = t.customer_id
-- WHERE YEAR(t.txn_date) = 2023
-- GROUP BY c.customer_id, c.name
-- HAVING SUM(t.amount) > 5000000
-- ORDER BY value_rank;
--
-- Subscribe so you don't miss it.
-- @Beyond_d_Numbers
-- ============================================================
