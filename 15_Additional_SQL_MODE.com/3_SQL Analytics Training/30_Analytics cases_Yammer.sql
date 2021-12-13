/* Analytics case: Yammer

Yammer is a social network for communicating with coworkers. Individuals share
documents, updates, and ideas by posting them in groups. Yammer is free to use
indefinitely, but companies must pay license fees if they want access to
administrative controls, including integration with user management systems 
like ActiveDirectory.

Yammer analysts are trained to constantly consider the value of each individual 
project; they seek to maximize the return on their time. Analysts typically opt 
for less precise solutions to problems if it means investing substantially less 
time as well. */

-- THE CASE 1

-- Investigating a drop in user engagement

-- 1. checking fluctuations, growths and drops

SELECT EXTRACT(DAY FROM created_at) AS day,
       COUNT(*) AS all_users,
       COUNT(CASE WHEN 	activated_at IS NOT NULL THEN 
						u.user_id ELSE NULL END) 
                        AS activated_users
FROM tutorial.yammer_users u
WHERE 	created_at >= '2014-06-01'
	AND created_at < '2014-09-01'
GROUP BY 1
ORDER BY 1;

-- 2.

SELECT EXTRACT(WEEK FROM z.occurred_at) AS "week",
       AVG(z.age_at_event) AS "Average age during week",
       COUNT(DISTINCT CASE WHEN z.user_age > 70 THEN z.user_id ELSE NULL END) AS "10+ weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 70 AND z.user_age >= 63 THEN z.user_id ELSE NULL END) AS "9 weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 63 AND z.user_age >= 56 THEN z.user_id ELSE NULL END) AS "8 weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 56 AND z.user_age >= 49 THEN z.user_id ELSE NULL END) AS "7 weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 49 AND z.user_age >= 42 THEN z.user_id ELSE NULL END) AS "6 weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 42 AND z.user_age >= 35 THEN z.user_id ELSE NULL END) AS "5 weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 35 AND z.user_age >= 28 THEN z.user_id ELSE NULL END) AS "4 weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 28 AND z.user_age >= 21 THEN z.user_id ELSE NULL END) AS "3 weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 21 AND z.user_age >= 14 THEN z.user_id ELSE NULL END) AS "2 weeks",
       COUNT(DISTINCT CASE WHEN z.user_age < 14 AND z.user_age >= 7 THEN z.user_id ELSE NULL END) AS "1 week",
       COUNT(DISTINCT CASE WHEN z.user_age < 7 THEN z.user_id ELSE NULL END) AS "Less than a week"
  FROM (
        SELECT e.occurred_at,
               u.user_id,
               EXTRACT(WEEK FROM u.activated_at) AS activation_week,
               EXTRACT(DAY FROM e.occurred_at - u.activated_at) AS age_at_event,
               EXTRACT(DAY FROM CAST('2014-09-01' AS DATETIME) - u.activated_at) AS user_age
          FROM tutorial.yammer_users u
          JOIN tutorial.yammer_events e
            ON e.user_id = u.user_id
           AND e.event_type = 'engagement'
           AND e.event_name = 'login'
           AND e.occurred_at >= '2014-05-01'
           AND e.occurred_at < '2014-09-01'
         WHERE u.activated_at IS NOT NULL
       ) z
GROUP BY 1
ORDER BY 1
LIMIT 100;

/* This is where we see the engagement of users per time, so new vs. old ones.
The conclusion is that there is a decrease in engagement among users who signed 
up more than 10 weeks before. */

-- 3. device-wise activity per user

SELECT EXTRACT(WEEK FROM occurred_at) AS week,
       COUNT(DISTINCT e.user_id) AS weekly_active_users,
       COUNT(DISTINCT CASE WHEN e.device IN 
					('macbook pro','lenovo thinkpad',
                    'macbook air','dell inspiron notebook',
					'asus chromebook','dell inspiron desktop',
                    'acer aspire notebook','hp pavilion desktop',
                    'acer aspire desktop','mac mini')
			THEN e.user_id ELSE NULL END) AS computer,
       COUNT(DISTINCT CASE WHEN e.device IN 
					('iphone 5','samsung galaxy s4',
                    'nexus 5','iphone 5s','iphone 4s',
                    'nokia lumia 635', 'htc one', 
                    'samsung galaxy note','amazon fire phone') 
			THEN e.user_id ELSE NULL END) AS phone,
        COUNT(DISTINCT CASE WHEN e.device IN 
					('ipad air','nexus 7','ipad mini',
                    'nexus 10','kindle fire',
                    'windows surface', 'samsumg galaxy tablet') 
			THEN e.user_id ELSE NULL END) AS tablet
FROM tutorial.yammer_events e
WHERE e.event_type = 'engagement'
   AND e.event_name = 'login'
GROUP BY 1
ORDER BY 1
LIMIT 100;

/* Getting a sense of users' activities per different devices.
So, by filtering the phone engagement rates, we can spot a steep
drop for those users. */

-- 4. exploring the actions of emails

SELECT EXTRACT(WEEK FROM occurred_at) AS week,
       COUNT	(CASE WHEN e.action = 'sent_weekly_digest' 
				THEN e.user_id ELSE NULL END) AS weekly_emails,
       COUNT	(CASE WHEN e.action = 'sent_reengagement_email' 
				THEN e.user_id ELSE NULL END) AS reengagement_emails,
       COUNT	(CASE WHEN e.action = 'email_open' 
				THEN e.user_id ELSE NULL END) AS email_opens,
       COUNT	(CASE WHEN e.action = 'email_clickthrough' 
				THEN e.user_id ELSE NULL END) AS email_clickthroughs
FROM tutorial.yammer_emails e
GROUP BY 1
ORDER BY 1;

/* So, definitly the problem is clickthroughs. The problem is localized, 
and other teams will know where to look for more deeper cause of these
changes in users' behaviour. */