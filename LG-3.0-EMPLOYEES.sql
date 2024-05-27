----------------------------- PRACOWNICY I ORGANIZACJA PRACY -----------------------------
IF (NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'employees')) 
BEGIN
    EXEC ('CREATE SCHEMA [employees] AUTHORIZATION [dbo]')
END

/*
    Stanowiska pracowników
*/
CREATE TABLE [employees].[EmployeePositions]
(
    Id int IDENTITY(1, 1) NOT NULL,
    Name varchar(50) NOT NULL,
    PRIMARY KEY (Id),
);

/*
    Pracownicy - tabela rozszerza tabelę [userData].[Users]
*/
CREATE TABLE [employees].[Employees]
(
    Id int IDENTITY(1, 1) NOT NULL,
    UsersId UNIQUEIDENTIFIER NOT NULL,
    EmployeePositionId int NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (UsersId) REFERENCES [userData].[Users] (Id),
    FOREIGN KEY (EmployeePositionId) REFERENCES [employees].[EmployeePositions] (Id),
);
ALTER TABLE [employees].[Employees]
    WITH CHECK ADD CONSTRAINT CK_IsEmployee
    CHECK ([dbo].[checkUserRole](UsersId, 3) = 'True')

/*
    Zmiany pracowników
*/
CREATE TABLE [employees].[Shifts]
(
    Id int IDENTITY(1, 1) NOT NULL,
    TeamName varchar(50) NOT NULL,
    [Start] time(3) NOT NULL,
    [End] time(3) NOT NULL,
    PRIMARY KEY (Id),
);

/*
    Tabela łącząca pracowników ze zmianami do których przynależą
*/
CREATE TABLE [employees].[ShiftsEmployees]
(
    Id int IDENTITY(1, 1) NOT NULL,
    ShiftsId int NOT NULL,
    EmployeesId int NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (ShiftsId) REFERENCES [employees].[Shifts] (Id),
    FOREIGN KEY (EmployeesId) REFERENCES [employees].[Employees] (Id),
);
