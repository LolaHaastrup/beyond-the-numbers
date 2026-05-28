-- ============================================================
-- BEYOND THE NUMBERS — Episode 04
-- GROUP BY Deep Dive & HAVING
-- youtube.com/@Beyond_d_Numbers | Omolola Haastrup
-- ============================================================
-- HOW TO USE THIS FILE:
-- 1. Make sure mentorship_db is loaded (run mentorship_db_setup.sql)
-- 2. Select a query block and press Ctrl+Enter to run it in DBeaver
-- 3. Write your own -- So what: BEFORE reading mine
-- ============================================================

USE mentorship_db;


-- ============================================================
-- WARM-UP — The execution order in action
-- Run these three queries and compare the results
-- They show WHERE, GROUP BY, and HAVING working at different stages
-- ============================================================

-- Step 1: No filter, no grouping — all 40 raw rows
SELECT customer_id, state, account_type
FROM customers
LIMIT 10;

-- Step 2: GROUP BY collapses rows into one per state
SELECT state, COUNT(customer_id) AS num_customers
FROM customers
GROUP BY state
ORDER BY num_customers DESC;

-- Step 3: HAVING filters GROUPS after grouping
SELECT state, COUNT(customer_id) AS num_customers
FROM customers
GROUP BY state
HAVING COUNT(customer_id) > 3
ORDER BY num_customers DESC;

-- Notice how each query gives a different view of the same 40 rows


-- ============================================================
-- QUERY 1 — GROUP BY two columns
-- Business question: How many savings vs current account
-- customers do we have in each state?
-- ============================================================

SELECT
    state,
    account_type,
    COUNT(customer_id)                          AS num_customers,
    ROUND(COUNT(customer_id) * 100.0
          / SUM(COUNT(customer_id)) OVER(), 1)  AS pct_of_total
FROM customers
GROUP BY state, account_type
ORDER BY state, num_customers DESC;

-- So what: Lagos savings holders (8 customers) represent 20%
-- of the entire customer base — more than any other state-type
-- combination. Any product targeting savings customers should
-- launch in Lagos first, with messaging designed specifically
-- for that segment's behaviours. Marketing budget sent equally
-- across all states and account types would reach this
-- high-value segment with only a fraction of its impact.

-- ── Key lesson ────────────────────────────────────────────
-- GROUP BY two columns = one row per combination.
-- Lagos savings ≠ Lagos current — they are separate groups.
-- Both state AND account_type must appear in GROUP BY
-- because both appear in SELECT without an aggregate.


-- ============================================================
-- QUERY 2 — HAVING with a threshold (subquery)
-- Business question: Which branches processed above-average
-- total transaction value in 2023?
-- ============================================================

SELECT
    b.branch_name,
    b.region,
    COUNT(t.txn_id)   AS num_transactions,
    SUM(t.amount)     AS total_value
FROM transactions t
JOIN branches b
    ON  t.branch_id = b.branch_id
WHERE YEAR(t.txn_date) = 2023
GROUP BY b.branch_id, b.branch_name, b.region
HAVING SUM(t.amount) > (
    SELECT AVG(branch_total)
    FROM (
        SELECT SUM(amount) AS branch_total
        FROM transactions
        WHERE YEAR(txn_date) = 2023
        GROUP BY branch_id
    ) sub
)
ORDER BY total_value DESC;

-- So what: 5 of 15 branches are above average — 3 in
-- South-West, 2 in North. These 5 branches generate more
-- value than the remaining 10 combined. Before investing
-- in growing underperforming branches, the bank should study
-- what these 5 do differently: customer profile, product mix,
-- location, and relationship management approach. Copy what
-- works before fixing what doesn't.

-- ── Key lesson ────────────────────────────────────────────
-- WHERE YEAR(txn_date) = 2023 → row filter (raw date value)
-- HAVING SUM(amount) > ... → group filter (aggregate)
-- You cannot put SUM(amount) in WHERE — the aggregate
-- doesn't exist until after GROUP BY runs.


-- ============================================================
-- QUERY 3 — Combining WHERE + GROUP BY + HAVING
-- Business question: Which customers made more than 5
-- transactions AND spent over ₦5 million in 2023?
-- ============================================================

SELECT
    c.name,
    c.state,
    c.account_type,
    COUNT(t.txn_id)   AS num_transactions,
    SUM(t.amount)     AS total_value
FROM customers c
JOIN transactions t
    ON  c.customer_id = t.customer_id
WHERE YEAR(t.txn_date) = 2023           -- row filter: year (raw value)
GROUP BY c.customer_id, c.name, c.state, c.account_type
HAVING COUNT(t.txn_id)  > 5            -- group filter: transaction count
   AND SUM(t.amount)    > 5000000      -- group filter: total spend
ORDER BY total_value DESC;

-- So what: These 4 customers are the bank's most engaged AND
-- highest-spending customers in 2023. That double qualification
-- — frequency AND value — makes them a distinct high-priority
-- segment. They warrant dedicated relationship management,
-- premium card upgrades, and early access to new products.
-- Losing any one of them would materially impact 2024
-- performance — the bank cannot afford to manage these
-- relationships reactively.

