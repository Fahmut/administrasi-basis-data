-- Perintah untuk membuat database
CREATE DATABASE fahmi_99;

-- perintah membuat table
CREATE TABLE fahmi_99.costumers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR (16) NOT NULL,
    last_name VARCHAR(16) NOT NULL,
    email VARCHAR(32) UNIQUE NOT NULL,
    birth_date DATE,
    balance FLOAT DEFAULT 0.0
);

-- memasukkan data kedalam table (sesuai urutan kolom)
INSERT INTO fahmi_99.costumers VALUES (
	NULL,
    "ocit",
    "bokep",
    "citkongkek@gmail.com",
    "1987-12-06",
    12.111
);

INSERT INTO fahmi_99.costumers VALUES (
	NULL,
    "oyiik",
    "bucin",
    "yiik@gmail.com",
    "1999-12-06",
    12.111
);

-- menampilkan data pada tabel
SELECT * FROM fahmi_99.costumers; 

-- memperbarui data 
UPDATE fahmi_99.costumers SET
	email = "yiik@yahoo.com",
	birth_date = "1980-12-07",
	balance = 15.222
WHERE id = 2;

-- menghapus data
DELETE FROM fahmi_99.costumers WHERE id = 2;

-- menambah kolom pada tabel
ALTER TABLE fahmi_99.costumers ADD username TEXT NOT NULL;

-- perintah untuk menampilkan inforamsi tabel
DESCRIBE fahmi_99.costumers;

-- mengubah nama kolom 
ALTER TABLE fahmi_99.costumers
CHANGE birth_date tanggal_lahir DATE;

-- menghapus kolom pada tabel
-- ALTER TABLE fahmi_99.costumers
-- DROP COLUMN username;

-- menampilkan data pada tabel (seluruh kolom)
 SELECT * FROM belajar.orderdetails;
 
 -- menampilkan data kolom tertentu
 SELECT
	productCode,
    quantityOrdered,
    priceEach
FROM belajar.orderdetails
LIMIT 5;

-- membuat alias pada kolom
 SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
LIMIT 5;

-- sorting pada kolom (menurun)
 SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
ORDER BY quantityOrdered DESC;

-- sorting pada kolom (menaik)
 SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
ORDER BY quantityOrdered ASC;

-- filtering pada kolom angka 
 SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
WHERE quantityOrdered > 50;

-- filtering pada kolom karakter
 SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
WHERE productCode = "S10_1678";

-- filtering pada kolom karakter
 SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
WHERE productCode LIKE "S10_%";

-- melakukan operasi antar kolom
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan",
    (quantityOrdered * priceEach) AS total
    FROM belajar.orderdetails;
    
    -- melakukan filtering pada kolom operasi
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan",
    (quantityOrdered * priceEach) AS total
    FROM belajar.orderdetails
    HAVING total > 2000;
    
    -- melakukan agregasi
    SELECT
		SUM(quantityOrdered) AS "total jumlah",
		AVG(quantityOrdered) AS "rata-rata jumlah",
        MIN(quantityOrdered) AS "pembelian terkecil",
        MAX(quantityOrdered) AS "pembelian terbanyak",
        SUM(quantityOrdered * priceEach) AS "total Revenue"
	FROM belajar.orderdetails;
        
	-- melakukan grouping
    SELECT
		productCode AS "kode produk",
		SUM(quantityOrdered * priceEach) AS total
    FROM belajar.orderdetails
    GROUP BY productCode
    ORDER BY productCode DESC;
    
    -- tampilkan 10 product code dengan total terbesar hingga terkecil
	SELECT
		productCode AS "kode produk",
		SUM(quantityOrdered * priceEach) AS total
    FROM belajar.orderdetails
    GROUP BY productCode
    ORDER BY  total DESC
    LIMIT 10;
    
    
    
    
    
    -- menggunakan fungsi
    SELECT 
		paymentDate,
        YEAR(paymentDate),
        MONTH (paymentDate),
        DATE_FORMAT(paymentDate, "%d/%m/%Y"),
        amount
	FROM belajar.payments;
    
    -- menghitung total transaksi berdasarkan tahun
     SELECT 
        YEAR(paymentDate) AS tahun,
        SUM(amount) AS total
	FROM belajar.payments
    GROUP BY tahun;
    
    
    
    
    
    
    -- melakukan join pada tabel
    SELECT
		A.productCode AS "kode produk",
        B.productName AS "nama produk",
		SUM(A.quantityOrdered * A.priceEach) AS total
    FROM belajar.orderdetails A
    INNER JOIN belajar.products B
    ON A.productCode = B.productCode
    GROUP BY A.productCode
    ORDER BY  total DESC
    LIMIT 10;
    
    -- tampilkan top 10 customerName berdasarkan SUM(amount)
    -- gabungkan antara tabel payments dan customers
    -- ORDER BY SUM(amount) terbesar ke terkecil
    
    
    
    
   SELECT 
    B.customerNumber AS 'nomer customer',
    A.customerName AS 'nama customer',
    SUM(B.amount)
FROM
    belajar.customers A
        INNER JOIN
    belajar.payments B ON A.customerNumber = B.customerNumber
GROUP BY A.customerNumber
ORDER BY SUM(B.amount) DESC
LIMIT 10;
        


