USE Shekveta;

--Scalar ტიპის ფუნქციები 

IF OBJECT_ID('dbo.MinXelfasi', 'FN') IS NOT NULL
	DROP FUNCTION MinXelfasi;

--გამოთვალეთ მითითებული განყოფილების მინიმალური ხელფასი.
GO
CREATE FUNCTION MinXelfasi(@ganyofileba NVARCHAR(30))
RETURNS FLOAT
AS
BEGIN
DECLARE @minXelfasi FLOAT;
SET @minXelfasi = 
(
SELECT Min(xelfasi)
FROM Personali
WHERE ganyofileba = @ganyofileba
)
RETURN @minXelfasi;
END
GO
SELECT dbo.MinXelfasi(N'სავაჭრო') AS 'მინიმალური ხელფასი'

IF OBJECT_ID('dbo.AverageXelfasi', 'FN') IS NOT NULL
	DROP FUNCTION AverageXelfasi

--გამოთვალეთ მითითებული განყოფილების საშუალო ხელფასი 
GO
CREATE FUNCTION AverageXelfasi(@ganyofileba NVARCHAR(30))
RETURNS FLOAT
AS
BEGIN
DECLARE @averageXelfasi FLOAT
SET @averageXelfasi = 
(
SELECT AVG(xelfasi)
FROM Personali
WHERE ganyofileba = @ganyofileba
)
RETURN @averageXelfasi
END
GO
SELECT dbo.AverageXelfasi(N'სავაჭრო') AS 'საშუალო ხელფასი'


IF OBJECT_ID('dbo.MinAge', 'FN') IS NOT NULL
	DROP FUNCTION MinAGe

--გამოთვალეთ მითითებული განყოფილების მინიმალური ასაკი. 
GO
CREATE FUNCTION MinAge(@ganyofileba NVARCHAR(30))
RETURNS INT
AS
BEGIN
DECLARE @minAge INT
SET @minAge =
(
SELECT MIN(asaki)
FROM Personali
WHERE ganyofileba = @ganyofileba
)
RETURN @minAge;
END
GO
SELECT dbo.MinAge(N'სასპორტო') AS 'მინიმალური ასაკი';

IF OBJECT_ID('dbo.AverageAge', 'FN') IS NOT NULL
	DROP FUNCTION AverageAge;
GO

--გამოთვალეთ მითითებული განყოფილების საშუალო ასაკი. 
CREATE FUNCTION AverageAge(@ganyofileba NVARCHAR(30))
RETURNS INT
AS
BEGIN
DECLARE @avgAge INT
SET @avgAge = 
(
SELECT AVG(asaki)
FROM Personali
WHERE ganyofileba = @ganyofileba
)
RETURN @avgAge;
END
GO

SELECT dbo.AverageAge(N'სავაჭრო') AS N'საშუალო ასაკი'


--შეადგინეთ Scalar ტიპის ფუნქცია, რომელიც გამოთვლის და გასცემს ხელშეკრულების მაქსიმალურ თანხას, 
--რომელიც გაფორმდა 2002 წლის 1 იანვრიდან 2005 წლის 1 იანვრამდე. 
--ფუნქციას პარამეტრად გადაეცემა ორივე თარიღი.
IF OBJECT_ID('dbo.MaxInRange', 'FN') IS NOT NULL
	DROP FUNCTION MaxInRange;
GO
CREATE FUNCTION MaxInRange(@tarigi_dawyebis DATE, @tarigi_damtavrebis DATE)
RETURNS FLOAT
AS
BEGIN
DECLARE @maxTanxa FLOAT
SET @maxTanxa = 
(
SELECT MAX(gadasaxdeli_l)
FROM Xelshekruleba
WHERE tarigi_dawyebis > @tarigi_dawyebis AND tarigi_damtavrebis < @tarigi_damtavrebis
)
RETURN @maxTanxa;
END
GO
SELECT dbo.MaxInRange('2002/01/01', '2005/01/01') AS N'ხელშეკრულების მაქსიმალური თანხა'

--inline ტიპის ფუნქციები
IF OBJECT_ID('dbo.Sashualo_Xelfasi', N'IF') IS NOT NULL
	DROP FUNCTION Sashualo_Xelfasi;

--გამოთვალეთ საშუალო ხელფასი განყოფილებების მიხედვით.
GO
CREATE FUNCTION Sashualo_Xelfasi()
RETURNS TABLE
AS
RETURN
SELECT ganyofileba AS N'განყოფილება', AVG(xelfasi) AS N'საშუალო ხელფასი'
FROM Personali
GROUP BY ganyofileba;
GO

SELECT *
FROM Sashualo_Xelfasi()


IF OBJECT_ID('dbo.Maxx_Xelfasi', N'IF') IS NOT NULL
	DROP FUNCTION Maxx_Xelfasi;

--გამოთვალეთ მაქსიმალური ხელფასი განყოფილებების მიხედვით.
GO
CREATE FUNCTION Maxx_Xelfasi()
RETURNS TABLE
AS
RETURN
SELECT ganyofileba AS N'განყოფილება', MAX(xelfasi) AS N'მაქსიმალური ხელფასი'
FROM Personali
GROUP BY ganyofileba;
GO

SELECT *
FROM Maxx_Xelfasi()


IF OBJECT_ID('dbo.Min_Xelfasi', N'IF') IS NOT NULL
	DROP FUNCTION Min_Xelfasi;

