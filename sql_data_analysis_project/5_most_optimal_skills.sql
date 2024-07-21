/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Identifies skills in high demand for Data Analyst roles

with demand_skills as(
    SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(job_postings_fact.job_id) as demand_count
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim
ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON 
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id

),
high_paying_skills as(
    SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0) as avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim
ON 
    job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON 
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY
    skills_job_dim.skill_id

)

SELECT
    demand_skills.skills,
    demand_skills.demand_count,
    high_paying_skills.avg_salary
FROM
    demand_skills
INNER JOIN
    high_paying_skills
ON demand_skills.skill_id = high_paying_skills.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 10

