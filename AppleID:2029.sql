
-- Select the most popular client_id based on the number of users who individually have at least 50% of their events from the following list: 
-- 'video call received', 'video call sent', 'voice call received', 'voice call sent'.

WITH cte AS
  (SELECT user_id,
          100 * (sum(if(event_type IN ('video call received', 
          'video call sent', 
          'voice call received', 
          'voice call sent'), 1, 0))/count(*)) AS percentage
   FROM fact_events
   GROUP BY user_id 
   HAVING percentage >= 50),
     cte2 AS
  (SELECT client_id,
          count(*) AS cnt
   FROM fact_events
   WHERE user_id IN
       (SELECT DISTINCT user_id
        FROM cte)
   GROUP BY user_id )
SELECT client_id
FROM cte2
WHERE cnt =
    (SELECT max(cnt)
     FROM cte2)