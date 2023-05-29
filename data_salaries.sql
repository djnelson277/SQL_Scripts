-- Datset : https://www.kaggle.com/datasets/arnabchaki/data-science-salaries-2023?select=ds_salaries.csv
SELECT 
    *
FROM
    salary_schema.ds_salaries
    
1) Who are the highest paid job_titles in in Northern America
SELECT 
    job_title,
    MAX(salary) AS max_salary,
    experience_level,
    employee_residence,
    company_location
FROM
    salary_schema.ds_salaries
WHERE
    employee_residence IN ('US' , 'CA')
Group by
job_title, experience_level,employee_residence, company_location
ORDER BY max_salary DESC

2) How many jobs are there per company location?
SELECT 
    company_location, COUNT(company_location) AS Total_Companies
FROM
    salary_schema.ds_salaries
GROUP BY company_location
ORDER BY Total_Companies DESC

3)Whats the average salary per company location?
SELECT 
    company_location,
    ROUND(AVG(salary_in_usd), 0) AS Average_Salary
FROM
    salary_schema.ds_salaries
GROUP BY company_location
ORDER BY Average_Salary DESC

4) List each job title with the number of jobs given their experience level.
with t1 as 
 (select job_title, count(experience_level) as Entry_Level
 from salary_schema.ds_salaries
 where experience_level = "EN"
 group by job_title),
 t2 as 
 (select job_title, count(experience_level) as Mid_Level
 from salary_schema.ds_salaries
 where experience_level = "MI"
 group by job_title),
 t3 as 
 (select job_title, count(experience_level) as Senior_Level
 from salary_schema.ds_salaries
 where experience_level = "SE"
 group by job_title)
 select t1.job_title,t1.Entry_Level, t2.Mid_Level, t3.Senior_Level
 from t1
 left join t2 on t1.job_title = t2.job_title
 left join t3 on t1.job_title = t3.job_title
order by Senior_Level DESC
 