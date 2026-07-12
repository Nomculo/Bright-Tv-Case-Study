-- Databricks notebook source
------Running the full tables

select *
from bright_tv_dataset.bright_tv.user_profiles_dataset;

-----

select *
from bright_tv_dataset.bright_tv.viewership_dataset;

---both tables contain information ready for cleaning and assesing.

------------------------------------------------------------------------------
------Checking for duplicates in my data
------------------------------------------------------------------------------

select userID,
   COUNT (*) as duplicate_count 
from bright_tv_dataset.bright_tv.user_profiles_dataset
group by userID
Having COUNT(*)>1;
---there are no duplicates in my UserID column.

------------------------------------------------------------------------------
-------Checking the size of data
------------------------------------------------------------------------------
select
   count (*) as number_of_rows,
   count (distinct userID) as number_subs
From bright_tv_dataset.bright_tv.user_profiles_dataset;
--the total row count equals the number of distinct UserID,
--indicating there are no duplicate UserID, next verifying whether any UserID are NULL.

------------------------------------------------------------------------------
----Checking to comfirm there are no NULLs 
------------------------------------------------------------------------------

select count(*)
from bright_tv_dataset.bright_tv.user_profiles_dataset
where UserID is NULL;

 --there are no NULLs in UserID column
------

select Distinct UserID
from bright_tv_dataset.bright_tv.user_profiles_dataset;

------------------------------------------------------------------------------
----GENDER CHECKS
------------------------------------------------------------------------------

select distinct gender
from bright_tv_dataset.bright_tv.user_profiles_dataset;

-----

SELECT COUNT(*) 
FROM bright_tv_dataset.bright_tv.user_profiles_dataset
WHERE gender=' ';

-----

SELECT
    CASE
        WHEN TRIM(gender) = '' THEN 'None'
        ELSE TRIM(gender)
    END AS Gender,
    COUNT(DISTINCT UserID) AS subs
FROM bright_tv_dataset.bright_tv.user_profiles_dataset
GROUP BY
    CASE
        WHEN TRIM(gender) = '' THEN 'None'
        ELSE TRIM(gender)
    END;
 ---This query mergers the 2 'none' into 1 row to make up a total of 3 genders  
------------------------------------------------------------------------------
-----RACE CHECKS
------------------------------------------------------------------------------

SELECT 
   COUNT(DISTINCT userID) as num_rows
   from bright_tv_dataset.bright_tv.user_profiles_dataset
   where race IS NULL;

--- there are no Null values in race
-----

select distinct Race
from bright_tv_dataset.bright_tv.user_profiles_dataset;

-----

select distinct
 Case 
  when Race = 'other' THEN 'None'
  when Race = ' ' then 'None'
  else Race
End As Race
from bright_tv_dataset.bright_tv.user_profiles_dataset;

---There are 5 races inclunding 'none'

--------------------------------------------------------------------------
-----PROVINCE CHECKS
-------------------------------------------------------------------------

Select distinct  Province
from bright_tv_dataset.bright_tv.user_profiles_dataset;

-----

select distinct
 case 
  when Province = ' ' then 'Uncategorized'
  when Province = 'None' then 'Uncategorized'
  else Province
  End AS Region
From bright_tv_dataset.bright_tv.user_profiles_dataset;

---There are 10 regions including 'uncategorized'

----------------------------------------------------------------
-----AGE Checks
----------------------------------------------------------------

Select MIN(Age) as min_age, --- = 0
       MAX(Age) as max_age -- = 114
From bright_tv_dataset.bright_tv.user_profiles_dataset;

-----

select count(*) as cnt
from bright_tv_dataset.bright_tv.user_profiles_dataset
where age is null;

-----


select userID,
   Case
    when age = 0 then 'Infants'
    when age between 1 And 12 then 'Kids'
    when age between 13 and 19  then 'Teenager'
    when age between 20 and 35 then 'Youth'
    when age between 36 and 50 then 'adult'
    when age between 51 and 65 then 'elder'
    when age >65 then 'Pensioner'
    end as age_groups
from bright_tv_dataset.bright_tv.user_profiles_dataset;                                                                                                                                                                                                                                                                                                                                                                                                                                                    

-- COMMAND ----------


