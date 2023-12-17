SELECT 
`Product line`, 
ROUND(SUM(`Gross Income`),1) AS `Gross Income`,
ROUND(SUM(total),1) AS total,
ROUND(SUM(COGS),1) AS COGS
FROM supermarket_sales
WHERE Branch = 'A'
GROUP BY `Product line`;


SELECT 
`Product line`, 
ROUND(SUM(`Gross Income`),1) AS `Gross Income`,
ROUND(SUM(total),1) AS total,
ROUND(SUM(COGS),1) AS COGS
FROM supermarket_sales
WHERE Branch = 'B'
GROUP BY `Product line`;


SELECT 
`Product line`, 
ROUND(SUM(`Gross Income`),1) AS `Gross Income`,
ROUND(SUM(total),1) AS total,
ROUND(SUM(COGS),1) AS COGS
FROM supermarket_sales
WHERE Branch = 'C'
GROUP BY `Product line`;




SELECT 
`Product line`,
COUNT(`Total`) As total
FROM supermarket_sales
WHERE Branch = 'A' AND `Gender` = 'Female'
GROUP BY `Product line`
ORDER BY total DESC;

SELECT 
`Product line`,
COUNT(`Total`) As total
FROM supermarket_sales
WHERE Branch = 'A' AND `Gender` = 'male'
GROUP BY `Product line`
ORDER BY total DESC;


SELECT 
`Product line`,
COUNT(`Total`) As total
FROM supermarket_sales
WHERE Branch = 'B' AND `Gender` = 'Female'
GROUP BY `Product line`
ORDER BY total DESC;


SELECT 
`Product line`,
COUNT(`Total`) As total
FROM supermarket_sales
WHERE Branch = 'B' AND `Gender` = 'male'
GROUP BY `Product line`
ORDER BY total DESC;


SELECT 
`Product line`,
COUNT(`Total`) As total
FROM supermarket_sales
WHERE Branch = 'C' AND `Gender` = 'female'
GROUP BY `Product line`
ORDER BY total DESC;

SELECT 
`Product line`,
COUNT(`Total`) As total
FROM supermarket_sales
WHERE Branch = 'C' AND `Gender` = 'male'
GROUP BY `Product line`
ORDER BY total DESC;


SELECT 
`Product line`
`Payment`,
COUNT(*) / (SELECT COUNT(*) FROM supermarket_sales) * 100 AS `payment methods`
FROM supermarket_sales
GROUP BY  `Payment`, `Product line`;


SELECT 
`Customer type`,
COUNT(*) / (SELECT COUNT(*)  FROM supermarket_sales) * 100 AS `Customer type` 
FROM supermarket_sales
GROUP BY `Customer type`;

SELECT 
`Rating`,
CASE 
WHEN `Rating` between  8.0 AND 10  THEN 'perfect'
WHEN `Rating` between  5.0 AND 7.9  THEN 'good'
WHEN `Rating` between  1.0  AND 5.9  THEN 'Bad'
END `Rating`
FROM supermarket_sales;


SELECT distinct
MONTHNAME(date) AS month_name,
YEAR(date) AS Year
FROM supermarket_sales;





WITH January_2019 AS(
SELECT 
  `Product line`,
  `COGS`, `Total`,
    SUM(`Gross Income`) AS `Gross Income`,
    ROUND (`Gross Margin Precentage`,1) AS `Gross Margin Precentage`
FROM supermarket_sales
WHERE date BETWEEN '2019-01-01' AND '2019-01-31'
GROUP BY   `Product line`,`COGS`, `Total`,`Gross Income`, `Gross Margin Precentage`)
SELECT *
FROM January_2019;
 
 
 

WITH february_2019 as (
SELECT 
  `Product line`,
  `COGS`, `Total`,
    SUM(`Gross Income`) AS `Gross Income`,
    ROUND (`Gross Margin Precentage`,1) AS `Gross Margin Precentage`
FROM supermarket_sales
WHERE date BETWEEN '2019-02-01' AND '2019-02-31'
GROUP BY   `Product line`,`COGS`, `Total`,`Gross Income`, `Gross Margin Precentage`)
 SELECT *
FROM february_2019;




WITH march_2019 as (
SELECT 
  `Product line`,
  `COGS`, `Total`,
    SUM(`Gross Income`) AS `Gross Income`,
    ROUND (`Gross Margin Precentage`,1) AS `Gross Margin Precentage`
FROM supermarket_sales
WHERE date BETWEEN '2019-03-01' AND '2019-03-31'
GROUP BY   `Product line`,`COGS`, `Total`,`Gross Income`, `Gross Margin Precentage`)
 SELECT *
FROM march_2019;


WITH top_Ranked_Products AS (
  SELECT
    `Product line`,
    `Branch`,
    `Rating`,
    RANK() OVER (PARTITION BY `Branch` ORDER BY `Rating` DESC) AS ProductRank
  FROM supermarket_sales  
)
SELECT
   `Product line`,
  `Branch`,
  `Rating`,
  CASE
    WHEN `Rating` BETWEEN 9.0 AND 10.0 THEN 'good'
    ELSE `Rating`
  END AS RatingCategory
FROM top_Ranked_Products
WHERE `Rating` BETWEEN 9.0 AND 10.0;



SELECT distinct
`Product line`,
`Rating`
FROM supermarket_sales 
WHERE `Rating` BETWEEN 8.0 AND 10.0
limit 5;