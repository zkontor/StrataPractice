--Write a query to find how many UHG policy holders made three, or more calls, assuming each call is identified by the case_id column.
SELECT DISTINCT
       COUNT(c.policy_holder_id) OVER() AS memberCount
  FROM callers c
 GROUP BY c.policy_holder_id
HAVING COUNT(DISTINCT c.case_id) >=3;