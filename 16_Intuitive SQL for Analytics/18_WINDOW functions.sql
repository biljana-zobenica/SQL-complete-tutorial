
--> WINDOW functions example:

SELECT
    name,
    item_type,
    AVG(`power`) OVER (PARTITION BY item_type) AS avg_power_by_type
FROM `fantasy.items`;