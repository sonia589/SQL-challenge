drop table if exists employees
drop table if exists departments
drop table if exists dept_manager
drop table if exists dept_emp
drop table if exists salaries
drop table if exists titles

--create employees table 
CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	emp_title_id TEXT,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE
);

-- Create departments table
CREATE TABLE departments(
	dept_no TEXT PRIMARY KEY,
	dept_name VARCHAR	
);

-- Create dept employees table with foreign key references to departments and employees tables
CREATE TABLE dept_emp(
	emp_no INT REFERENCES employees (emp_no),
	dept_no TEXT REFERENCES departments (dept_no)
);

-- Create dept manager table with foreign key references to departments and employees tables
CREATE TABLE dept_manager(
	dept_no TEXT REFERENCES departments (dept_no),
	emp_no INT REFERENCES employees (emp_no)
);

-- create salaries table with foreign key reference to employee no
CREATE TABLE salaries(
	emp_no INT REFERENCES employees (emp_no),
	salaries INT
);

--create titles table
CREATE TABLE titles(
	title_id TEXT PRIMARY KEY,
	title VARCHAR
);

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
select employees.emp_no,
		employees.last_name,
		employees.first_name,
		employees.sex,
		salaries.salaries
		from employees
join salaries 
	on (employees.emp_no=salaries.emp_no);
	
--List first name, last name, and hire date for employees who were hired in 1986.
select employees.first_name,
		employees.last_name,
		employees.hire_date
		from employees
		where date_part('year',hire_date)=1986;
		
--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select departments.dept_no,
		departments.dept_name,
		dept_manager.dept_no,
		dept_manager.emp_no,
		employees.emp_no,
		employees.last_name,
		employees.first_name
		from dept_manager
join departments 
	on (dept_manager.dept_no=departments.dept_no) 
join employees
	on(dept_manager.emp_no=employees.emp_no);
	
--List the department of each employee with the following information: employee number, last name, first name, and department name.
select employees.emp_no,
		employees.last_name,
		employees.first_name,
		departments.dept_name
		from employees
join dept_emp
	on (employees.emp_no=dept_emp.emp_no)
join departments
	on (departments.dept_no=dept_emp.dept_no);

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select employees.last_name,
		employees.first_name,
		employees.sex
		from employees
		where first_name='Hercules' AND last_name like 'B%';
		
--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select employees.emp_no,
		employees.last_name,
		employees.first_name,
		departments.dept_name
		from employees
	join dept_emp
	on (employees.emp_no=dept_emp.emp_no)
join departments
	on (departments.dept_no=dept_emp.dept_no)
where departments.dept_name='Sales';
		
--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
select employees.emp_no,
		employees.last_name,
		employees.first_name,
		departments.dept_name
		from employees
join dept_emp
	on (employees.emp_no=dept_emp.emp_no)
join departments
	on (departments.dept_no=dept_emp.dept_no)
where departments.dept_name in ('Sales','Development');

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(*) as frequency
	from employees
	group by last_name
	order by count(*) DESC;