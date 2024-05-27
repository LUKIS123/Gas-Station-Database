----------------------------- DANE UŻYTKOWNIKÓW -----------------------------
IF (NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'userData')) 
BEGIN
    EXEC ('CREATE SCHEMA [userData] AUTHORIZATION [dbo]')
END

/*
    Kategoria użytkowników
*/
CREATE TABLE [userData].[UserTypes]
(
    Id int IDENTITY(1,1) NOT NULL,
    Name nvarchar(50) NOT NULL,
    PRIMARY KEY (Id)
);

/*
    Dane użytkowników (Pracowników, dostawców paliw, klientów) przechowywane są w jednej tabelii
*/
CREATE TABLE [userData].[Users]
(
    Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    FirstName nvarchar(50) NOT NULL,
    LastName nvarchar(50) NOT NULL,
    BirthDate date NOT NULL,
    Email nvarchar(255) NOT NULL UNIQUE,
    Phone nvarchar(12) NOT NULL UNIQUE,
    Address nvarchar(255) NOT NULL UNIQUE,
    UserTypesId int NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (UserTypesId) REFERENCES [userData].[UserTypes] (Id),
    CONSTRAINT CHK_Phone_Format CHECK (
        (Phone LIKE '+%' AND Phone NOT LIKE '%[^0-9]%') OR
        (Phone NOT LIKE '+%' AND Phone LIKE '%[0-9]%' AND Phone NOT LIKE '%[^0-9]%')
    ),
    CONSTRAINT CHK_Email_Format CHECK (
        Email LIKE '%_@__%.__%' AND
        Email NOT LIKE '%[^a-zA-Z0-9@._-]%' AND
        Email NOT LIKE '%@%@%'
    ),
);
