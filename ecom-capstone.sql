SET GLOBAL max_allowed_packet = 1073741824;
USE mavenfuzzyfactory;
#Assignment 1
SELECT * FROM website_sessions;
SELECT  utm_source,utm_campaign,http_referer,COUNT(website_session_id) as sessions
FROM website_sessions
WHERE created_at < '2012-04-12'
GROUP BY 1,2,3
ORDER BY sessions  DESC;
#Assignment 2
SELECT  COUNT(DISTINCT w.website_session_id)AS sessions,
COUNT(DISTINCT o.order_id) AS order_number,COUNT(DISTINCT o.order_id)/COUNT(DISTINCT w.website_session_id) AS CVR
FROM website_sessions AS w
LEFT JOIN orders AS o
ON  o.website_session_id = w.website_session_id 
WHERE w.created_at < '2012-04-14'
AND utm_source = 'gsearch'
AND utm_campaign = 'nonbrand';
#Assignment 3
SELECT WEEK(created_at) AS weekly,created_at AS dates,COUNT(DISTINCT website_session_id)AS sessions
FROM website_sessions
WHERE created_at < '2012-05-10'
AND utm_source ='gsearch'
AND utm_campaign ='nonbrand'
GROUP  BY 1
ORDER BY created_at ASC;
#Assignment 4
SELECT w.device_type ,COUNT(DISTINCT w.website_session_id) AS sessions,COUNT(DISTINCT o.order_id) AS order_number
,COUNT(DISTINCT(o.order_id))/COUNT(DISTINCT( w.website_session_id)) AS CVR
FROM website_sessions AS w
LEFT JOIN orders AS o
ON o.website_session_id = w.website_session_id
WHERE w.created_at < '2012-05-11'
AND w.utm_source ='gsearch'
AND w.utm_campaign ='nonbrand'
GROUP BY 1;
#Assignment 5
SELECT WEEK(w.created_at) AS weekly,
MIN(DATE(w.created_at)) AS start_date,
COUNT(DISTINCT CASE WHEN w.device_type ='desktop' THEN w.website_session_id ELSE NULL END) AS desktop_session,
COUNT(DISTINCT CASE WHEN w.device_type ='mobile' then w.website_session_id ELSE NULL END) AS mobile_session,COUNT(DISTINCT CASE WHEN w.device_type='desktop' THEN  o.order_id END) AS device_order,COUNT(DISTINCT CASE WHEN w.device_type='mobile' THEN  o.order_id END) AS Mobile_order,
COUNT(DISTINCT CASE WHEN w.device_type='desktop' THEN  o.order_id END)/COUNT(DISTINCT CASE WHEN w.device_type ='desktop' THEN w.website_session_id ELSE NULL END) AS desktop_CVR,
COUNT(DISTINCT CASE WHEN w.device_type='mobile' THEN  o.order_id END)/COUNT(DISTINCT CASE WHEN w.device_type ='mobile' then w.website_session_id ELSE NULL END) AS Mobile_CVR
FROM website_sessions AS w
LEFT JOIN orders AS o 
ON o.website_session_id = w.website_session_id
WHERE w.created_at < '2012-06-9' 
AND  w.created_at >= '2012-04-15'
AND w.utm_source ='gsearch'
AND w.utm_campaign ='nonbrand'
group by 1;



 
