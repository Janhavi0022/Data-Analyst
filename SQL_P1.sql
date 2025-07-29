SELECT * FROM public.retail_sales;
--Q1: Retrieve all sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date ='2022-11-05';

--Q2: Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in Nov 2022
  SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
--Q3: Calculate the total sales (total_sale) for each category
 SELECT 
 category,
 SUM(total_sale) as net_sale,
 COUNT(*) as total_orders
 FROM retail_sales
 GROUP BY 1
--Q4: Find the average age of customers who purchased items from the 'Beauty' category
SELECT 
ROUND(AVG(Age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
--Q5: Retrieve all transactions where total_sale is greater than 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000
--Q6: Find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
category,
gender,
COUNT(*) as total_trans
FROM retail_sales
GROUP
BY
category,
gender
--Q7: Calculate the average sale for each month and find the best-selling month in each year
SELECT
YEAR,
MONTH,
avg_sale
FROM
(
SELECT
 EXTRACT(YEAR FROM sale_Date) as year,
 EXTRACT(MONTH FROM sale_date) as month,
 AVG(total_sale) as avg_sale,
 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale)DESC) as rank
 FROM retail_sales
 GROUP BY 1,2
 ) as t1
 WHERE rank = 1

--Q8: Find the top 5 customers based on the highest total sales
SELECT 
customer_id,
SUM(total_sale) as tottal_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q9: Find the number of unique customers who purchased items from each category
SELECT
  category,
  COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;

--Q10: Create each shift and count the number of orders (Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS order_count
FROM retail_sales
GROUP BY shift;