--გამოთვალეთ მინიმალური ხელფასი განყოფილებების მიხედვით. 
GO
CREATE FUNCTION Min_Xelfasi()
RETURNS TABLE
AS
RETURN
SELECT ganyofileba AS N'განყოფილება', MIN(xelfasi) AS N'მინიმალური ხელფასი'
FROM Personali
GROUP BY ganyofileba;
GO

SELECT *
FROM Min_Xelfasi()



IF OBJECT_ID('dbo.Min_Age', N'IF') IS NOT NULL
	DROP FUNCTION Min_Age;

--გამოთვალეთ მინიმალური ასაკი განყოფილებების მიხედვით.
GO
CREATE FUNCTION Min_Age()
RETURNS TABLE
AS
RETURN
SELECT ganyofileba AS N'განყოფილება', MIN(asaki) AS N'მინიმალური ასაკი'
FROM Personali
GROUP BY ganyofileba;
GO

SELECT *
FROM Min_Age()



IF OBJECT_ID('Iuridiuli_Pirebi', N'IF') IS NOT NULL
	DROP FUNCTION Iuridiuli_Pirebi

--შეადგინეთ Inline ტიპის ფუნქცია, რომელიც გასცემს ინფორმაციას მითითებულ ქალაქში მცხოვრები თანამშრომლების შესახებ. 
--ფუნქციას პარამეტრად გადაეცემა ქალაქი. 
GO
CREATE FUNCTION Iuridiuli_Pirebi(@qalaqi NVARCHAR(30), @iuridiuli_fizikuri NVARCHAR(30))
RETURNS TABLE
AS
RETURN
SELECT *
FROM Shemkveti
WHERE iuridiuli_fizikuri = @iuridiuli_fizikuri AND qalaqi = @qalaqi;
GO

SELECT iuridiuli_fizikuri, gvari, qalaqi
FROM Iuridiuli_Pirebi(N'თბილისი', N'იურიდიული')

--IF OBJECT_ID('dbo.GetLowValueContracts', N'IF') IS NOT NULL
--	DROP FUNCTION GetLowValueContracts;
--შეადგინეთ Inline ტიპის ფუნქცია, რომელიც გასცემს ინფორმაციას იმ ხელშეკრულებების შესახებ, რომლებიც გაფორმდა 
--მითითებულ წელს და რომელთა თანხა ნაკლებია პარამეტრით მითითებულ თანხაზე. 
--ფუნქციას პარამეტრად გადაეცემა თანხა და თარიღი. 
--GO
--CREATE FUNCTION GetLowValueContracts(@gadasaxdeli_l FLOAT, @tarigi_dawyebis DATE)
--RETURNS TABLE
--AS
--RETURN (
 --   SELECT *
--    FROM Xelshekruleba
--    WHERE tarigi_dawyebis = @tarigi_dawyebis
     --   AND gadasaxdeli_l < @gadasaxdeli_l
--)
--GO
--SELECT tarigi_dawyebis, gadasaxdeli_l
--FROM GetLowValueContracts(6000, '2002\01\01')


--შენახული პროცედურები

--შექმენით შენახული პროცედურა, რომელსაც გადავცემთ განყოფილების სახელს და მივიღებთ 
--ინფორმაციას ამ განყოფილებაში მომუშავე თანამშრომლების შესახებ.
GO
IF OBJECT_ID ('ProcInfo', 'P' ) IS NOT NULL
DROP PROCEDURE ProcInfo;
GO
CREATE PROCEDURE ProcInfo @ganyofileba NVARCHAR(30)
AS
SELECT *
FROM Personali

WHERE ganyofileba = @ganyofileba
GO
EXEC ProcInfo N'სამედიცინო';

--შექმენით შენახული პროცედურა, რომელსაც გადავცემთ ქალაქის სახელს და 
--მივიღებთ ინფორმაციას ამ ქალაქში მომუშავე თანამშრომლების შესახებ. 

GO
IF OBJECT_ID ('ProcInfoQalaqi', 'P' ) IS NOT NULL
DROP PROCEDURE ProcInfoQalaqi;
GO
CREATE PROCEDURE ProcInfoQalaqi @qalaqi NVARCHAR(30)
AS
SELECT *
FROM Personali

WHERE qalaqi = @qalaqi
GO
EXEC ProcInfoQalaqi N'ქუთაისი';

--შეადგინეთ შენახული პროცედურა, რომელიც გასცემს მითითებული განყოფილების თანამშრომლების სიას. 
--ავტომატურ მნიშვნელობად მითითებულია 'სასპორტო' 

GO
IF OBJECT_ID ('ProcInfoGan', 'P' ) IS NOT NULL
DROP PROCEDURE ProcInfoGan;
GO
CREATE PROCEDURE ProcInfoGan @ganyofileba NVARCHAR(30) = N'სასპორტო'
AS
SELECT *
FROM Personali

WHERE ganyofileba = @ganyofileba
GO
EXEC ProcInfoGan;

--შეადგინეთ შენახული პროცედურა, რომელიც გასცემს მითითებული ქალაქის თანამშრომლების სიას. 
--ავტომატურ მნიშვნელობად მითითებულია 'ბათუმი'.
GO
IF OBJECT_ID ('ProcInfoQalaqi', 'P' ) IS NOT NULL
DROP PROCEDURE ProcInfoQalaqi;
GO
CREATE PROCEDURE ProcInfoQalaqi @qalaqi NVARCHAR(30) = N'ბათუმი'
AS
SELECT *
FROM Personali

WHERE qalaqi = @qalaqi
GO
EXEC ProcInfoQalaqi;