SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

SELECT DISTINCT utm_campaign,utm_source
FROM page_visits;

SELECT utm_campaign AS campaigns, utm_source AS sources, COUNT (*) AS visit times
FROM page_visits
GROUP BY 1, 2
ORDER BY 3;

SELECT DISTINCT page_name
FROM page_visits;


WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign as 'campaign', pv.utm_source as 'source', COUNT(*) AS 'first touch number'
FROM page_visits pv
JOIN first_touch ft
		ON pv.user_id = ft.user_id
    AND pv.timestamp = ft.first_touch_at
GROUP BY 1, 2
ORDER BY 3 DESC;



WITH last_touch AS(
	SELECT user_id, MAX(timestamp) as last_touch_at
	FROM page_visits
  GROUP BY user_id)
SELECT pv.utm_campaign as campaign, pv.utm_source as source, COUNT(*) AS 'last touch number'
FROM page_visits pv
JOIN last_touch lt
		ON pv.user_id = lt.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT COUNT(DISTINCT user_id) AS 'visitors who make a purchase'
FROM page_visits
WHERE page_name LIKE '%purchase';

WITH last_touch AS(
	SELECT user_id, MAX(timestamp) as last_touch_at
	FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY user_id)
SELECT pv.utm_campaign as campaign, pv.utm_source AS source, COUNT(*) AS 'last touch number on purchase page'
FROM page_visits pv
JOIN last_touch lt
		ON pv.user_id = lt.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 1
ORDER BY 2 DESC;
