use Task;

show tables;

select * from menu_items;

select count(*) as number_of_items
from menu_items;

-- Least expensive items
select item_name, category, price
from menu_items
where price = (select min(price) from menu_items);

-- Most expensive items
SELECT item_name, category, price
FROM menu_items
WHERE price = (SELECT MAX(price) FROM menu_items);

SELECT COUNT(*) AS number_of_italian_dishes
FROM menu_items
WHERE category = 'Italian';

SELECT item_name, category
FROM menu_items
WHERE category = 'Italian';

-- Least expensive Italian dish
SELECT item_name, category, price
FROM menu_items
WHERE category = 'Italian' 
  AND price = (SELECT MIN(price) FROM menu_items WHERE category = 'Italian');

-- Most expensive Italian dish
SELECT item_name, category, price
FROM menu_items
WHERE category = 'Italian' 
  AND price = (SELECT MAX(price) FROM menu_items WHERE category = 'Italian');


SELECT category, COUNT(*) AS number_of_dishes
FROM menu_items
GROUP BY category;


SELECT category, AVG(price) AS average_price
FROM menu_items
GROUP BY category

select * from order_details;

SELECT 
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date
FROM order_details;


SELECT COUNT(DISTINCT order_id) AS number_of_orders
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31';

SELECT COUNT(item_id) AS number_of_items_ordered
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31'
  AND item_id IS NOT NULL;


SELECT 
    COUNT(order_details_id) AS total_order_detail_rows,
    COUNT(item_id) AS items_ordered_count,
    COUNT(order_details_id) - COUNT(item_id) AS rows_without_items
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31';


SELECT 
    order_id,
    COUNT(item_id) AS number_of_items
FROM order_details
WHERE item_id IS NOT NULL
GROUP BY order_id
ORDER BY number_of_items DESC
LIMIT 1;


SELECT 
    order_id,
    COUNT(item_id) AS number_of_items
FROM order_details
WHERE item_id IS NOT NULL
GROUP BY order_id
ORDER BY number_of_items DESC;


SELECT COUNT(*) AS orders_with_more_than_12_items
FROM (
    SELECT 
        order_id,
        COUNT(item_id) AS number_of_items
    FROM order_details
    WHERE item_id IS NOT NULL
    GROUP BY order_id
    HAVING COUNT(item_id) > 12
) AS orders_with_high_item_count;


SELECT 
    number_of_items,
    COUNT(*) AS number_of_orders
FROM (
    SELECT 
        order_id,
        COUNT(item_id) AS number_of_items
    FROM order_details
    WHERE item_id IS NOT NULL
    GROUP BY order_id
) AS order_item_counts
GROUP BY number_of_items
ORDER BY number_of_items DESC;

SELECT COUNT(*) AS orders_with_more_than_12_items
FROM (
    SELECT 
        order_id,
        COUNT(item_id) AS number_of_items
    FROM order_details
    WHERE item_id IS NOT NULL
    GROUP BY order_id
    HAVING COUNT(item_id) > 12
) AS orders_with_high_item_count;


SELECT 
    od.order_details_id,
    od.order_id,
    od.order_date,
    od.order_time,
    od.item_id,
    mi.item_name,
    mi.category,
    mi.price
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id;



(
    SELECT 
        'Most Ordered' AS order_type,
        mi.item_name,
        mi.category,
        COUNT(od.item_id) AS times_ordered
    FROM order_details od
    LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
    WHERE od.item_id IS NOT NULL
    GROUP BY mi.item_name, mi.category
    ORDER BY times_ordered DESC
    LIMIT 1
)
UNION ALL
(
    SELECT 
        'Least Ordered' AS order_type,
        mi.item_name,
        mi.category,
        COUNT(od.item_id) AS times_ordered
    FROM order_details od
    LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id
    WHERE od.item_id IS NOT NULL
    GROUP BY mi.item_name, mi.category
    ORDER BY times_ordered ASC
    LIMIT 1
);



SELECT 
    mi.item_name,
    mi.category,
    COUNT(od.item_id) AS times_ordered
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE od.item_id IS NOT NULL
GROUP BY mi.item_name, mi.category
ORDER BY times_ordered DESC;



SELECT 
    od.order_id,
    COUNT(od.item_id) AS number_of_items,
    SUM(mi.price) AS total_spent
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE od.item_id IS NOT NULL
GROUP BY od.order_id
ORDER BY total_spent DESC
LIMIT 5;

SELECT 
    od.order_id,
    mi.item_name,
    mi.category,
    mi.price
FROM order_details od
LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE od.order_id = (
    SELECT od2.order_id
    FROM order_details od2
    LEFT JOIN menu_items mi2 ON od2.item_id = mi2.menu_item_id
    WHERE od2.item_id IS NOT NULL
    GROUP BY od2.order_id
    ORDER BY SUM(mi2.price) DESC
    LIMIT 1
)
AND od.item_id IS NOT NULL;



SELECT 
    mi.item_name,
    mi.category,
    mi.price
FROM menu_items mi
ORDER BY mi.price DESC
LIMIT 1;

SELECT 
    od.order_id,
    mi.item_name,
    mi.category,
    mi.price
FROM order_details od
JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
ORDER BY mi.price DESC
LIMIT 1;


SELECT 
    od.order_id,
    mi.item_name,
    mi.category,
    mi.price
FROM order_details od
JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
ORDER BY mi.price DESC
LIMIT 5;

SELECT 
    COUNT(*) AS total_orders
FROM (
    SELECT 
        order_id
    FROM order_details
    GROUP BY order_id
    HAVING COUNT(item_id) > 12
) AS orders_more_than_12;