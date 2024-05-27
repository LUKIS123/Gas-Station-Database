CREATE FUNCTION checkUserRole (
    @userId UNIQUEIDENTIFIER,
    @userRoleId int
)
RETURNS VARCHAR(5)
AS
BEGIN
    IF EXISTS (
        SELECT *
    FROM [userData].[Users]
    WHERE Id = @userId
        AND UserTypesId = @userRoleId
    )
        return 'True'
    return 'False'
END