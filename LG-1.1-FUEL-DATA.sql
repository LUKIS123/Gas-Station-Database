/*
    Kategorie paliw
*/
INSERT INTO [fuelSupply].[FuelTypes]
    (Name)
VALUES
    ('Bezołowiowa-95'),
    ('Bezołowiowa-98'),
    ('E10'),
    ('ON');

/*
    Dostawcy Paliw
*/
INSERT INTO [fuelSupply].[FuelSuppliers]
    (CompanyName,
    UsersId)
VALUES(
        'AdamEX Sp. z o.o.',
        '0d58e09f-00ab-46f0-9fd3-086c5b0a47db'
    ),
    (
        'PetroEnergia Sp. z o.o.',
        'a82afcfc-329d-4d5f-b73b-24e6eebce242'
        );

/*
    Paliwa (Stan paliw, które posiada stacja)
*/
INSERT INTO [fuelSupply].[Fuels]
    (FuelTypeId,
    FuelSuppliersId,
    CurrentStock,
    Price)
VALUES(
        1,
        'c1d8f960-e991-46cd-bcb2-0a32d4a4eef7',
        '7666.00',
        '6.98'
    ),
    (
        4,
        'c1d8f960-e991-46cd-bcb2-0a32d4a4eef7',
        '15000.00',
        '6.02'
    ),
    (
        3,
        '7150373f-9581-4641-b2dc-1d340df490d1',
        '8000.00',
        '7.01'
    );

/*
    Zamówienia paliwa
*/
INSERT INTO [fuelSupply].[Orders]
    (FuelSupplierId,
    FuelTypeId,
    Amount,
    Price,
    OrderDate,
    ReceiptDate)
VALUES(
        'c1d8f960-e991-46cd-bcb2-0a32d4a4eef7',
        1,
        '5000.00',
        '6.25',
        '2024-05-20',
        '2024-05-27'
    ),
    (
        '7150373f-9581-4641-b2dc-1d340df490d1',
        3,
        '5000.00',
        '5.70',
        '2024-05-27',
        NULL
    );
