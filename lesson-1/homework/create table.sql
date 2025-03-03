create database SQLHOMEWORK1
--Table1 salesman
create table salesman (salesman_id int,name varchar(20), city varchar(20), commission DECIMAL(5,2))
insert into salesman values 
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris',0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5007, 'Paul Adam', 'Rome', 0.13),
(5003, 'Lauson Hen', 'San Jose', 0.12);
--Table2 orders
create table orders (ord_no int, purch_amt decimal(7,2), 
ord_date date, customer_id int, salesman_id int )
insert into orders values
(70001, 150.5,   '2012-10-05',3005, 5002),
(70009, 270.65,  '2012-09-10',3001, 5005),
(70002, 65.26,   '2012-10-05',3002, 5001),
(70004, 110.5,   '2012-08-17',3009, 5003),
(70007, 948.5,   '2012-09-10',3005, 5002),
(70005, 2400.6,  '2012-07-27',3007, 5001),
(70008, 5760,    '2012-09-10',3002, 5001),
(70010, 1983.43, '2012-10-10',3004, 5006),
(70003, 2480.4,  '2012-10-10',3009, 5003),
(70012, 250.45,  '2012-06-27',3008, 5002),
(70011, 75.29,   '2012-08-17',3003, 5007),
(70013, 3045.6,  '2012-04-25',3002, 5001);
--Table3 customer
create table customer (customer_id int, cust_name varchar(20), city varchar(20), grade int null, salesman_id int)
insert into customer values
(3002, 'Nick Rimando',  'New York',   100, 5001),
(3007, 'Brad Davis',    'New York',   200, 5001),
(3005, 'Graham Zusi',   'California', 200, 5002),
(3008, 'Julian Green',  'London',     300, 5002),
(3004, 'Fabian Johnson','Paris',      300, 5006),
(3009, 'Geoff Cameron', 'Berlin',     100, 5003),
(3003, 'Jozy Altidor',  'Moscow',     200, 5007),
(3001, 'Brad Guzan',    'London',    null, 5005);
--Table4 nobel_win
create table nobel_win
([YEAR] int, [SUBJECT] varchar(20), WINNER varchar(50), COUNTRY varchar(20),CATEGORY varchar(20))
INSERT INTO nobel_win ([YEAR], [SUBJECT], WINNER, COUNTRY, CATEGORY) VALUES
(1970, 'Physiology', 'Bernard Katz', 'Germany', 'Scientist'),
(1970, 'Literature', 'Aleksandr Solzhenitsyn', 'Russia', 'Linguist'),
(1970, 'Economics', 'Paul Samuelson', 'USA', 'Economist'),
(1970, 'Physiology', 'Julius Axelrod', 'USA', 'Scientist'),
(1971, 'Physics', 'Dennis Gabor', 'Hungary', 'Scientist'),
(1971, 'Chemistry', 'Gerhard Herzberg', 'Germany', 'Scientist'),
(1971, 'Peace', 'Willy Brandt', 'Germany', 'Chancellor'),
(1971, 'Literature', 'Pablo Neruda', 'Chile', 'Linguist'),
(1971, 'Economics', 'Simon Kuznets', 'Russia', 'Economist'),
(1978, 'Peace', 'Anwar al-Sadat', 'Egypt', 'President'),
(1978, 'Peace', 'Menachem Begin', 'Israel', 'Prime Minister'),
(1987, 'Chemistry', 'Donald J. Cram', 'USA', 'Scientist'),
(1987, 'Chemistry', 'Jean-Marie Lehn', 'France', 'Scientist'),
(1987, 'Physiology', 'Susumu Tonegawa', 'Japan', 'Scientist'),
(1987, 'Physics', 'Johannes Georg Bednorz', 'Germany', 'Scientist'),
(1987, 'Literature', 'Joseph Brodsky', 'Russia', 'Linguist'),
(1987, 'Economics', 'Robert Solow', 'USA', 'Economist'),
(1994, 'Economics', 'Reinhard Selten', 'Germany', 'Economist'),
(1994, 'Peace', 'Yitzhak Rabin', 'Israel', 'Prime Minister'),
(1994, 'Literature', 'Kenzaburo Oe', 'Japan', 'Linguist');
--Table5 item_mast
create table item_mast
(PRO_ID int, PRO_NAME varchar(50), PRO_PRICE decimal(10,2), PRO_COM int)
insert into item_mast values 
(101, 'Mother Board', 3200.00, 15),
(102, 'Key Board', 450.00, 16),
(103, 'ZIP drive', 250.00, 14),
(104, 'Speaker', 550.00, 16),
(105, 'Monitor', 5000.00, 11),
(106, 'DVD drive', 900.00, 12),
(107, 'CD drive', 800.00, 12),
(108, 'Printer', 2600.00, 13),
(109, 'Refill cartridge', 350.00, 13),
(110, 'Mouse', 250.00, 12);
--Table6 emp_details
create table emp_details
(EMP_IDNO int, EMP_FNAME varchar(50), EMP_LNAME varchar(25), EMP_DEPT int)
insert  into emp_details values
(127323, 'Michale', 'Robbin', 57),
(526689, 'Carlos', 'Snares', 63),
(843795, 'Enric', 'Dosio', 57),
(328717, 'Jhon', 'Snares', 63),
(444527, 'Joseph', 'Dosni', 47),
(659831, 'Zanifer', 'Emily', 47),
(847674, 'Kuleswar', 'Sitaraman', 57),
(748681, 'Henrey', 'Gabriel', 47),
(555935, 'Alex', 'Manuel', 57),
(539569, 'George', 'Mardy', 27),
(733843, 'Mario', 'Saule', 63),
(631548, 'Alan', 'Snappy', 27),
(839139, 'Maria', 'Foster', 57);