-- ── Key lesson ────────────────────────────────────────────
-- WHERE and HAVING in the same query — both work together:
--   WHERE YEAR = 2023         → runs at step 2 (before grouping)
--   HAVING COUNT > 5          → runs at step 4 (after grouping)
--   HAVING SUM  > 5000000     → same step, second condition
-- You can stack multiple HAVING conditions with AND/OR.


-- ============================================================
-- PRACTICE QUERY — Your turn
-- Fill in the gaps before looking at the answer below
-- ============================================================

-- Business question:
-- Find all branches that processed DEPOSITS ONLY in 2023,
-- where the total deposit value exceeded ₦10 million.
-- Show branch name, region, number of deposits, and
-- total deposit value. Order by total deposits highest first.

-- Fill in the blanks:
SELECT
    b.branch_name,
    b.region,
    COUNT(t.txn_id)   AS num_deposits,
    SUM(t.amount)     AS total_deposits
FROM transactions t
JOIN branches b ON t.branch_id = b.branch_id
WHERE YEAR(t.txn_date) = 2023
  AND t.txn_type = ___________   -- which transaction type?
GROUP BY b.branch_id, b.branch_name, b.region
HAVING ___________  > 10000000   -- what aggregate goes here?
ORDER BY total_deposits DESC;

-- Questions to answer BEFORE looking at the answer:
-- 1. What goes in the WHERE clause for txn_type?
--    What would happen if you moved it to HAVING instead?
-- 2. What aggregate goes in HAVING?
--    Why can you NOT use the alias total_deposits in HAVING?

-- Write your so what:
-- -- So what: ...


-- ── ANSWER ── (try yours first) ──────────────────────────
SELECT
    b.branch_name,
    b.region,
    COUNT(t.txn_id)   AS num_deposits,
    SUM(t.amount)     AS total_deposits
FROM transactions t
JOIN branches b ON t.branch_id = b.branch_id
WHERE YEAR(t.txn_date) = 2023
  AND t.txn_type = 'deposit'          -- WHERE: raw value filter
GROUP BY b.branch_id, b.branch_name, b.region
HAVING SUM(t.amount) > 10000000       -- HAVING: aggregate filter
ORDER BY total_deposits DESC;

-- Why txn_type = 'deposit' in WHERE and not HAVING?
-- txn_type is a raw column value — it exists on individual rows
-- before grouping. WHERE is the right place for it.
-- Moving it to HAVING would technically work in some databases
-- but is logically wrong — you would be filtering groups on a
-- column that is not aggregated. In strict environments it fails.

-- Why SUM(t.amount) in HAVING and not the alias total_deposits?
-- HAVING runs before SELECT. The alias total_deposits is created
-- in SELECT — it doesn't exist when HAVING runs.
-- Always repeat the full aggregate expression in HAVING.

-- So what: The qualifying branches are your deposit-heavy
-- branches — the ones where customers come primarily to save,
-- not to withdraw or transfer. These branches represent the
-- most stable deposit base in the network. They should be
-- prioritised for fixed deposit product campaigns and savings
-- mobilisation targets ahead of the next fiscal year.


-- ============================================================
-- BONUS — The three common mistakes, demonstrated
-- Run each wrong version, see the error, then run the fix
-- ============================================================

-- MISTAKE 1: Column in SELECT but not in GROUP BY
-- WRONG (may fail in strict mode):
SELECT name, state, COUNT(customer_id) AS n
FROM customers
GROUP BY state;

-- CORRECT:
SELECT name, state, COUNT(customer_id) AS n
FROM customers
GROUP BY name, state;


-- MISTAKE 2: Aggregate in WHERE
-- WRONG (will always fail):
-- SELECT state, COUNT(customer_id) AS n
-- FROM customers
-- GROUP BY state
-- WHERE COUNT(customer_id) > 3;  -- ← SQL error

-- CORRECT:
SELECT state, COUNT(customer_id) AS n
FROM customers
GROUP BY state
HAVING COUNT(customer_id) > 3;


-- MISTAKE 3: Alias in HAVING (fails in strict mode)
-- WRONG:
-- SELECT state, COUNT(*) AS num
-- FROM customers
-- GROUP BY state
-- HAVING num > 3;  -- ← alias doesn't exist when HAVING runs

-- CORRECT:
SELECT state, COUNT(*) AS num
FROM customers
GROUP BY state
HAVING COUNT(*) > 3;


-- ============================================================
-- NEXT EPISODE PREVIEW — Window Functions
-- ============================================================
-- Episode 5: RANK(), DENSE_RANK(), SUM() OVER(), LAG()
-- The patterns that separate intermediate from advanced SQL.
-- Here is a taste:
--
-- SELECT
--     name, state,
--     SUM(t.amount)                                       AS total_value,
--     RANK() OVER (ORDER BY SUM(t.amount) DESC)           AS value_rank,
--     ROUND(SUM(t.amount) * 100.0
--           / SUM(SUM(t.amount)) OVER(), 1)               AS pct_of_total
-- FROM customers c
-- JOIN transactions t ON c.customer_id = t.customer_id
-- WHERE YEAR(t.txn_date) = 2023
-- GROUP BY c.customer_id, c.name, c.state
-- ORDER BY value_rank;
--
-- Subscribe so you don't miss it.
-- @Beyond_d_Numbers
-- ============================================================
