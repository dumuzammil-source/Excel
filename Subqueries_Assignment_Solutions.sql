
-- Subqueries Assignment — Solutions
-- =================================

-- ======================
-- BASIC LEVEL
-- ======================

-- 1) Employees earning more than the average salary
SELECT name
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- 2) Employees in department with highest average salary
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

-- 3) Employees who made at least one sale
SELECT name
FROM Employee
WHERE emp_id IN (
    SELECT DISTINCT emp_id FROM Sales
);

-- 4) Employee with highest sale amount
SELECT name
FROM Employee
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount = (SELECT MAX(sale_amount) FROM Sales)
);

-- 5) Employees with salary higher than Shubham
SELECT name
FROM Employee
WHERE salary > (
    SELECT salary FROM Employee WHERE name = 'Shubham'
);


-- ======================
-- INTERMEDIATE LEVEL
-- ======================

-- 6) Employees in same department as Abhishek
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id FROM Employee WHERE name = 'Abhishek'
);

-- 7) Departments with at least one employee earning > 60000
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT DISTINCT department_id
    FROM Employee
    WHERE salary > 60000
);

-- 8) Department name of employee with highest sale
SELECT department_name
FROM Department
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE emp_id = (
        SELECT emp_id
        FROM Sales
        WHERE sale_amount = (SELECT MAX(sale_amount) FROM Sales)
    )
);

-- 9) Employees with sales greater than average sale amount
SELECT DISTINCT name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount > (SELECT AVG(sale_amount) FROM Sales)
);

-- 10) Total sales by employees earning more than average salary
SELECT SUM(sale_amount) AS total_sales
FROM Sales
WHERE emp_id IN (
    SELECT emp_id
    FROM Employee
    WHERE salary > (SELECT AVG(salary) FROM Employee)
);


-- ======================
-- ADVANCED LEVEL
-- ======================

-- 11) Employees who have not made any sales
SELECT name
FROM Employee
WHERE emp_id NOT IN (
    SELECT emp_id FROM Sales
);

-- 12) Departments where average salary > 55000
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT department_id
    FROM Employee
    GROUP BY department_id
    HAVING AVG(salary) > 55000
);

-- 13) Departments where total sales exceed 10000
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT department_id
    FROM Employee
    WHERE emp_id IN (
        SELECT emp_id
        FROM Sales
        GROUP BY emp_id
        HAVING SUM(sale_amount) > 10000
    )
);

-- 14) Employee with second-highest sale
SELECT name
FROM Employee
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount = (
        SELECT MAX(sale_amount)
        FROM Sales
        WHERE sale_amount < (SELECT MAX(sale_amount) FROM Sales)
    )
);

-- 15) Employees whose salary is greater than highest sale amount
SELECT name
FROM Employee
WHERE salary > (
    SELECT MAX(sale_amount) FROM Sales
);
