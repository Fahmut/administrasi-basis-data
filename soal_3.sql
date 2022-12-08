SELECT 
    Category, 
    Sales
FROM
    toko.pesanan
WHERE
    Category = 'Office Supplies' AND Sales > 50;