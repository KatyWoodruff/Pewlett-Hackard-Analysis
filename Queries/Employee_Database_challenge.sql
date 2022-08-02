-- Create new list for retiring employees with titles
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY e.emp_no;

-- Create new list for retiring employees with most recent titles
SELECT DISTINCT ON (emp_no) rt.title, 
		rt.emp_no, 
		rt.first_name, 
		rt.last_name, 
		rt.to_date
	INTO unique_titles
	FROM retirement_titles as rt
	Where rt.to_date = '9999-01-01'
	ORDER BY emp_no ASC, to_date DESC;

-- Create list for number of retiring employees by title
SELECT COUNT (title), title
	INTO retiring_titles
	FROM unique_titles
	GROUP BY title
	ORDER BY count DESC

	-- Create new list for employees eligible for mentorship program
SELECT DISTINCT ON (emp_no) e.emp_no, 
		e.first_name, 
		e.last_name, 
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
	INTO mentorship_eligibilty
	FROM employees as e
		INNER JOIN dept_emp AS de
			ON (e.emp_no = de.emp_no)
		INNER JOIN titles AS t
			ON (de.emp_no = t.emp_no)
	WHERE de.to_date = '9999-01-01'
		AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	ORDER BY emp_no ASC;