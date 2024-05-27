/*
    Sprzedaż według pracowników - z zadanego przedziału czasowego
*/
CREATE OR ALTER PROCEDURE GetEmployeeSalesReport(
    @StartDateTime datetime2,
    @EndDateTime datetime2)
AS
BEGIN
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
    WHERE Sales.RefuelingTime BETWEEN @StartDateTime AND @EndDateTime
    GROUP BY
    Employees.Id,
    Users.FirstName,
    Users.LastName,
    Shifts.Id,
    [Shifts].[Start],
    [Shifts].[End];
END;
