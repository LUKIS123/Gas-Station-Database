----------------------------- SPRZEDAŻ -----------------------------
IF (NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'sales')) 
BEGIN
    EXEC ('CREATE SCHEMA [sales] AUTHORIZATION [dbo]')
END

/*
    Sprzedaż paliw
*/
CREATE TABLE [sales].[Sales]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    EmployeesId int NOT NULL,
    FuelsId int NOT NULL,
    RefuelingTime datetime2 NOT NULL,
    BonusPoints int NOT NULL,
    FuelAmountSold decimal(19, 2) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (EmployeesId) REFERENCES [employees].[Employees] (Id),
    FOREIGN KEY (FuelsId) REFERENCES [fuelSupply].[Fuels] (Id),
);

/*
    Faktury - klient może zażyczyć sobie fakturę za zakup
*/
CREATE TABLE [sales].[Invoices]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    CustomersId UNIQUEIDENTIFIER NOT NULL,
    SalesId UNIQUEIDENTIFIER NOT NULL,
    IssiueDate date NOT NULL,
    TotalAmount int NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (SalesId) REFERENCES [sales].[Sales] (Id),
    FOREIGN KEY (CustomersId) REFERENCES [customers].[Customers] (Id),
);
