/*Assume you're given a table containing job postings from various companies on the LinkedIn platform. Write a query to retrieve the count of companies that have posted duplicate job listings.

Definition:

Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
job_listings Table:
Column Name	Type
job_id	integer
company_id	integer
title	string
description	string
job_listings Example Input:
job_id	company_id	title	description
248	827	Business Analyst	Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.
149	845	Business Analyst	Business analyst evaluates past and current business data with the primary goal of improving decision-making processes within organizations.
945	345	Data Analyst	Data analyst reviews data to identify key insights into a business's customers and ways the data can be used to solve problems.
164	345	Data Analyst	Data analyst reviews data to identify key insights into a business's customers and ways the data can be used to solve problems.
172	244	Data Engineer	Data engineer works in a variety of settings to build systems that collect, manage, and convert raw data into usable information for data scientists and business analysts to interpret.
Example Output:
duplicate_companies
1*/
Solution
WITH duplicate AS(
        SELECT company_id,title,COUNT(*) AS total
        FROM job_listings
        GROUP BY company_id,title
        HAVING count(*)>1)
SELECT COUNT(*) AS duplicate_companies
FROM duplicate;
