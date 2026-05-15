select
	employee_id,
	trim(first_name) as cleaned_first_name,
	trim(last_name) as cleaned_last_name
from
	employees;

select
	first_name,
	last_name,
	upper(city) as uppercase_city
from
	employees;

select
	first_name,
	last_name,
	lower(status) as lowercase_status
from
	employees;



UPDATE employees
SET job_title = 'Software Developer'
WHERE LOWER(job_title) = 'software engineer';

ALTER TABLE salaries
RENAME COLUMN basic_salary TO base_salary;

SELECT * FROM salaries;


alter table employees
add column full_name varchar(150);

update
	employees
set
	full_name = concat(first_name,' ',last_name);


alter table departments drop column established_year;

select
	employee_id,
	basic_salary,
	rank() over (
	order by basic_salary desc) as salary_rank
from
	salaries;


select
	*
from
	employees
where
	email is null
	or email = '';


select
	employee_id,
	count(*)
from
	employees
group by
	employee_id
having
	count(*) > 1;

SELECT *
FROM employees
WHERE employee_id IN (
    SELECT employee_id
    FROM employees
    GROUP BY employee_id
    HAVING COUNT(*) > 1
)
ORDER BY employee_id;


select
	employee_id,
	first_name,
	last_name,
	city
from
	employees
where
	first_name like 'S%';

select
	employee_id,
	first_name,
	last_name,
	city
from
	employees
where
	city like 'D%';