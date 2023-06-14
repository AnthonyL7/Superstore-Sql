--Analysis 1
-- Compare category sales between the East and West United States in 2019. (So far only have Central United States)
SELECT
 Max(rgn.sub_region) as sub_region, -- Show sub region
 MAX(prd.category) as category, -- Show category
 SUM(ord.sales) as sales -- Show sales
FROM orders ord -- Start off in orders table
JOIN -- Join regions table into orders
    regions rgn
ON ord.region_id = rgn.region_id
JOIN products prd -- Join products table into orders
ON ord.product_id = prd.product_id
WHERE
 ord.sales > 5 and -- Filter to sales above $5
 rgn.sub_region IN ('West United States','East United States') and -- Filter to sub regions only in West and East coast
 DATE_PART('year', ord.order_date) = 2019  -- limits to 2019
GROUP BY rgn.sub_region, prd.category -- group it by sub region and category to organize it better 
;


-- Analysis 2
-- Compare our Technology category sales from 2016 - 2019 to find if we are in a positve trend
SELECT
 Max(rgn.sub_region) as sub_region, -- Shows sub_region
 MAX(ord.order_date) as year, -- shows year
 SUM(ord.sales) as sales -- shows SUM of sales
FROM orders ord -- start off in orders table
JOIN -- join regions in to orders
    regions rgn 
ON ord.region_id = rgn.region_id
JOIN products prd -- join products into orders 
ON ord.product_id = prd.product_id
WHERE
 ord.sales > 5 and -- Shows sales greater than $5
 prd.category = 'Technology' and -- Shows Tech category only 
 rgn.sub_region IN ('West United States','East United States') AND -- Filters only to sales in West and East
 DATE_PART('year', ord.order_date) = 2016 -- limits to 2016
GROUP BY rgn.sub_region, prd.category -- Groups by sub region and category 
;

-- 2017
SELECT
 Max(rgn.sub_region) as sub_region, -- Shows sub_region
 MAX(ord.order_date) as year, -- shows year
 SUM(ord.sales) as sales -- shows SUM of sales
FROM orders ord -- start off in orders table 
JOIN -- join regions in to orders
    regions rgn 
ON ord.region_id = rgn.region_id
JOIN products prd -- join products into orders 
ON ord.product_id = prd.product_id
WHERE
 ord.sales > 5 and -- Shows sales greater than $5
 prd.category = 'Technology' and -- Shows Tech category only 
 rgn.sub_region IN ('West United States','East United States') AND -- Filters only to sales in West and East
 DATE_PART('year', ord.order_date) = 2017 -- limits to 2017
GROUP BY rgn.sub_region, prd.category -- Groups by sub region and category 
;

-- 2018 
SELECT
 Max(rgn.sub_region) as sub_region, -- Shows sub_region
 MAX(ord.order_date) as year, -- shows year
 SUM(ord.sales) as sales -- shows SUM of sales
FROM orders ord -- start off in orders table 
JOIN -- join regions in to orders
    regions rgn 
ON ord.region_id = rgn.region_id
JOIN products prd -- join products into orders 
ON ord.product_id = prd.product_id
WHERE
 ord.sales > 5 and -- Shows sales greater than $5
 prd.category = 'Technology' and -- Shows Tech category only 
 rgn.sub_region IN ('West United States','East United States') AND -- Filters only to sales in West and East
 DATE_PART('year', ord.order_date) = 2018 -- limits to 2018
GROUP BY rgn.sub_region, prd.category -- Groups by sub region and category 
;

-- 2019
SELECT
 Max(rgn.sub_region) as sub_region, -- Shows sub_region
 MAX(ord.order_date) as year, -- shows year
 SUM(ord.sales) as sales -- shows SUM of sales
FROM orders ord -- start it in orders table
JOIN -- join regions in to orders
    regions rgn 
ON ord.region_id = rgn.region_id
JOIN products prd -- join products into orders 
ON ord.product_id = prd.product_id
WHERE
 ord.sales > 5 and -- Shows sales greater than $5
 prd.category = 'Technology' and -- Shows Tech category only 
 rgn.sub_region IN ('West United States','East United States') AND -- Filters only to sales in West and East
 DATE_PART('year', ord.order_date) = 2019 -- limits to 2019
GROUP BY rgn.sub_region, prd.category -- Groups by sub region and category 
;


-- Analysis 3
-- Find the products and the gross sales for those products in 'Technology Category' in West United States Region
SELECT
    prd.product_name, -- show product name
    SUM(ord.sales) -- show total order sales
FROM orders ord -- start off in orders table 
JOIN -- join products table into orders
    products prd
ON  ord.product_id = prd.product_id
JOIN -- join regions table into orders
    regions rgn
ON  ord.region_id = rgn.region_id
WHERE
    prd.category = 'Technology' and -- Filter to only Tech category
    rgn.sub_region = 'West United States' and
    DATE_PART('year', ord.order_date) = 2019  -- limits to 2019
GROUP BY prd.product_name -- Group it by product name to organize it better
ORDER BY SUM(ord.sales) Desc -- Get highest product sales by using DESC, then manually get the top 5 products
LIMIT 5
;


-- Find the Top 5 products and the gross sales for those products in 'Technology Category' in East United States Region
SELECT
    prd.product_name, -- show product name
    SUM(ord.sales) -- show total order sales
FROM orders ord -- start off in orders table
JOIN -- join products table into orders
    products prd
ON  ord.product_id = prd.product_id
JOIN -- join regions table into orders
    regions rgn
