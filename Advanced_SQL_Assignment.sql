
-- Advanced SQL Assignment — Full Execution File
-- Includes: CREATE TABLE + INSERT DATA + ALL ANSWERS

-- ===============================
-- DATASET (Products & Sales)
-- ===============================

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');


-- ===============================
-- Q6: CTE Revenue > 3000
-- ===============================

WITH RevenueCTE AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(p.Price * s.Quantity) AS Revenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    GROUP BY p.ProductID, p.ProductName
)
SELECT * FROM RevenueCTE
WHERE Revenue > 3000;


-- ===============================
-- Q7: View vw_CategorySummary
-- ===============================

CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;


-- ===============================
-- Q8: Updatable View + Update
-- ===============================

CREATE VIEW vw_ProductEditable AS
SELECT ProductID, ProductName, Price
FROM Products;

UPDATE vw_ProductEditable
SET Price = 1300
WHERE ProductID = 1;


-- ===============================
-- Q9: Stored Procedure by Category
-- ===============================

DELIMITER $$

CREATE PROCEDURE GetProductsByCategory(IN categoryName VARCHAR(50))
BEGIN
    SELECT *
    FROM Products
    WHERE Category = categoryName;
END $$

DELIMITER ;

-- Example Call
CALL GetProductsByCategory('Electronics');


-- ===============================
-- Q10: AFTER DELETE Trigger + Archive Table
-- ===============================

CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_AfterDeleteProduct
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive
    VALUES (
        OLD.ProductID,
        OLD.ProductName,
        OLD.Category,
        OLD.Price,
        NOW()
    );
END $$

DELIMITER ;

-- Example delete to test trigger
-- DELETE FROM Products WHERE ProductID = 2;
