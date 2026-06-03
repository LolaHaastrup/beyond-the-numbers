-- ============================================================
-- BEYOND THE NUMBERS — Episode 05
-- Window Functions — RANK, Running Totals & Period Comparisons
-- youtube.com/@Beyond_d_Numbers | Omolola Haastrup
-- ============================================================
-- HOW TO USE THIS FILE:
-- 1. Make sure mentorship_db is loaded (run mentorship_db_setup.sql)
-- 2. Select a query block and press Ctrl+Enter to run it in DBeaver
-- 3. Write your own -- So what: BEFORE reading mine
-- ============================================================

USE mentorship_db;


-- ============================================================
-- WARM-UP — See the difference between GROUP BY and window functions
-- Run both and compare the row counts
-- ============================================================

-- GROUP BY: collapses 40 rows into one per state
SELECT state, COUNT(*) AS n
FROM customers
GROUP BY state
ORDER BY n DESC;
-- Result: ~8 rows (one per state)

-- Window function: keeps all 40 rows, adds a rank column
SELECT name, state,
       RANK() OVER(ORDER BY name) AS alpha_rank
FROM customers;
-- Result: still 40 rows — rank column added, nothing removed


-- ============================================================
-- QUERY 1 — RANK()
-- Business question: Which customers generated the most
-- transaction value in 2023 — ranked, with their % share?
-- ============================================================

SELECT
    c.name,
    c.state,
    SUM(t.amount)                                    AS total_value,
    RANK() OVER (
        ORDER BY SUM(t.amount) DESC
    )                                                AS value_rank,
    ROUND(SUM(t.amount) * 100.0
          / SUM(SUM(t.amount)) OVER(), 1)            AS pct_of_total
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE YEAR(t.txn_date) = 2023
GROUP BY c.customer_id, c.name, c.state
ORDER BY value_rank;

-- So what: The top 5 customers account for 65% of all 2023
-- transaction value. Three are in Lagos, two in Abuja. This
-- level of concentration is a risk — the bank's revenue is
-- exposed to the behaviour of a very small group of people.
-- A VIP retention programme targeting exactly these 5 customers
-- is not a luxury. It is risk management.

-- ── Key lesson ────────────────────────────────────────────
-- RANK() runs AFTER GROUP BY. The SUM(t.amount) in OVER()
-- refers to the grouped result, not individual rows.
-- SUM(SUM(t.amount)) OVER() with empty parentheses
-- calculates the grand total across ALL groups — used as
-- the denominator for the % calculation.


-- ============================================================
-- QUERY 1B — DENSE_RANK() with PARTITION BY (bonus)
-- Rank customers within each state by transaction value
-- ============================================================

SELECT
    c.name,
    c.state,
    SUM(t.amount)                                    AS total_value,
    DENSE_RANK() OVER (
        PARTITION BY c.state
        ORDER BY     SUM(t.amount) DESC
    )                                                AS state_rank
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE YEAR(t.txn_date) = 2023
GROUP BY c.customer_id, c.name, c.state
ORDER BY c.state, state_rank;

-- So what: This shows the #1 customer within each state.
-- Lagos #1 is Opeyemi Olawale, Abuja #1 is Danjuma Lawal.
-- Each state market leader should receive separate account
-- management attention regardless of their national rank.


-- ============================================================
-- QUERY 2 — SUM() OVER()
-- Business question: How did cumulative deposit intake grow
-- month by month in 2023 — and when did it cross ₦100M?
-- ============================================================

SELECT
    MONTH(txn_date)                              AS month_num,
    MONTHNAME(txn_date)                          AS month_name,
    SUM(amount)                                  AS monthly_total,
    SUM(SUM(amount)) OVER (
        ORDER BY MONTH(txn_date)
    )                                            AS cumulative_total
FROM transactions
WHERE YEAR(txn_date)  = 2023
  AND txn_type        = 'deposit'
GROUP BY MONTH(txn_date), MONTHNAME(txn_date)
ORDER BY month_num;

-- So what: Cumulative deposits crossed ₦100M in June —
-- halfway through the year. The November surge pushed the
-- full-year figure significantly higher. For treasury
-- planning, knowing WHEN the bank crosses key thresholds
-- is as important as knowing the final total. The treasury
-- team can use this pattern to forecast liquidity needs
-- and time investment decisions accordingly.

-- ── Key lesson ────────────────────────────────────────────
-- SUM(SUM(amount)) — the inner SUM aggregates per month
-- (GROUP BY). The outer SUM() OVER() then accumulates those
-- monthly totals in date order. You need both: GROUP BY
-- first to get monthly figures, OVER() to run across them.


-- ============================================================
-- QUERY 3 — LAG()
-- Business question: Which month in 2023 saw the biggest
-- increase in deposits compared to the previous month?
-- ============================================================