ON  ord.region_id = rgn.region_id
WHERE
    prd.category = 'Technology' and -- Filter to only Tech category
    rgn.sub_region = 'West United States' and
    DATE_PART('year', ord.order_date) = 2019  -- limits to 2019
GROUP BY prd.product_name -- Group it by product name to organize it better
ORDER BY SUM(ord.sales) Desc -- Get highest product sales by using DESC, then manually get the top 5 products
LIMIT 5
;


--Analysis 4
--Does a higher sale mean more returns from customers in the West Coast?
SELECT
    prd.product_name, -- show product name
    SUM(ord.sales), -- show total of sales
    SUM(rtn.return_quantity) as returns -- show the amount of returns 
FROM orders ord -- start off in orders table 
JOIN -- Join products table into orders
    products prd
ON  ord.product_id = prd.product_id
JOIN -- Join regions table into orders
    regions rgn
ON  ord.region_id = rgn.region_id
LEFT JOIN -- Join returns table into orders 
    returns rtn
ON ord.order_id = rtn.order_id
WHERE
    prd.category = 'Technology' and -- Filter to only Tech category
    rgn.sub_region = 'West United States' and -- Filter to only West Coast 
    prd.product_name IN ('Canon imageCLASS 2200 Advanced Copier', 'Apple Smart Phone, Full Size', 'Cisco Smart Phone, Full Size','Motorola Smart Phone, Full Size','Apple Smart Phone, Cordless') and -- Filter to only these products
    DATE_PART('year', ord.order_date) = 2019  -- limits to 2019
GROUP BY prd.product_name -- Group it by product name to organize it
ORDER BY SUM(ord.sales) Desc -- Get highest product sales by using DESC, then manually get the top 5 products
LIMIT 5 -- Limit it to only 5
;

-- Does a higher sale mean more returns from customers in the East Coast?
SELECT
    prd.product_name, -- show product name
    SUM(ord.sales), -- show total of sales
    SUM(rtn.return_quantity) as returns -- show the amount of returns 
FROM orders ord -- start off in orders table 
JOIN -- Join products table into orders
    products prd
ON  ord.product_id = prd.product_id
JOIN -- Join regions table into orders
    regions rgn
ON  ord.region_id = rgn.region_id
LEFT JOIN -- Join returns table into orders 
    returns rtn
ON ord.order_id = rtn.order_id
WHERE
    prd.category = 'Technology' and -- Filter to only Tech category
    rgn.sub_region = 'East United States' and -- Filter to only East Coast 
    prd.product_name IN ('Canon imageCLASS 2200 Advanced Copier', 'Apple Smart Phone, Full Size', 'Cisco Smart Phone, Full Size','Motorola Smart Phone, Full Size','Apple Smart Phone, Cordless') and -- Filter to only these products
    DATE_PART('year', ord.order_date) = 2019  -- limits to 2019
GROUP BY prd.product_name -- Group it by product name to organize it
ORDER BY SUM(ord.sales) Desc -- Get highest product sales by using DESC, then manually get the top 5 products
LIMIT 5 -- Limit it to only 5
;


-- Analysis 5
-- Does a higher dicsount affect our Sales in the West Coast?
SELECT 
    prd.product_name, -- show product name
    MAX(ord.discount) as discount, -- show the discount
    SUM(ord.sales) -- show the total number of sales
FROM orders ord -- start off in orders table
JOIN -- join products table into orders 
    products prd
ON  ord.product_id = prd.product_id
JOIN -- join regions table into orders
    regions rgn
ON  ord.region_id = rgn.region_id
WHERE
    prd.category = 'Technology' and --filter to only Tech category
    rgn.sub_region = ('West United States') and --filter to West United States
    prd.product_name IN ('Canon imageCLASS 2200 Advanced Copier', 'Apple Smart Phone, Full Size', 'Cisco Smart Phone, Full Size','Motorola Smart Phone, Full Size','Apple Smart Phone, Cordless') and -- Filter to only pull this product names
    DATE_PART('year', ord.order_date) = 2019  -- limits to 2019
GROUP BY prd.product_name -- Group it by product name in order to organize it better 
ORDER BY SUM(ord.sales) Desc -- Get highest product sales by using DESC, then manually get the top 5 products
LIMIT 5 -- orgainize it to only show 5 rows
;


-- Does a higher dicsount affect our Sales in the East Coast?
SELECT 
    prd.product_name, -- show product name
    MAX(ord.discount) as discount, -- show the discount
    SUM(ord.sales) -- show the total number of sales
FROM orders ord -- start off in orders table
JOIN -- join products table into orders 
    products prd
ON  ord.product_id = prd.product_id
JOIN -- join regions table into orders
    regions rgn
ON  ord.region_id = rgn.region_id
WHERE
    prd.category = 'Technology' and --filter to only Tech category
    rgn.sub_region = ('East United States') and --filter to East United States
    prd.product_name IN ('Canon imageCLASS 2200 Advanced Copier', 'Apple Smart Phone, Full Size', 'Cisco Smart Phone, Full Size','Motorola Smart Phone, Full Size','Apple Smart Phone, Cordless') and -- Filter to only pull this product names
    DATE_PART('year', ord.order_date) = 2019  -- limits to 2019
GROUP BY prd.product_name -- Group it by product name in order to organize it better 
ORDER BY SUM(ord.sales) Desc -- Get highest product sales by using DESC, then manually get the top 5 products
LIMIT 5 -- orgainize it to only show 5 rows
;
