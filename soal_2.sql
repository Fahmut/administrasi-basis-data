UPDATE toko.pesanan SET
	Category = "Barang furniture"
WHERE Category = "furniture";

SELECT * FROM toko.pesanan;

DELETE FROM toko.pesanan WHERE Sales < 10;