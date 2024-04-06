create database HR;

use  HR;

/* *************************************************************** 
***************************CREATING TABLES************************
**************************************************************** */
CREATE TABLE regions (
	region_id INT (11) UNSIGNED NOT NULL,
	region_name VARCHAR(25),
	PRIMARY KEY (region_id)
	);

CREATE TABLE countries (
	country_id CHAR(2) NOT NULL,
	country_name VARCHAR(40),
	region_id INT (11) UNSIGNED NOT NULL,
	PRIMARY KEY (country_id)
);


CREATE TABLE locations (
	location_id INT (11) UNSIGNED NOT NULL AUTO_INCREMENT,
	street_address VARCHAR(40),
	postal_code VARCHAR(12),
	city VARCHAR(30) NOT NULL,
	state_province VARCHAR(25),
	country_id CHAR(2) NOT NULL,
	PRIMARY KEY (location_id)
	);

CREATE TABLE departments (
	department_id INT (11) UNSIGNED NOT NULL,
	department_name VARCHAR(30) NOT NULL,
	manager_id INT (11) UNSIGNED,
	location_id INT (11) UNSIGNED,
	PRIMARY KEY (department_id)
	);

CREATE TABLE jobs (
	job_id VARCHAR(10) NOT NULL,
	job_title VARCHAR(35) NOT NULL,
	min_salary DECIMAL(8, 0) UNSIGNED,
	max_salary DECIMAL(8, 0) UNSIGNED,
	PRIMARY KEY (job_id)
	);

CREATE TABLE employees (
	employee_id INT (11) UNSIGNED NOT NULL,
	first_name VARCHAR(20),
	last_name VARCHAR(25) NOT NULL,
	email VARCHAR(25) NOT NULL,
	phone_number VARCHAR(20),
	hire_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	salary DECIMAL(8, 2) NOT NULL,
	commission_pct DECIMAL(2, 2),
	manager_id INT (11) UNSIGNED,
	department_id INT (11) UNSIGNED,
	PRIMARY KEY (employee_id)
	);

CREATE TABLE job_history (
	employee_id INT (11) UNSIGNED NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	department_id INT (11) UNSIGNED NOT NULL
	);

ALTER TABLE job_history ADD UNIQUE INDEX (
	employee_id,
	start_date
	);


CREATE VIEW emp_details_view
AS
SELECT e.employee_id,
	e.job_id,
	e.manager_id,
	e.department_id,
	d.location_id,
	l.country_id,
	e.first_name,
	e.last_name,
	e.salary,
	e.commission_pct,
	d.department_name,
	j.job_title,
	l.city,
	l.state_province,
	c.country_name,
	r.region_name
FROM employees e,
	departments d,
	jobs j,
	locations l,
	countries c,
	regions r
WHERE e.department_id = d.department_id
	AND d.location_id = l.location_id
	AND l.country_id = c.country_id
	AND c.region_id = r.region_id
	AND j.job_id = e.job_id;

/* *************************************************************** 
***************************INSERTING DATA*************************
**************************************************************** */



/* *************************************************************** 
***************************FOREIGN KEYS***************************
**************************************************************** */

ALTER TABLE countries ADD FOREIGN KEY (region_id) REFERENCES regions(region_id);    
ALTER TABLE locations ADD FOREIGN KEY (country_id) REFERENCES countries(country_id);
ALTER TABLE departments ADD FOREIGN KEY (location_id) REFERENCES locations(location_id);
ALTER TABLE employees ADD FOREIGN KEY (job_id) REFERENCES jobs(job_id);
ALTER TABLE employees ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
ALTER TABLE employees ADD FOREIGN KEY (manager_id) REFERENCES employees(employee_id);
ALTER TABLE departments ADD FOREIGN KEY (manager_id) REFERENCES employees (employee_id);
ALTER TABLE job_history ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);
ALTER TABLE job_history ADD FOREIGN KEY (job_id) REFERENCES jobs(job_id);
ALTER TABLE job_history ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);


-- page 1

-- 1 Display all information in the tables EMP and DEPT. 
select * from employees;
select * from departments;

