--asked to find the 5 most lucrative products (including ties) in terms of total revenue for the first half of 2022 (from January to June inclusive).


-- Output their IDs and the total revenue. There may be more than 5 rows in the output since you are including ties.

WITH rev AS 
    (Select product_id,
            SUM(cost_in_dollars *units_sold) as revenue,
            RANK() OVER(
            ORDER BY SUM(cost_in_dollars*units_sold) DESC) as ranked
    FROM online_orders
    WHERE MONTH(date_sold) BETWEEN 1 AND 6
    GROUP BY product_id)
Select product_id, revenue
FROM rev
where ranked <= 5;

-- Sample output
-- product_id	revenue
--2	207
--3	201
--5	199
--1	65
--6	56