WITH monthly AS (
    SELECT
        MONTH(txn_date)                     AS mth,
        MONTHNAME(txn_date)                 AS mth_name,
        SUM(amount)                         AS deposits
    FROM   transactions
    WHERE  YEAR(txn_date) = 2023
    AND    txn_type       = 'deposit'
    GROUP  BY MONTH(txn_date), MONTHNAME(txn_date)
)
SELECT
    mth_name,
    deposits,
    LAG(deposits, 1, NULL) OVER (ORDER BY mth) AS prev_month,
    deposits - LAG(deposits, 1, 0) OVER (ORDER BY mth) AS mom_change,
    ROUND(
        (deposits - LAG(deposits, 1, deposits) OVER (ORDER BY mth))
        * 100.0
        / LAG(deposits, 1, deposits) OVER (ORDER BY mth),
        1
    )                                           AS pct_change
FROM  monthly
ORDER BY mth;

-- So what: November was the biggest single-month jump —
-- up ₦10.5M from October (+35%). December fell sharply
-- as year-end withdrawals kicked in (-58% from November).
-- This seasonal pattern is predictable and plannable.
-- The treasury team should be positioned for the November
-- surge and the December drawdown every year — it is not
-- an anomaly, it is a cycle.

-- ── Key lesson ────────────────────────────────────────────
-- CTE + LAG pattern: use the CTE to aggregate first,
-- then apply LAG() in the outer query on the CTE result.
-- This is cleaner than nesting LAG() inside a GROUP BY
-- query. The third argument in LAG(deposits, 1, 0) is the
-- default value returned when there is no previous row
-- (i.e. January has no December before it).


-- ============================================================
-- PRACTICE QUERY — Your turn
-- Fill in the gaps before looking at the answer below
-- ============================================================

-- Business question:
-- Using DENSE_RANK() with PARTITION BY, rank customers
-- within each state by their 2023 transaction value.
-- Show name, state, total_value, and their rank within state.
-- Include only customers with at least one 2023 transaction.

SELECT
    c.name,
    c.state,
    SUM(t.amount)              AS total_value,
    DENSE_RANK() OVER (
        PARTITION BY ___________    -- partition by what?
        ORDER BY     ___________ DESC  -- order by what?
    )                          AS state_rank
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE YEAR(t.txn_date) = 2023
GROUP BY c.customer_id, c.name, c.state
ORDER BY c.state, state_rank;

-- Questions to answer BEFORE looking at the solution:
-- 1. What goes in PARTITION BY — and what changes if you
--    remove PARTITION BY entirely?
-- 2. Why DENSE_RANK() here and not RANK()? What would change
--    if two Lagos customers had the same total value?
-- 3. Write your -- So what: Which state has the most
--    competitive high-value segment? What does that tell
--    the bank about where to focus acquisition efforts?

-- -- So what: ...


-- ── ANSWER ── (try yours first) ──────────────────────────
SELECT
    c.name,
    c.state,
    SUM(t.amount)              AS total_value,
    DENSE_RANK() OVER (
        PARTITION BY c.state           -- restart rank per state
        ORDER BY     SUM(t.amount) DESC
    )                          AS state_rank
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE YEAR(t.txn_date) = 2023
GROUP BY c.customer_id, c.name, c.state
ORDER BY c.state, state_rank;

-- Why PARTITION BY c.state?
-- Without it, DENSE_RANK() ranks all customers globally —
-- one ranking across everyone. With PARTITION BY c.state,
-- the ranking restarts for each state. Lagos gets its own
-- #1, Kano gets its own #1, Abuja gets its own #1.

-- Why DENSE_RANK() not RANK()?
-- If two Lagos customers had identical totals, RANK() would
-- give both rank 2 and skip to rank 4. DENSE_RANK() gives
-- both rank 2 and continues at rank 3 — no gap.

-- So what: Lagos has the most competitive high-value segment
-- — multiple customers with significant transaction volumes.
-- States like Imo or Anambra may have only one or two active
-- customers at all, suggesting untapped acquisition potential
-- rather than a competitive market to defend.


-- ============================================================
-- BONUS — Window function vs GROUP BY side by side
-- Run both and compare results — same data, different output
-- ============================================================

-- GROUP BY: 1 row per state (rows collapsed)
SELECT state, SUM(amount) AS total
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
WHERE YEAR(t.txn_date) = 2023
GROUP BY state
ORDER BY total DESC;

-- Window function: all customer rows kept, state total added
SELECT c.name, c.state,
       SUM(t.amount)             AS customer_total,
       SUM(SUM(t.amount)) OVER (
           PARTITION BY c.state
       )                         AS state_total,
       ROUND(SUM(t.amount) * 100.0
             / SUM(SUM(t.amount)) OVER (PARTITION BY c.state), 1)
                                 AS share_of_state_pct
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
WHERE YEAR(t.txn_date) = 2023
GROUP BY c.customer_id, c.name, c.state
ORDER BY c.state, customer_total DESC;

-- The second query shows each customer's share of their
-- own state's total — impossible with GROUP BY alone.


-- ============================================================
-- NEXT EPISODE PREVIEW — SQL for real-world Nigerian datasets
-- ============================================================
-- Episode 6: Applying window functions and JOINs to
-- public sector data, FMCG sales, and financial services
-- datasets that reflect the work Nigerian analysts
-- actually do every day.
--
-- Subscribe so you don't miss it.
-- @Beyond_d_Numbers
-- ============================================================
