/*1. Data: Raw facts and figures that have not been processed. Data can be numbers, text, or symbols but is not meaningful until it is processed and analyzed.

Database: A structured collection of data stored in an organized manner for efficient retrieval, updating, and management. Databases can contain tables, views, and other objects.

Relational Database: A type of database that stores data in tables that are related to each other. Data is organized into rows and columns, with each table having a primary key, and tables can be linked using foreign keys.

Table: A collection of rows (records) and columns (fields) that store data in a relational database. Each row represents a unique record, and each column contains a specific type of data related to the record.
2. Five Key Features of SQL Server:
Scalability: SQL Server can handle a large volume of data and users efficiently.

Security: Provides robust security features like encryption, authentication, and permissions.

High Availability: Supports features such as database mirroring, replication, and failover clustering.

Full-text Search: Supports advanced search capabilities within textual data.

Integration with Other Microsoft Tools: SQL Server integrates well with other Microsoft technologies like Power BI, Azure, and Visual Studio.
3. Authentication Modes in SQL Server:
Windows Authentication: Uses Windows user accounts and groups to log in to SQL Server. The login is authenticated through Active Directory or local user accounts.

SQL Server Authentication: Uses SQL Server-specific logins and passwords, independent of Windows authentication.
4. CREATE DATABASE SchoolDB;
5. CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
6. Differences Between SQL Server, SSMS, and SQL:
SQL Server: A relational database management system (RDBMS) developed by Microsoft for storing, retrieving, and managing data.

SSMS (SQL Server Management Studio): A tool used to manage and interact with SQL Server. It provides an interface to write and execute SQL queries, as well as perform administrative tasks like backups and restoring databases.

SQL (Structured Query Language): A language used to communicate with relational databases. It is used for querying, modifying, and managing data. SQL is used to write commands for SQL Server, among other database systems.

7. SQL Commands Types:
DQL (Data Query Language): Commands used to query the database and retrieve data.

Example: SELECT

DML (Data Manipulation Language): Commands used to modify data within the database.

Example: INSERT, UPDATE, DELETE

DDL (Data Definition Language): Commands used to define and modify database objects like tables, indexes, and views.

Example: CREATE, ALTER, DROP

DCL (Data Control Language): Commands used to control access to the database.

Example: GRANT, REVOKE

TCL (Transaction Control Language): Commands used to manage transactions in the database.

Example: COMMIT, ROLLBACK, SAVEPOINT
8. INSERT INTO Students (StudentID, Name, Age)
VALUES (1, 'John Doe', 20),
       (2, 'Jane Smith', 22),
       (3, 'Alice Johnson', 19);
9. Backup and Restore Database Steps:
Steps to Create a Backup of SchoolDB:
In SSMS, right-click the SchoolDB database.

Select Tasks > Back Up.

In the Backup Database window:

Choose Full as the backup type.

Select a destination for the backup file (disk or tape).

Click OK to start the backup.

Steps to Restore a Database in SSMS:
In SSMS, right-click Databases in the Object Explorer.

Select Restore Database.

In the Restore Database window:

Choose Device and locate the backup file.

Choose the destination database (in this case, SchoolDB).

Click OK to start the restore process.


