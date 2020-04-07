CREATE TABLE "Employees" (
    "emp_no" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Title" (
    "emp_no" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "Department_Employee" (
    "emp_no" VARCHAR   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" VARCHAR   NOT NULL,
    "salary" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

CREATE TABLE "Department_Manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL
);

ALTER TABLE "Title" ADD CONSTRAINT "fk_Title_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_Employee" ADD CONSTRAINT "fk_Department_Employee_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_Employee" ADD CONSTRAINT "fk_Department_Employee_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- Question 1:
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no

-- Question 2: List employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
where hire_date between '1986-01-01' and '1987-01-01';

-- Question 3: List the manager of each department with the following information: 
-- department number, department name, the manager's employee number,
-- last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM departments d
INNER JOIN dept_manager m
ON d.dept_no = m.dept_no
INNER JOIN employees e
ON e.emp_no = m.emp_no;

-- Question 4: List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no;

-- Question 5: List all employees whose first name is "Hercules" and last names begin with "B."
SELECT*
FROM employees
where first_name='Hercules'
and last_name like 'B%';

-- Question 6: List all employees in the Sales department, 
-- including their employee number, last name, first name, 
-- and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

-- Question 7: List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name,
-- and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- Question 8: In descending order, list the frequency count of employee last names,
-- i.e., how many employees share each last name.
SELECT last_name, count(emp_no) as "Occurences"
FROM employees
GROUP BY last_name
ORDER BY 2 DESC;
