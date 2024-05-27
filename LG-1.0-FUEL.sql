----------------------------- PALIWA ORAZ ROZLICZANIE SIĘ Z DOSTAWCAMI -----------------------------
IF (NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'fuelSupply')) 
BEGIN
    EXEC ('CREATE SCHEMA [fuelSupply] AUTHORIZATION [dbo]')
END

/*
    Kategoria paliwa
*/
CREATE TABLE [fuelSupply].[FuelTypes]
(
    Id int IDENTITY(1, 1) NOT NULL,
    Name nvarchar(50) NOT NULL UNIQUE,
    Description nvarchar(255) NULL,
    PRIMARY KEY (Id),
);

/*
    Dostawcy Paliw - tabela rozszerza tabelę [userData].[Users]
*/
CREATE TABLE [fuelSupply].[FuelSuppliers]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    CompanyName nvarchar(50) NOT NULL,
    UsersId UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (UsersId) REFERENCES [userData].[Users] (Id),
);
ALTER TABLE [fuelSupply].[FuelSuppliers]
    WITH CHECK ADD CONSTRAINT CK_IsFuelSupplier
    CHECK ([dbo].[checkUserRole](UsersId, 2) = 'True')

/*
    Paliwa (Stan paliw, które posiada stacja)
*/
CREATE TABLE [fuelSupply].[Fuels]
(
    Id int IDENTITY(1, 1) NOT NULL,
    FuelTypeId int NOT NULL,
    FuelSuppliersId UNIQUEIDENTIFIER NOT NULL,
    CurrentStock decimal(19, 2) NOT NULL,
    Price decimal(19, 2) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (FuelTypeId) REFERENCES [fuelSupply].[FuelTypes] (Id),
    FOREIGN KEY (FuelSuppliersId) REFERENCES [fuelSupply].[FuelSuppliers] (Id),
);

/*
    Zamówienia paliwa
*/
CREATE TABLE [fuelSupply].[Orders]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    FuelSupplierId UNIQUEIDENTIFIER NOT NULL,
    FuelTypeId int NOT NULL,
    Amount decimal(19, 2) NOT NULL,
    Price decimal(19, 2) NOT NULL,
    OrderDate date NOT NULL,
    ReceiptDate date NULL,
    Comment nvarchar(255) NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (FuelTypeId) REFERENCES [fuelSupply].[FuelTypes] (Id),
    FOREIGN KEY (FuelSupplierId) REFERENCES [fuelSupply].[FuelSuppliers] (Id),
);

/*
    Dystrybutory
*/
CREATE TABLE [fuelSupply].[FuelDispensers]
(
    Id int IDENTITY(1, 1) NOT NULL,
    Label nvarchar(50) NOT NULL UNIQUE,
    PRIMARY KEY (Id),
);

/*
    Tabela łącząca Dystrybutory z Paliwami
*/
CREATE TABLE [fuelSupply].[DispensersFuels]
(
    Id int IDENTITY(1, 1) NOT NULL,
    DispenserId int NOT NULL,
    FuelId int NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (DispenserId) REFERENCES [fuelSupply].[FuelDispensers] (Id),
    FOREIGN KEY (FuelId) REFERENCES [fuelSupply].[Fuels] (Id),
);
