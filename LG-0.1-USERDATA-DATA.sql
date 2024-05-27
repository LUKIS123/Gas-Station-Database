
/*
    Dodanie ról użytkowników - klienci, dostawcy, pracownicy
*/
INSERT INTO [userData].[UserTypes]
    (Name)
VALUES
    ('Customer'),
    ('FuelSupplier'),
    ('Employee');

/*
    Dodanie przykładowych danych użytkowników
*/
INSERT INTO [userData].[Users]
    (FirstName,
    LastName,
    BirthDate,
    Email,
    Phone,
    Address,
    UserTypesId)
VALUES(
        'Adam',
        'Kowalski',
        '2002-05-26',
        'ak@test.com',
        '111111111',
        'Wybrzeże Stanisława Wyspiańskiego 27, 50-370 Wrocław',
        1
    ),
    (
        'Jan',
        'Kowalski',
        '1995-05-11',
        'jk@test.com',
        '222222222',
        'Wybrzeże Stanisława Wyspiańskiego 3, 50-370 Wrocław',
        1
    ),
    (
        'Adam',
        'Dąbrowski',
        '1990-01-11',
        'ad@test.com',
        '333333333',
        'Wybrzeże Stanisława Wyspiańskiego 1, 50-370 Wrocław',
        2
    ),
    (
        'Paweł',
        'Dąbrowski',
        '1969-03-11',
        'pd@test.com',
        '444444444',
        'Wybrzeże Stanisława Wyspiańskiego 99, 50-370 Wrocław',
        2
    ),
    (
        'Piotr',
        'Lewandowski',
        '1977-08-13',
        'pl@test.com',
        '555555555',
        'Wybrzeże Stanisława Wyspiańskiego 101, 50-370 Wrocław',
        3
    ),
    (
        'Andrzej',
        'Lewandowski',
        '1987-09-13',
        'al@test.com',
        '666666666',
        'Wybrzeże Stanisława Wyspiańskiego 102, 50-370 Wrocław',
        3
    ),
    (
        'Katarzyna',
        'Kowalska',
        '1989-03-22',
        'kk@test.com',
        '777777777',
        'Wybrzeże Stanisława Wyspiańskiego 55, 50-370 Wrocław',
        3
    ),
    (
        'Marta',
        'Wiśniewska',
        '1980-06-21',
        'mw@test.com',
        '888888888',
        'Wybrzeże Stanisława Wyspiańskiego 44, 50-370 Wrocław',
        3
    );
