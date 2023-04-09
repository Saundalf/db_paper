 --მიიღეთ ინფორმაცია Base11 მონაცემთა ბაზის შესახებ
GO 
 EXEC sp_helpdb 'Base11';
GO

 --წაშალეთ Base11 მონაცემთა ბაზა. 
GO 
IF DB_ID('Base11') IS NOT NULL
BEGIN
    DROP DATABASE Base11;
END
GO

--Base22 მონაცემთა ბაზას შეუცვალეთ სახელი. ახალი სახელია Base_66
GO
ALTER DATABASE Base22
MODIFY NAME = Base_66;
GO

--სერვერიდან გამორთეთ Base22 მონაცემთა ბაზა.
GO 
EXEC sp_detach_db 'Base_66';
GO

-- სერვერს მიუერთეთ Base22 მონაცემთა ბაზა მონაცემებისა და ტრანზაქციების
-- ჟურნალის ფაილების მითითების გზით
GO
EXEC sp_attach_db 'Base_66', 
'C:\Database\Base22_1.mdf',
'C:\Database\Base22_2.ndf',
'C:\Database\Base22_2log.ldf';
GO

--შეცვალეთ Base22 მონაცემთა ბაზის სახელი. ახალი სახელია Base_22.
GO
ALTER DATABASE Base_66
MODIFY NAME = Base_22;
GO

--Base_22 მონაცემთა ბაზას 'Base22_dat21.ndf' ფაილი დაუმატეთ. 
GO
ALTER DATABASE Base_22
ADD FILE
(
NAME = Base22_dat21,
FILENAME = 'C:\Database\Base22_dat21.ndf',
SIZE = 25MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 10MB
)
GO

--Base_22 მონაცემთა ბაზას 'Base22_dat22.ndf' და 'Base22_dat23.ndf' ფაილები
--დაუმატეთ
ALTER DATABASE Base_22
ADD FILE
(
NAME = Base22_dat22,
FILENAME = 'C:\Database\Base22_dat22.ndf',
SIZE = 15MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 10MB
),
(
NAME = Base22_dat23,
FILENAME = 'C:\Database\Base22_dat23.ndf',
SIZE = 15MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 10MB
)
--Base_22 მონაცემთა ბაზას 'Group_21' ჯგუფი დაუმატეთ.
ALTER DATABASE Base_22
ADD FILEGROUP Group_21; 
GO

--Base_22 მონაცემთ ბაზას 'Group_22' და 'Group_23' ჯგუფები დაუმატეთ. 
GO
ALTER DATABASE Base_22
ADD FILEGROUP Group_22; 
ALTER DATABASE Base_22
ADD FILEGROUP Group_23;
GO

--Base_22 მონაცემთა ბაზას 'Base22_dat24.ndf' და 'Base22_dat25.ndf' ფაილები დაუმატეთ და ისინი Group_21 ჯგუფში მოათავსეთ 
GO
ALTER DATABASE Base_22
ADD FILE
( 
NAME = Base22_dat24,
FILENAME = 'C:\Database\Base22_dat24.ndf',
SIZE = 25MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 5MB
),
( 
NAME = Base4_dat25,
FILENAME = 'C:\Database\Base22_dat25.ndf',
SIZE = 25MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 5MB
)
TO FILEGROUP Group_21;
GO

--Base_22 მონაცემთა ბაზიდან 'Base22_dat21.ndf' ფაილი წაშალეთ. 
GO
ALTER DATABASE Base_22
REMOVE FILE Base22_dat21
GO

--Base_22 მონაცემთა ბაზიდან 'Group_23' ჯგუფი წაშალეთ 
GO
ALTER DATABASE Base_22
REMOVE FILEGROUP Group_23
GO

--Base_22 მონაცემთა ბაზაში 'Base22_dat22.ndf' ფაილის ზომა შეცვალეთ. ახალი 
--მნიშვნელობაა - 47MB. 
GO
ALTER DATABASE Base_22
MODIFY FILE
(
NAME = Base22_dat22,
SIZE = 47MB
)
GO

--Base_22 მონაცემთა ბაზაში 'Base22_dat22.ndf' ფაილის ინკრემენტის მნიშვნელობა შეცვალეთ. ახალი მნიშვნელობაა - 6MB 
GO
ALTER DATABASE Base_22
MODIFY FILE
(
NAME = Base22_dat22,
FILEGROWTH = 6MB
)
GO

--Base_22 მონაცემთა ბაზაში შეცვალეთ 'Base22_dat22.ndf' ფაილის ზომა და ინკრემენტი. ახალი მნიშვნელობებია 25MB და 8MB.
--Base22_dat22.ndf fileze ar madzlevs sashualebas rom 25MB mivanicho, radgan manamde failis zomas vcvli 25MB-it da migdebs errors
--MODIFY FILE failed. Specified size is less than or equal to current size.
--amitom SIZE mivcem 50MB
GO
ALTER DATABASE Base_22
MODIFY FILE
(
NAME = Base22_dat22,
SIZE = 50MB,
FILEGROWTH = 8MB
)
GO

--Base_22 მონაცემთა ბაზაში 'Group_22' ჯგუფი გახადეთ ნაგულისხმევი. 
GO
ALTER DATABASE Base_22 
--raxan Group_22 shi davalebis mixedvit araferi mqonda misabmeli migdeb am errors:
--Cannot change the properties of empty filegroup 'Group_22'. The filegroup must contain at least one file.
--shesabamisad Group_21s gavxdi nagulisxmevs
MODIFY FILEGROUP Group_21 DEFAULT; 
GO

--Base_22 მონაცემთა ბაზა გადაიყვანეთ 'Single User' რეჟიმში. 
GO
ALTER DATABASE Base_22
SET SINGLE_USER;
GO

--Base_22 მონაცემთა ბაზა გადაიყვანეთ 'Multi User' რეჟიმში.
GO
ALTER DATABASE Base_22
SET MULTI_USER; 
GO