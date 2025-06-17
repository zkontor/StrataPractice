--Assume you are given the table below on Uber transactions made by users. Write a query to obtain the third transaction of every user. 
-- Output the user id, spend and transaction date.
WITH transNumber AS(
  SELECT
  user_id,
  spend,
  transaction_date,
  ROW_NUMBER() OVER(
    PARTITION BY user_id ORDER BY transaction_date) as rowNum
FROM transactions)

SELECT user_id,spend,transaction_date
from transNumber
where rowNum = 3;