/*
    Klienci
*/
INSERT INTO [customers].[Customers]
    (UsersId)
VALUES(
        '1fc99834-6ec1-4002-8872-47a10e39f8d9'
    ),
    (
        '57833541-f32d-4b71-b2af-cdcc82f9789d'
    );

/*
    Bilans kont klientów
*/
INSERT INTO [customers].[CustomerCredits]
    (CustomersId,
    TotalAmount)
VALUES(
        '19a5040f-a770-403d-88df-6ececd1ebc82',
        '523.32'
    ),
    (
        '1a202ffb-118e-4bfe-8941-f9c91ee6313d',
        '2123.43'
    );

/*  
    Rozliczenia klientów
*/
INSERT INTO [customers].[MonthlySettlements]
    (CustomersId,
    IssiueDate,
    PaymentDate,
    PaymentAmount
    )
VALUES(
        '19a5040f-a770-403d-88df-6ececd1ebc82',
        '2024-04-30',
        NULL,
        '523.32'
    ),
    (
        '1a202ffb-118e-4bfe-8941-f9c91ee6313d',
        '2024-04-30',
        NULL,
        '2123.43'
    );
