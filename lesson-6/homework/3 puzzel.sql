

--EX1
CREATE TABLE InputTbl (col1 VARCHAR(1), col2 VARCHAR(1))
INSERT INTO InputTbl VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c',  'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

select distinct col1, col2 from InputTbl
--first way
SELECT DISTINCT 
       LEAST(col1, col2) AS col1, 
       GREATEST(col1, col2) AS col2
FROM InputTbl;
--second way
SELECT 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1, 
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl
GROUP BY 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END, 
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END;



--EX2
CREATE TABLE GroupbyMultipleColumns ( ID INT, Typ VARCHAR(1), Value1 VARCHAR(1), Value2 VARCHAR(1), Value3 VARCHAR(1) );

INSERT INTO GroupbyMultipleColumns(
ID, Typ, Value1, Value2, Value3)
VALUES
(1, 'I', 'a', 'b', ''),
(2, 'O', 'a', 'd', 'f'), 
(3, 'I', 'd', 'b', ''), 
(4, 'O', 'g', 'l', ''), 
(5, 'I', 'z', 'g', 'a'),
(6, 'I', 'z', 'g', 'a');


select * from GroupbyMultipleColumns

--way one
SELECT Typ, 
       SUM(CASE WHEN Value1 = 'a' THEN 1 ELSE 0 END) + 
       SUM(CASE WHEN Value2 = 'a' THEN 1 ELSE 0 END) + 
       SUM(CASE WHEN Value3 = 'a' THEN 1 ELSE 0 END) AS a_count
FROM GroupbyMultipleColumns
GROUP BY Typ;

--EX#
CREATE TABLE TESTDuplicateCount ( ID INT, EmpName VARCHAR(100), EmpDate DATETIME );

INSERT INTO TESTDuplicateCount
(ID,EmpName,EmpDate) VALUES
(1,'Pawan','2014-01-05'), 
(2,'Pawan','2014-03-05'), 
(3,'Pawan','2014-02-05'), 
(4,'Manisha','2014-07-05'), 
(5,'Sharlee','2014-09-05'), 
(6,'Barry','2014-02-05'), 
(7,'Jyoti','2014-04-05'), 
(8,'Jyoti','2014-05-05');

select * from TESTDuplicateCount


SELECT EmpName, COUNT(*) AS DuplicateCount
FROM TESTDuplicateCount
GROUP BY EmpName
HAVING COUNT(*) > 1;