-- 2 Display only the hire date and employee name for each employee.   
select hire_date , concat(first_name,' ',last_name) as ename from employees;

-- 3  Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title  
select concat(employee_id,',',first_name,' ',last_name) as employee from employees;

-- 4 Display the hire date, name and department number for all clerks.   
select hire_date , concat(first_name,' ',last_name) as ename , department_id , job_id from employees
where job_id = 'PU_CLERK';

-- 5  Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT 
select employees.*,',' as the_output from employees;

-- 6 Display the names and salaries of all employees with a salary greater than 2000.   
select concat(first_name,' ',last_name) as ename , salary from employees
where salary > 2000;

-- 7  Display the names and dates of employees with the column headers "Name" and "Start Date"   
alter table employees 
 rename column hire_date to start_date;
 
 select  concat(first_name,' ',last_name) as ename from employees;
 
 -- 8  Display the names and hire dates of all employees in the order they were hired.   
 select concat(first_name,' ',last_name) as ename , start_date from employees
 order by start_date;
 
 -- 9  Display the names and salaries of all employees in reverse salary order.  
 select concat(first_name,' ',last_name) as ename , salary from employees
 order by salary;
 
 -- 10  Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.  
 select concat(first_name,' ',last_name) as ename , department_id , salary , commission_pct from employees
where commission_pct = null
 order by salary;
 
 -- 11  Display the last name and job title of all employees who do not have a manager
 select last_name , job_id , manager_id from employees
 where manager_id = null;
 
 
 
 
 
 -- page 2
 
 -- 1 Display the maximum, minimum and average salary and commission earned.    
select MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    AVG(salary) AS avg_salary,
    MAX(commission_pct) AS max_commission,
    MIN(commission_pct) AS min_commission,
    AVG(commission_pct) AS avg_commission from employees;
    
-- 2  Display the department number, total salary payout and total commission payout for each department.     
    SELECT department_id, 
       SUM(salary) AS total_salary_payout, 
       SUM(commission_pct) AS total_commission_payout 
FROM employees 
GROUP BY department_id;

-- 3  Display the department number and number of employees in each department.  
    SELECT department_id, COUNT(employee_id) AS num_employees FROM employees
GROUP BY department_id;

-- 4 Display the department number and total salary of employees in each department.   
SELECT department_id, SUM(salary) AS total_salary FROM employees
GROUP BY department_id;

-- 5  Display the employee's name who doesn't earn a commission. Order the result set without using the column name   
SELECT concat(first_name,' ',last_name) as ename  FROM employees
WHERE commission_pct = 0
ORDER BY 1; 

-- 6  Display the employees name, department id and commission. If an Employee doesn't  earn the commission, then display as 'No commission'. Name the columns appropriately 
select concat(first_name,' ',last_name) as ename , department_id , commission_pct from employees;

-- 7  Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately 

-- 8  Display the employee's name, department id who have the first name same as another employee in the same department 

-- 9  Display the sum of salaries of the employees working under each Manager.   
select sum(salary) , manager_id from employees
group by manager_id;

-- 10  Select the Managers name, the count of employees working under and the department ID of the manager.  

-- 11  Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a!

-- 12  Display the average of sum of the salaries and group the result with the department id. Order the result with the department id. 
SELECT 
    department_id,
    AVG(total_salary) AS average_salary
FROM (
    SELECT department_id,
        SUM(salary) AS total_salary
    FROM employees
    GROUP BY department_id) AS department_salary_sum
GROUP BY department_id
ORDER BY department_id;

-- 13 Select the maximum salary of each department along with the department id   
SELECT department_id,
    MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;

-- 14  Display the commission, if not null display 10% of salary, if null display a default value 1  
SELECT 
    CASE
        WHEN commission_pct IS NOT NULL THEN salary * 0.1
        ELSE 1
    END AS commission_or_default
FROM employees;


-- page 3

-- 1. Write a query that displays the employee's last names only from the string's 2-5th position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label.     

-- 2. Write a query that displays the employee's first name and last name along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.  
SELECT 
    CONCAT(first_name, '-', last_name) AS full_name,
    DATE_FORMAT(start_date, '%M') AS join_month
FROM 
    employees;

