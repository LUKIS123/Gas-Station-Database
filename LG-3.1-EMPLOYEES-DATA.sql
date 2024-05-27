/*
    Stanowiska pracowników
*/
INSERT INTO [employees].[EmployeePositions]
    (Name)
VALUES(
        'Manager'
),
    (
        'Cashier'
),
    (
        'ServiceWorker'
);

/*
    Pracownicy
*/
INSERT INTO [employees].[Employees]
    (UsersId,
    EmployeePositionId)
VALUES(
        '9cbad43c-76ef-47a2-8439-106faf05f389',
        1
    ),
    (
        'c0b73f01-9469-4eac-a921-98d223969cd9',
        2
    ),
    (
        '1b7c4476-6ffe-4ec8-943b-a4983ab52b38',
        3
    ),
    (
        'dc1a733a-c58c-47b5-a0ec-fc19211b73ca',
        3
    );

/*
    Zmiany pracowników
*/
INSERT INTO [employees].[Shifts]
    (TeamName,
    [Start],
    [End])
VALUES(
        'One',
        '06:00:00.000',
        '14:00:00.000'

),
    (
        'Two',
        '14:00:00.000',
        '22:00:00.000'
),
    (
        'Three',
        '22:00:00.000',
        '06:00:00.000'
);

/*
    Przypisanie pracowników do zmiany
*/
INSERT INTO [employees].[ShiftsEmployees]
    (ShiftsId,
    EmployeesId)
VALUES(
        1,
        1    
),
    (
        1,
        2    
),
    (
        1,
        3    
),
    (
        1,
        4    
);
