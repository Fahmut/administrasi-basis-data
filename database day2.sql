-- melakukan subquery
SELECT
	productCode,
    AVG (quantityOrdered) AS avg_qty
    FROM belajar.orderdetails
    GROUP BY  productCode
    HAVING avg_qty > (SELECT AVG(quantityOrdered) FROM belajar.orderdetails);
    
    
    -- membuat tabel total product orders
    CREATE TABLE belajar.products_total (
    productCode VARCHAR (32),
    productName VARCHAR (50),
    total FLOAT 
    );
    
    SELECT
		A.productCode,
        B.productName,
        SUM(A.quantityOrdered * A.priceEach) AS total
	FROM belajar.orderdetails A 
    JOIN belajar.products B 
    ON A.productCode = B.productCode
	GROUP BY A.productCode
    ORDER BY total DESC;
    
    -- memasukkan data pada tabel menggunakan subquery
    INSERT INTO belajar.products_total
		 SELECT
		A.productCode,
        B.productName,
        SUM(A.quantityOrdered * A.priceEach) AS total
	FROM belajar.orderdetails A 
    JOIN belajar.products B 
    ON A.productCode = B.productCode
	GROUP BY A.productCode
    ORDER BY total DESC;
    
    -- menampilkan data pada tabel
    SELECT * FROM  belajar.products_total;
    
    -- membuat view table
    CREATE VIEW belajar.summary_products_total AS
	SELECT
		A.productCode,
        B.productName,
        SUM(A.quantityOrdered * A.priceEach) AS total
	FROM belajar.orderdetails A 
    JOIN belajar.products B 
    ON A.productCode = B.productCode
	GROUP BY A.productCode
    ORDER BY total DESC;
    
    -- menampilkan data pada view
    SELECT * FROM belajar.summary_products_total;
    
    -- melakukan subquery pada perintah FROM
    SELECT
		A.productCode,
        B.productName,
        SUM(A.quantityOrdered * A.priceEach) AS total
	FROM (SELECT * FROM (SELECT * FROM belajar.orderdetails) AA) A 
    JOIN belajar.products B 
    ON A.productCode = B.productCode
	GROUP BY A.productCode
    ORDER BY total DESC;
    
    -- tampilkan customernamae yang melakukan transaksi di atas rata-rata
     SELECT
			A.customerNumber,
            B.customerName,
		AVG(amount) AS avg_amount
        FROM belajar.payments A
        JOIN belajar.customers B
        ON  A.customerNumber = B.customerNumber
        GROUP BY customerNumber
        HAVING  avg_amount > (SELECT AVG(amount) FROM belajar.payments)
        ORDER BY avg_amount DESC;
        
	-- buat view table summary_customers_avg_amount
    DROP VIEW belajar.summary_avg_amount;
    
    CREATE VIEW belajar.summary_avg_amount AS
     SELECT
			A.customerNumber,
            B.customerName,
		AVG(amount) AS avg_amount
        FROM belajar.payments A
        JOIN belajar.customers B
        ON  A.customerNumber = B.customerNumber
        GROUP BY customerNumber
        HAVING  avg_amount > (SELECT AVG(amount) FROM belajar.payments)
        ORDER BY avg_amount DESC;
        
	 -- menampilkan data pada view
     
     
     -- menambahkan kolom customer level
      ALTER TABLE belajar.customers
      ADD customers_level VARCHAR (40);
      
	SELECT 
		customerName, 
        phone, 
        customers_level
	FROM
		belajar.customers;
        
	-- melakukan subquery menggunakan update
    SET SQL_SAFE_UPDATES = 0;
    UPDATE belajar.customers SET
		customers_level = "high level customers"
	WHERE customerNumber IN (
	SELECT
		customerNumber
	FROM belajar.payments
    GROUP BY customerNumber
    HAVING AVG(amount) > ( SELECT AVG(amount) FROM belajar.payments
    )
    );
    
    
    UPDATE belajar.customers SET
		customers_level = "low level customers"
	WHERE customerNumber IN (
	SELECT
		customerNumber
	FROM belajar.payments
    GROUP BY customerNumber
    HAVING AVG(amount) <( SELECT AVG(amount) FROM belajar.payments
    )
    );
    
    UPDATE belajar.customers SET
		customer_level = "mid level customers"
	WHERE customers_level IS NULL;
    
    -- membuat tabel backup
    CREATE TABLE belajar.customers_backup (
		customerNumber INT,
        customerName TEXT,
        phone TEXT,
		addressLine1 TEXT,
        creditLimit FLOAT 
	);
    
    -- memasukkan data ke tabel backup
    INSERT INTO belajar.customers_backup
    SELECT
		customerNumber,
        customerName,
        phone,
        addressLine1,
        creditLimit
	FROM belajar.customers;
    
    -- melakukan delete menggunakan subquery
    DELETE FROM belajar.customers_backup
    WHERE customerNumber IN (
    SELECT
		customerNumber
	FROM belajar.payments
    GROUP BY customerNumber
    HAVING AVG(amount) > ( SELECT AVG(amount) FROM belajar.payments
    )
);

SELECT * FROM belajar.customers_backup;


-- chalenge
-- buat kolom product_level pada tabel products
-- hitung rata-rata keseluruhan AVG(quantityOrdered)
-- pada tabel orderdetails
-- lakukan update pada kolom product_level,berdasarkan level
-- <avg_qty ==> low level products
-- >avg_qty ==> low level products

  ALTER TABLE belajar.products
  ADD product_level TEXT (40);
  
  SELECT AVG(quantityOrdered) AS avg_qty FROM belajar.orderdetails;
  
   SET SQL_SAFE_UPDATES = 0;
  UPDATE belajar.products SET
	product_level = "High level product"
WHERE productCode IN (
SELECT
	productCode
FROM belajar.orderdetails
GROUP BY productCode
HAVING AVG (quantityOrdered) > (
SELECT AVG(quantityOrdered) FROM belajar.orderdetails
)
);

 UPDATE belajar.products SET
	product_level = "Low level product"
WHERE productCode IN (
SELECT
	productCode
FROM belajar.orderdetails
GROUP BY productCode
HAVING AVG (quantityOrdered) < (
SELECT AVG(quantityOrdered) FROM belajar.orderdetails
)
);
	
      
        
        
   
    
    
    
    