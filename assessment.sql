create database try;
use try;
create table employees
(
employee_id int auto_increment primary key, 
name varchar(100),
position varchar(100),
salary decimal (10,2),
hire_date date
);

create table employee_audit
(
audit_id int auto_increment primary key,
employee_id int,
name varchar(100),
position varchar(100),
salary decimal(10,2),
hire_date date,
action_date timestamp default current_timestamp
);

insert into employees (name,position,salary,hire_date) values ('john Doe',
'software engineer',80000.00,'2022-01-15'),
('Jane smith','project manager',90000.00,'2021-05-22'),
('Alice Johnson','UX Designer',75000.00,'2023-03-01');

DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, name, position, salary, hire_date)
    VALUES (NEW.employee_id, NEW.name, NEW.position, NEW.salary, NEW.hire_date);
END//

DELIMITER ;
insert into employees (name,position,salary,hire_date) values ('chintan chauhan',
'data analytics',90000.00,'2022-01-15');

DELIMITER //

CREATE PROCEDURE AddNewEmployee (
    IN emp_name VARCHAR(100),
    IN emp_position VARCHAR(100),
    IN emp_salary DECIMAL(10, 2),
    IN emp_hire_date DATE
)
BEGIN
    INSERT INTO employees (name, position, salary, hire_date)
    VALUES (emp_name, emp_position, emp_salary, emp_hire_date);
END//

DELIMITER ;

call try.AddNewEmployee('chintan chauhan', 'data analytics', 90000.00, '2022-01-15');

