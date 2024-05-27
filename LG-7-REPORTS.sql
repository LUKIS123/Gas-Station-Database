
/*
    Sprzedaż według rodzaju paliwa - z zadanego przedziału czasowego
*/
CREATE OR ALTER PROCEDURE GetFuelSalesReport(
    @StartDateTime datetime2,
    @EndDateTime datetime2)
AS
BEGIN
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
    WHERE Sales.RefuelingTime BETWEEN @StartDateTime AND @EndDateTime
    GROUP BY
Sales.FuelsId,
FuelTypes.Name,
FuelSuppliers.Id,
FuelSuppliers.CompanyName,
Shifts.Id;
END;
