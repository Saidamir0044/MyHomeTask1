-- Lesson 13: Practice - String, Mathematical, Date and Time Functions

----------------------------
-- 🔰 BEGINNER LEVEL (1–10)
----------------------------
SELECT 
    -- 1️⃣ Extract first 4 characters from 'DATABASE'
    SUBSTRING('DATABASE', 1, 4) AS Q1_ExtractSubstring,

    -- 2️⃣ Find position of 'SQL'
    CHARINDEX('SQL', 'I love SQL Server') AS Q2_FindPosition,

    -- 3️⃣ Replace 'World' with 'SQL'
    REPLACE('Hello World', 'World', 'SQL') AS Q3_ReplaceWord,

    -- 4️⃣ Find string length
    LEN('Microsoft SQL Server') AS Q4_StringLength,

    -- 5️⃣ Get last 3 characters
    RIGHT('Database', 3) AS Q5_Last3Chars,

    -- 6️⃣ Count occurrences of 'a' in each word (only one value at a time shown here)
    LEN('banana') - LEN(REPLACE('banana', 'a', '')) AS Q6_CountA_Banana,

    -- 7️⃣ Remove first 5 characters
    RIGHT('abcdefg', LEN('abcdefg') - 5) AS Q7_RemoveFirst5,

    -- 8️⃣ Extract second word from 'SQL is powerful'
    PARSENAME(REPLACE('SQL is powerful', ' ', '.'), 2) AS Q8_SecondWord1,

    -- 9️⃣ Round 15.6789 to 2 decimals
    ROUND(15.6789, 2) AS Q9_Rounded,

    -- 🔟 Absolute value of -345.67
    ABS(-345.67) AS Q10_AbsoluteValue;

----------------------------
-- 🏆 INTERMEDIATE LEVEL (11–20)
----------------------------
SELECT 
    -- 1️⃣1️⃣ Middle 3 characters from 'ABCDEFGHI' (starts at 4)
    SUBSTRING('ABCDEFGHI', 4, 3) AS Q11_Middle3,

    -- 1️⃣2️⃣ Replace first 3 chars of 'Microsoft' with 'XXX'
    'XXX' + SUBSTRING('Microsoft', 4, LEN('Microsoft')) AS Q12_ReplaceFirst3,

    -- 1️⃣3️⃣ Find position of first space
    CHARINDEX(' ', 'SQL Server 2025') AS Q13_FirstSpace,

    -- 1️⃣4️⃣ Concatenate FirstName & LastName (example values used)
    'John' + ', ' + 'Doe' AS Q14_ConcatenatedName,

    -- 1️⃣5️⃣ Extract third word from 'The database is very efficient'
    PARSENAME(REPLACE('The database is very efficient', ' ', '.'), 3) AS Q15_ThirdWord,

    -- 1️⃣6️⃣ Extract numbers from 'ORD5678'
    SUBSTRING('ORD5678', PATINDEX('%[0-9]%', 'ORD5678'), LEN('ORD5678')) AS Q16_NumberOnly,

    -- 1️⃣7️⃣ Round 99.5 to nearest integer
    ROUND(99.5, 0) AS Q17_RoundNearest,

    -- 1️⃣8️⃣ Days between dates
    DATEDIFF(DAY, '2025-01-01', '2025-03-15') AS Q18_DayDiff,

    -- 1️⃣9️⃣ Get month name from date
    DATENAME(MONTH, '2025-06-10') AS Q19_MonthName,

    -- 2️⃣0️⃣ Week number of date
    DATEPART(WEEK, '2025-04-22') AS Q20_WeekNumber;

----------------------------
-- 🚀 ADVANCED LEVEL (21–30)
----------------------------
SELECT 
    -- 2️⃣1️⃣ Extract domain after '@'
    RIGHT('user1@gmail.com', LEN('user1@gmail.com') - CHARINDEX('@', 'user1@gmail.com')) AS Q21_Domain1,

    -- 2️⃣2️⃣ Last occurrence of 'e' in 'experience'
    LEN('experience') - CHARINDEX('e', REVERSE('experience')) + 1 AS Q22_LastE,

    -- 2️⃣3️⃣ Random number between 100–500
    CAST(RAND() * (500 - 100) + 100 AS INT) AS Q23_Random100_500,

    -- 2️⃣4️⃣ Format number with commas
    FORMAT(9876543, 'N0') AS Q24_FormatWithCommas,

    -- 2️⃣5️⃣ Extract first name from 'John Doe'
    LEFT('John Doe', CHARINDEX(' ', 'John Doe') - 1) AS Q25_FirstName,

    -- 2️⃣6️⃣ Replace spaces with dashes
    REPLACE('SQL Server is great', ' ', '-') AS Q26_SpacesToDashes,

    -- 2️⃣7️⃣ Pad 42 with zeros to make 5-digit string
    RIGHT('00000' + CAST(42 AS VARCHAR), 5) AS Q27_PadZeros,

    -- 2️⃣8️⃣ Length of longest word in 'SQL is fast and efficient'
    (SELECT MAX(LEN(value)) 
     FROM STRING_SPLIT('SQL is fast and efficient', ' ')) AS Q28_LongestWordLength,

    -- 2️⃣9️⃣ Remove first word from 'Error: Connection failed'
    STUFF('Error: Connection failed', 1, CHARINDEX(' ', 'Error: Connection failed'), '') AS Q29_RemoveFirstWord,

    -- 3️⃣0️⃣ Minutes between two times
    DATEDIFF(MINUTE, '08:15:00', '09:45:00') AS Q30_MinuteDiff;
