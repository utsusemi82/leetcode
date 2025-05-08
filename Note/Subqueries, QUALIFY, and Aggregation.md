## SQL: Subqueries, QUALIFY, and Aggregation

### 1. Basic SQL Structure

```
SELECT column1, column2, AGG_FUNC(column3)
FROM table
WHERE condition
GROUP BY column1, column2
HAVING aggregate_condition
ORDER BY column;
```
---

### 2. Subqueries (Types & Examples)
#### a. Scalar Subquery
Returns a single value (one row, one column).
```
SELECT employee_id, 
       (SELECT department_name 
        FROM departments 
        WHERE departments.department_id = employees.department_id) AS dept_name
FROM employees;
```
#### b. Inline View (Derived Table)
A subquery used in the **FROM** clause. Returns a table.
```
SELECT dept_id, AVG(salary) AS avg_salary
FROM (
    SELECT department_id AS dept_id, salary
    FROM employees
    WHERE job_id = 'SA_REP'
) AS sales
GROUP BY dept_id;
```
#### c. Correlated Subquery
Refers to columns from the outer query. Evaluated for each row.
```
SELECT e.employee_id, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
```
---
#### 3. ROW_NUMBER() with QUALIFY
- With **QUALIFY** (e.g., Snowflake, Teradata)
```
SELECT *
FROM transactions
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY card_no, posting_date
    ORDER BY txn_amt DESC
) = 1;
```
- Without QUALIFY (e.g., SQL Server, Oracle)
```
WITH ranked_txn AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY card_no, posting_date ORDER BY txn_amt DESC) AS rn
    FROM transactions
)
SELECT *
FROM ranked_txn
WHERE rn = 1;
```
---
#### 4. Aggregation with GROUP BY
```
SELECT department_id, COUNT(*) AS emp_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;
```
---
#### 5. EXISTS vs IN (Subquery Filters)
IN:
```
SELECT name 
FROM employees 
WHERE department_id IN (
    SELECT department_id FROM departments WHERE location_id = 1700
);
```
EXISTS:
```
SELECT name 
FROM employees e
WHERE EXISTS (
    SELECT 1 FROM departments d 
    WHERE d.department_id = e.department_id AND d.location_id = 1700
);
```
---
#### 6. Filtering with Aggregates (HAVING vs WHERE)
```
SELECT department_id, COUNT(*) AS cnt
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;
```
Bonus: Subquery with Aggregation in SELECT
```
SELECT name,
       (SELECT COUNT(*) 
        FROM sales 
        WHERE sales.customer_id = customers.customer_id) AS total_purchases
FROM customers;
```
---

### Summary Table of SQL Subquery Types

| Subquery Type       | Location       | Returns         | Use Case Example                          |
|---------------------|----------------|------------------|--------------------------------------------|
| Scalar Subquery     | SELECT/WHERE   | One value        | Get total salary for one department        |
| Inline View         | FROM           | Table            | Grouping/aggregation on filtered set       |
| Correlated Subquery | WHERE/EXISTS   | Varies           | Filtering based on outer query values      |
| QUALIFY             | After SELECT   | Window function  | Row-level filtering with analytics         |

