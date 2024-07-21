-- date related pq


-- Question:
-- Write a query to find the average salary both yearly (salary_year_avg) and hourly (salary_hour_avg) for job postings that were posted after June 1, 2023. Group the results by job schedule type.


-- select 
-- job_schedule_type,
-- avg(salary_year_avg) as avg_salary,
-- avg(salary_hour_avg)
-- FROM
-- job_postings_fact
-- where 
-- EXTRACT(DAY FROM job_posted_date) > 1 and 
-- EXTRACT(MONTH FROM job_posted_date) >= 6 and 
-- EXTRACT(YEAR FROM job_posted_date) >= 2023
-- GROUP BY job_schedule_type


-- Question:
-- Write a query to count the number of job postings for each month in 2023, adjusting the job posted date to be in the 'America/New_York' time zone before extracting the month. Assume the job_posted_date is stored in UTC. Group by and order by the month.

-- SELECT
-- extract(month from job_posted_date::date  at time zone 'UTC' at time zone 'EDT') as posted_month,
-- count(job_id) as posting_numbers
-- from
-- job_postings_fact
-- WHERE
-- extract(YEAR from job_posted_date) = 2023
-- GROUP BY 
-- posted_month
-- order BY
-- posted_month


-- Question:
-- Write a query to find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter.

-- SELECT
-- company_dim.name
-- FROM
-- job_postings_fact
-- LEFT JOIN 
-- company_dim ON
-- company_dim.company_id = job_postings_fact.company_id
-- where
-- job_health_insurance = TRUE AND
-- extract(quarter from job_posted_date) = 2
-- GROUP BY name

