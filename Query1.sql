--შექმენით Base11 მონაცემთა ბაზა პარამეტრების მითითების გარეშე.
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Base11')
BEGIN
    ALTER DATABASE Base11 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Base11;
END
CREATE DATABASE Base11;
GO

GO
--შექმენით Base22 მონაცემთა ბაზა ორი ფაილის მითითების გზით.
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Base22')
BEGIN
    ALTER DATABASE Base22 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Base22;
END
CREATE DATABASE Base22 
ON 
( 
NAME = Base22_1, 
FILENAME = 'C:\Database\Base22_1.mdf',
SIZE = 15MB, 
MAXSIZE = 36MB, 
FILEGROWTH = 3MB 
),
( 
NAME = Base22_2, 
FILENAME = 'C:\Database\Base22_2.ndf',
SIZE = 15MB, 
MAXSIZE = 36MB, 
FILEGROWTH = 3MB 
)
LOG ON
(
NAME = Base22_log,
FILENAME = 'C:\Database\Base22_2log.ldf',
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB 
)
GO

--შექმენით Base33 მონაცემთა ბაზა მონაცემების 2 და ტრანზაქციების ჟურნალის 1 
--ფაილის მითითების გზით. 
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Base33')
BEGIN
    ALTER DATABASE Base33 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Base33;
END
CREATE DATABASE Base33 
ON 
PRIMARY 
( 
NAME = Base33_1, 
FILENAME = 'C:\Database\Base33_dat1.mdf', 
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB 
), 
( 
NAME = Base33_2, 
FILENAME = 'C:\Database\Base33_dat2.ndf', 
SIZE = 50MB, 
MAXSIZE = 100, 
FILEGROWTH = 10 
) 
LOG ON 
( 
NAME = Base33_log1, 
FILENAME = 'C:\Database\Base33_log.ldf', 
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB 
)


--შექმენით Base44 მონაცემთა ბაზა მონაცემების 4 და ტრანზაქციების ჟურნალის 2 
--ფაილის მითითების გზით.
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Base44')
BEGIN
    ALTER DATABASE Base44 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Base44;
END

CREATE DATABASE Base44
ON PRIMARY
(
NAME = Base4_1, 
FILENAME = 'C:\Database\Base44_dat1.mdf', 
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB 
),
(
NAME = Base4_2, 
FILENAME = 'C:\Database\Base44_dat2.ndf', 
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB 
),
(
NAME = Base4_3, 
FILENAME = 'C:\Database\Base44_dat3.ndf', 
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB 
),
(
NAME = Base4_4, 
FILENAME = 'C:\Database\Base44_dat4.ndf', 
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB 
)
LOG ON
(
NAME = Base44_log1, 
FILENAME = 'C:\Database\Base44_log1.ldf', 
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB
),
(
NAME = Base44_log2, 
FILENAME = 'C:\Database\Base44_log2.ldf', 
SIZE = 50MB, 
MAXSIZE = 100MB, 
FILEGROWTH = 10MB
)
GO


--შექმენით Base55 მონაცემთა ბაზა ფაილების ჯგუფების მითითების გზით. Base55
--მონაცემთა ბაზას აქვს PRIMARY ჯგუფი, რომელიც 2 ფაილს შეიცავს; Group1
--ჯგუფი, რომელიც 1 ფაილს შეიცავს; Group2 ჯგუფი, რომელიც 3 ფაილს შეიცავს. 
--Base55 მონაცემთა ბაზას ტრანზაქციების ჟურნალის 2 ფაილი აქვს.

--უბრალოდ სხვანაირი IF Statement-ი გამოვიყენე აზრი და ფუნქცია იგივეა
GO
IF DB_ID('Base55') IS NOT NULL
BEGIN
    ALTER DATABASE Base55 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Base55;
END
CREATE DATABASE Base55
ON PRIMARY
(
NAME = File1_dat,
FILENAME = 'C:\Database\File1dat.mdf',
SIZE = 20MB,
MAXSIZE = 50MB,
FILEGROWTH = 15%
),
(
NAME = File2_dat,
FILENAME = 'C:\Database\File2dat.ndf',
SIZE = 20MB,
MAXSIZE = 50MB,
FILEGROWTH = 15%
),
FILEGROUP Group1
(
NAME = G1F3_dat,
FILENAME = 'C:\Database\G1F3dat.ndf',
SIZE = 20MB,
MAXSIZE = 50MB,
FILEGROWTH = 5MB
),
FILEGROUP Group2
(
NAME = G2F4_dat,
FILENAME = 'C:\Database\G2F4dat.ndf',
SIZE = 20MB,
MAXSIZE = 50MB,
FILEGROWTH = 5MB
),
(
NAME = G2F5_dat,
FILENAME = 'C:\Database\G2F5dat.ndf',
SIZE = 20MB,
MAXSIZE = 50MB,
FILEGROWTH = 5MB
),
(
NAME = G2F6_dat,
FILENAME = 'C:\Database\G2F6dat.ndf',
SIZE = 20MB,
MAXSIZE = 50MB,
FILEGROWTH = 5MB
)
LOG ON
(
NAME = Base55_log1,
FILENAME = 'C:\Database\Base55_log1.ldf',
SIZE = 10MB,
MAXSIZE = 30MB,
FILEGROWTH = 5MB
),
(
NAME = Base55_log2,
FILENAME = 'C:\Database\Base55_log2.ldf',
SIZE = 10MB,
MAXSIZE = 30MB,
FILEGROWTH = 5MB
);
GO







