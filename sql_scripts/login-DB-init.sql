USE /*[giba_demo]*/
GO
-- will use prefix 'login' to all table names

-- *** *** *** ***
-- dropping constraints and tables (reset)
-- *** *** *** ***

-- Drop constraint if it already exists
-- Table: loginPassword
-- Constraint: FK_loginPassword_loginUser
ALTER TABLE dbo.loginPassword
DROP CONSTRAINT IF EXISTS FK_loginPassword_loginUser
GO
-- Drop the table if it already exists
-- Table: loginPassword
DROP TABLE IF EXISTS dbo.loginPassword
GO

-- Drop constraint if it already exists
-- Table: loginUser
-- Constraint: FK_loginUser_loginRole
ALTER TABLE dbo.loginUser
DROP CONSTRAINT IF EXISTS FK_loginUser_loginRole
GO
-- Drop the table if it already exists
-- Table: loginUser
DROP TABLE IF EXISTS dbo.loginUser
GO

-- Drop the table if it already exists
-- Table: loginRole
DROP TABLE if EXISTS dbo.loginRole
GO
-- end of: dropping constraints and tables


-- *** *** *** ***
-- creating tables: loginRole, loginUser, loginPassword
-- *** *** *** ***
CREATE TABLE loginRole
(
    roleId INT IDENTITY NOT NULL PRIMARY KEY,
    roleName NVARCHAR(50) NOT NULL,
    roleDescription NVARCHAR(255)
)
GO

CREATE TABLE loginUser
(
    userId INT IDENTITY NOT NULL PRIMARY KEY,
    userName NVARCHAR(50) NOT NULL,
    userEmail NVARCHAR(255) NOT NULL,
    FK_roleId INT NOT NULL,

    CONSTRAINT FK_loginUser_loginRole FOREIGN KEY (FK_roleId) REFERENCES loginRole (roleId)
)
GO

CREATE TABLE loginPassword
(
    passwordValue NVARCHAR(255) NOT NULL,
    FK_userId INT NOT NULL,

    CONSTRAINT FK_loginPassword_loginUser FOREIGN KEY (FK_userId) REFERENCES loginUser (userId)
)
GO
-- end of: creating tables


-- *** *** *** ***
-- populating tables with test data for 'Login - workshop part 2'
-- *** *** *** ***
INSERT INTO loginRole
    ([roleName], [roleDescription])
VALUES
    ('admin', 'can do whatever'),
    ('member', 'can do stuff that is allowed')
GO

-- note: as a brand new table, loginRole should have 
--       'admin' with id 1
--       'member' with id 2
INSERT INTO loginUser
    ([userName], [userEmail], [FK_roleId])
VALUES
    ('test-admin', 'admin@login.mail.com', 1),
    ('test-member1', 'member1@login.mail.com', 2),
    ('test-member2', 'member2@login.mail.com', 2)
GO

-- note: as a brand new table, loginUser should have 
--       'test-admin' with id 1
--       'test-member1' with id 2
--       'test-member2' with id 3
INSERT INTO loginPassword
    ([passwordValue], [FK_userId])
VALUES
    ('admin1234', 1),
    ('member1password', 2),
    ('member2password', 3)
GO
-- end of: populating tables with test data

-- *** *** *** ***
-- quick test
-- *** *** *** ***
SELECT *
FROM loginRole
GO

SELECT *
FROM loginUser
GO

SELECT *
FROM loginPassword
GO

SELECT *
FROM loginUser u
    JOIN loginPassword p
    ON u.userId = p.FK_userId
    JOIN loginRole r
    ON u.FK_roleId = r.roleId
WHERE u.userEmail = 'admin@login.mail.com' AND p.passwordValue = 'admin1234'
GO
-- end of: quick test