----------------------------- KLIENCI ORAZ KREDYTY NAJLEPSZYCH KLIENTÓW -----------------------------
IF (NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'customers')) 
BEGIN
    EXEC ('CREATE SCHEMA [customers] AUTHORIZATION [dbo]')
END

/*
    Klienci - tabela rozszerza tabelę [userData].[Users]
*/
CREATE TABLE [customers].[Customers]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    UsersId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (UsersId) REFERENCES [userData].[Users] (Id),
);
ALTER TABLE [customers].[Customers]
    WITH CHECK ADD CONSTRAINT CK_IsCustomer
    CHECK ([dbo].[checkUserRole](UsersId, 1) = 'True')

/*
    Bilans kont klientów z dostępem do indywidualnych kart kredytowych
*/
CREATE TABLE [customers].[CustomerCredits]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    CustomersId UNIQUEIDENTIFIER NOT NULL,
    TotalAmount decimal(19, 2) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (CustomersId) REFERENCES [customers].[Customers] (Id),
);

/*  
    Rozliczenia klientów z dostępem do indywidualnych kart kredytowych
*/
CREATE TABLE [customers].[MonthlySettlements]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    CustomersId UNIQUEIDENTIFIER NOT NULL,
    IssiueDate date NOT NULL,
    PaymentDate date NULL,
    PaymentAmount decimal(19, 2) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (CustomersId) REFERENCES [customers].[Customers] (Id),
);