-- 3. Write a query to display the employee's last name and if half of the salary is greater than ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 
-- 1500 each. Provide each column an appropriate label.   

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, salary and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$!   

-- 5. Write a query that displays the employee's last names with the first letter capitalized and all other letters lowercase, and the length of the names, for all employees whose name 
-- starts with J, A, or M. Give each column an appropriate label. Sort the results by the employees' last names   

-- 6. Create a query to display the last name and salary for all employees. Format the salary to be 15 characters long, left-padded with $. Label the column SALARY   
SELECT 
    last_name,
    LPAD(CONCAT('$', FORMAT(salary, 2)), 15, '$') AS SALARY
FROM 
    employees;

-- 7. Display the employee's name if it is a palindrome   
SELECT first_name
FROM employees
WHERE 
    LOWER(first_name) = LOWER(REVERSE(first_name));

-- 8. Display First names of all employees with initcaps.   

-- 9. From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.   

-- 10. Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end. Name the column as e-mail address. All characters should 
-- be in lower case. Display this along with their First Name.  

-- 11 . Display the names and job titles of all employees with the same job as Trenna
SELECT first_name , job_id FROM employees 
WHERE job_id = (SELECT job_id FROM employees WHERE first_name = 'Trenna');

-- 12 . Display the names and department name of all employees working in the same city as Trenna.  

-- 13 . Display the name of the employee whose salary is the lowest.  
SELECT concat(first_name,' ',last_name) as ename FROM employees
ORDER BY salary
LIMIT 1;

-- 14 Display the names of all employees except the lowest paid. 
SELECT concat(first_name,' ',last_name) as ename , salary FROM employees
WHERE salary > (SELECT MIN(salary) FROM employees);



-- page 5

-- 1  Write a query to display the last name and hire date of any employee in the same department as SALES.   
SELECT last_name , start_date FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'SALES');

-- 2  Create a query to display the employee numbers and last names of all employees who earn more than the average salary. Sort the results in ascending order of salary.   
SELECT employee_id,last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary ASC;

-- 3. Write a query that displays the employee numbers and last names of all employees who work in a department with any employee whose last name contains a' u   
SELECT employee_id,last_name
FROM employees
WHERE department_id IN (SELECT DISTINCT department_id FROM employees WHERE last_name LIKE '%u%');

-- 4. Display the last name, department number, and job ID of all employees whose department location is ATLANTA.   
SELECT e.last_name,d.department_id,e.job_id
FROM employees e
JOIN departments d 
ON e.department_id = d.department_id
JOIN locations l 
ON d.location_id = l.location_id
WHERE  l.city = 'ATLANTA';

-- 5. Display the last name and salary of every employee who reports to FILLMORE.   
SELECT e.last_name,e.salary
FROM employees e
JOIN employees m
ON e.manager_id = m.employee_id
WHERE m.last_name = 'FILLMORE';

-- 6. Display the department number, last name, and job ID for every employee in the OPERATIONS department.   
SELECT d.department_id,e.last_name,e.job_id
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'OPERATIONS';

-- 7. Modify the above query to display the employee numbers, last names, and salaries of all employees who earn more than the average salary and who work in a department with any employee with a 'u'in their name.   
SELECT e.employee_id,e.last_name,e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (SELECT AVG(salary) FROM employees)
AND     d.department_id IN (
        SELECT DISTINCT department_id
        FROM employees
        WHERE last_name LIKE '%u%');

-- 8  Display the names of all employees whose job title is the same as anyone in the sales dept.  
SELECT concat(first_name,' ',last_name) as ename FROM employees
WHERE job_id IN (SELECT DISTINCT job_id FROM employees WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Sales'));

-- 9  Write a compound query to produce a list of employees showing raise percentages, employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, 
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are given a 15% raise, and employees in department 6 are not given a raise.  

-- 10  Write a query to display the top three earners in the EMPLOYEES table. Display their last names and salaries.  
SELECT last_name , salary FROM employees
ORDER BY salary DESC
LIMIT 3;

-- 11. Display the names of all employees with their salary and commission earned. Employees with a null commission should have O in the commission column   

-- 12. Display the Managers (name) with top three salaries along with their salaries and department information.







