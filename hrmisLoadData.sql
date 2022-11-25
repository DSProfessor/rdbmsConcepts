--create database hrmis
CREATE database hrmis; 

-- Create table to connect titles and title ID numbers.
CREATE TABLE titles (
    title_id VARCHAR(10)    NOT NULL,
    title VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);

-- Pull data for this table from Data/titles.
BULK INSERT dbo.titles
FROM 'C:\Users\Alok-HomePC\Documents\Teaching\IIM Ranchi RDBMS SQL Course\sql-challenge-main\sql-handson-2022\Data\titles.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2,
		FIELDTERMINATOR = ',', 
		ROWTERMINATOR = '0x0a'
)
GO

-- Create table to hold all employee information.
CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR(5)   NOT NULL,
    birth_date VARCHAR(10)   NOT NULL,
    first_name VARCHAR(30)   NOT NULL,
    last_name VARCHAR(30)   NOT NULL,
    sex VARCHAR(1)   NOT NULL,
    hire_date VARCHAR(10)   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

-- Pull data for this table from Data/employees.
BULK INSERT dbo.employees
FROM 'C:\Users\Alok-HomePC\Documents\Teaching\IIM Ranchi RDBMS SQL Course\sql-challenge-main\sql-handson-2022\Data\employees.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2,
		FIELDTERMINATOR = ',', 
		ROWTERMINATOR = '0x0a'
)
GO

-- Create table to connect employees by ID with salaries.
CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (
        emp_no
     )
);

-- Pull data for this table from Data/salaries.
BULK INSERT dbo.salaries
FROM 'C:\Users\Alok-HomePC\Documents\Teaching\IIM Ranchi RDBMS SQL Course\sql-challenge-main\sql-handson-2022\Data\salaries.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2,
		FIELDTERMINATOR = ',', 
		ROWTERMINATOR = '0x0a'
)
GO


-- Create table to connect department ID numbers with department names.
CREATE TABLE departments (
    dept_no VARCHAR(4)   NOT NULL,
    dept_name VARCHAR(30)   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

-- Pull data for this table from Data/departments.
BULK INSERT dbo.departments
FROM 'C:\Users\Alok-HomePC\Documents\Teaching\IIM Ranchi RDBMS SQL Course\sql-challenge-main\sql-handson-2022\Data\departments.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2,
		FIELDTERMINATOR = ',', 
		ROWTERMINATOR = '0x0a'
)
GO

-- Create table to connect title names and title ID numbers.
CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR(4)   NOT NULL
);

-- Pull data for this table from Data/dept_emp.
BULK INSERT dbo.dept_emp
FROM 'C:\Users\Alok-HomePC\Documents\Teaching\IIM Ranchi RDBMS SQL Course\sql-challenge-main\sql-handson-2022\Data\dept_emp.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2,
		FIELDTERMINATOR = ',', 
		ROWTERMINATOR = '0x0a'
)
GO

-- Create table to connect employees by ID numbers with departments by ID numbers.
CREATE TABLE dept_manager (
    dept_no VARCHAR(4)   NOT NULL,
    emp_no INT   NOT NULL
);

-- Pull data for this table from Data/dept_manager.
BULK INSERT dbo.dept_manager
FROM 'C:\Users\Alok-HomePC\Documents\Teaching\IIM Ranchi RDBMS SQL Course\sql-challenge-main\sql-handson-2022\Data\dept_manager.csv'
WITH
(
        FORMAT='CSV',
        FIRSTROW=2,
		FIELDTERMINATOR = ',', 
		ROWTERMINATOR = '0x0a'
)
GO




-- Set constraints for foreign keys.


ALTER TABLE salaries ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);

ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

ALTER TABLE dept_manager ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);
