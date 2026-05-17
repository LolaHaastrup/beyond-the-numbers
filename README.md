# SQL to Dashboard Using Real World Data

**Watch the episode:** [youtube.com/@Beyond_d_Numbers](https://www.youtube.com/@Beyond_d_Numbers)

---

## What this episode covers

In this episode you write your first SQL queries against real Nigerian banking data.
By the end you will understand and be able to use:

| Clause | What it does |
|--------|-------------|
| `SELECT` | Choose which columns to return |
| `FROM` | Tell SQL which table to read |
| `WHERE` | Filter rows to only what you need |
| `AND` / `OR` | Combine multiple filter conditions |
| `GROUP BY` | Collapse rows into groups for summarising |
| `COUNT()` | Count rows in each group |
| `ORDER BY DESC` | Sort results highest first |
| `LIMIT` | Return only the first n rows |

---

## Files in this folder

| File | What it is |
|------|-----------|
| `mentorship_db_setup.sql` | Creates the full Nigerian banking database — run this first |
| `ep02_queries.sql` | All queries from the episode — follow along line by line |

---

## The database: mentorship_db

This is a simulated Nigerian bank — **Greenfield Bank PLC** — covering 2022–2023.

| Table | Rows | What it contains |
|-------|------|-----------------|
| `customers` | 40 | Bank customers — name, state, account type, date joined |
| `transactions` | 186 | Every deposit, withdrawal, and transfer |
| `branches` | 15 | 15 branches across Nigeria in 4 regions |
| `products` | 76 | Financial products each customer holds |

---

## How to set up the database

1. Open **DBeaver** and connect to your MySQL server (`localhost:3306`)
2. Right-click the connection → **Open SQL Console**
3. Open `mentorship_db_setup.sql` and paste the full contents into the console
4. Press **Ctrl + Enter** — the script runs in a few seconds
5. In the Database Navigator, expand `mentorship_db` → `Tables`
6. You should see four tables: `customers`, `transactions`, `branches`, `products`
7. Right-click `customers` → **View Data** to confirm the data loaded correctly

---

## Your homework

After watching the episode, write this query yourself from scratch without looking at the file:

```sql
-- Find all customers who joined AFTER 1 January 2021
-- Show their name, account type, state, and date joined
-- Order by date_joined newest first

SELECT ?, ?, ?, ?
FROM ?
WHERE date_joined > ?
ORDER BY ? DESC;
```

Then write your **-- So what:** comment answering:
1. What does the result show?
2. What does it mean for the bank?
3. What should the bank do because of it?

Drop your answer in the YouTube comments.
