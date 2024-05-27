/*
    Monitorowanie stanu paliw
*/
GO
CREATE OR ALTER VIEW FuelStockStatus
AS
    SELECT
        Fuels.Id AS FuelId,
        FuelTypes.Id AS TypeId,
        FuelTypes.Name AS TypeName,
        FuelSuppliers.Id AS SupplierId,
        FuelSuppliers.CompanyName AS SupplierCompanyName,
        Fuels.CurrentStock,
        Fuels.Price,
        (SELECT COALESCE(SUM(Amount), 0.0)
        FROM [fuelSupply].[Orders]
        WHERE FuelTypeId = FuelTypes.Id
            AND FuelSupplierId = FuelSuppliers.Id
            AND ReceiptDate IS NULL) AS FuelAmountInOrder
    FROM
        [fuelSupply].[Fuels] INNER JOIN
        [fuelSupply].[FuelTypes] ON Fuels.FuelTypeId = FuelTypes.Id INNER JOIN
        [fuelSupply].[FuelSuppliers] ON Fuels.FuelSuppliersId = FuelSuppliers.Id;

GO
/*
    Sprzedaż według pracowników - całość
*/
CREATE OR ALTER VIEW EmployeeSalesReport
AS
    SELECT
        Employees.Id AS EmployeeId,
        CONCAT(Users.FirstName, ' ', Users.LastName) AS Employee,
        Shifts.Id AS ShiftId,
        CONCAT (CAST([Shifts].[Start] AS varchar(5)), ' - ', CAST([Shifts].[End] AS varchar(5))) AS Shift,
        SUM(Sales.FuelAmountSold) AS TotalFuelAmountSold,
        SUM(Sales.BonusPoints) AS TotalBonusPoints
    FROM
        [sales].[Sales] INNER JOIN
        [fuelSupply].[Fuels] ON Sales.FuelsId = Fuels.Id INNER JOIN
        [fuelSupply].[FuelTypes] ON Fuels.FuelTypeId = FuelTypes.Id INNER JOIN
        [fuelSupply].[FuelSuppliers] ON Fuels.FuelSuppliersId = FuelSuppliers.Id INNER JOIN
        [employees].[Employees] ON Sales.EmployeesId = Employees.Id INNER JOIN
        [employees].[ShiftsEmployees] ON Employees.Id = ShiftsEmployees.EmployeesId INNER JOIN
        [employees].[Shifts] ON ShiftsEmployees.ShiftsId = Shifts.Id INNER JOIN
        [userData].[Users] ON Employees.UsersId = Users.Id
    GROUP BY
    Employees.Id,
    Users.FirstName,
    Users.LastName,
    Shifts.Id,
    [Shifts].[Start],
    [Shifts].[End];

GO
/*
    Sprzedaż według rodzaju paliwa - całość
*/
CREATE OR ALTER VIEW FuelSalesReport
AS
    SELECT
        Sales.FuelsId,
        FuelTypes.Name AS FuelTypeName,
        FuelSuppliers.Id AS SupplierId,
        FuelSuppliers.CompanyName AS SupplierCompanyName,
        Shifts.Id AS ShiftId,
        SUM(Sales.FuelAmountSold) AS TotalFuelAmountSold,
        SUM(Sales.BonusPoints) AS TotalBonusPoints
    FROM
        [sales].[Sales] INNER JOIN
        [fuelSupply].[Fuels] ON Sales.FuelsId = Fuels.Id INNER JOIN
        [fuelSupply].[FuelTypes] ON Fuels.FuelTypeId = FuelTypes.Id INNER JOIN
        [fuelSupply].[FuelSuppliers] ON Fuels.FuelSuppliersId = FuelSuppliers.Id INNER JOIN
        [employees].[Employees] ON Sales.EmployeesId = Employees.Id INNER JOIN
        [employees].[ShiftsEmployees] ON Employees.Id = ShiftsEmployees.EmployeesId INNER JOIN
        [employees].[Shifts] ON ShiftsEmployees.ShiftsId = Shifts.Id
    GROUP BY
Sales.FuelsId,
FuelTypes.Name,
FuelSuppliers.Id,
FuelSuppliers.CompanyName,
Shifts.Id;
