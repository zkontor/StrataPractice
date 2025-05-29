-- Context:You have a dataset that records daily active users for each premium account. 
-- A premium account appears in the data every day as long as it remains premium. However, some premium accounts may be temporarily discounted, meaning they are not actively paying—this is indicated by a final_price of 0.


-- For each of the first 7 available dates, count the number of premium accounts that were actively paying on that day. Then, track how many of those same accounts remain premium and are still paying exactly 7 days later (regardless of activity in between).


-- Output for the three columns should be:
-- The date of entry.
-- The number of premium accounts that were actively paying on that day.
-- The number of those accounts that remain premium and are still paying after 7 days.

-- QUERY: If your SQL does not support date subtraction, use DATEDIFF 

WITH premium_accounts as (
    SELECT entry_date, account_id, final_price
    FROM premium_accounts_by_day
    WHERE final_price > 0)
SELECT a.entry_date,
    COUNT(DISTINCT a.account_id) AS premiumPaid_accounts
    COUNT(DISTINCT b.account_id) AS premiumPaid_accountsAfter7d
FROM premium_accounts a
LEFT JOIN premium_accounts b ON a.account_id = b.account_id 
    AND (b.entry_date - a.entry_date) = 7
GROUP BY a.entry_date
ORDER BY a.entry_date;


