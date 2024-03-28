USE vaishnavi;
SELECT * FROM lap;

-- Q1) Which laptop models have the highest spec ratings, and how does their performance compare to the others?
SELECT brand, name, spec_rating
FROM lap
ORDER BY spec_rating DESC
LIMIT 100;

(SELECT brand, name, spec_rating, CASE
                                      WHEN spec_rating BETWEEN 60 AND 75 THEN "LOW"
                                      WHEN spec_rating BETWEEN 76 AND 85 THEN "MEDIUM"
                                      WHEN spec_rating BETWEEN 86 AND 90 THEN "HIGH"
                                      END AS Performance
FROM lap
HAVING Performance = "HIGH"
ORDER BY spec_rating DESC
LIMIT 10)
UNION
(SELECT brand, name, spec_rating, CASE
                                      WHEN spec_rating BETWEEN 60 AND 75 THEN "LOW"
                                      WHEN spec_rating BETWEEN 76 AND 85 THEN "MEDIUM"
                                      WHEN spec_rating BETWEEN 86 AND 90 THEN "HIGH"
                                      END AS Performance
FROM lap
HAVING Performance = "MEDIUM"
ORDER BY spec_rating DESC
LIMIT 10)
UNION
(SELECT brand, name, spec_rating, CASE
                                      WHEN spec_rating BETWEEN 60 AND 75 THEN "LOW"
                                      WHEN spec_rating BETWEEN 76 AND 85 THEN "MEDIUM"
                                      WHEN spec_rating BETWEEN 86 AND 90 THEN "HIGH"
                                      END AS Performance
FROM lap
HAVING Performance = "LOW"
ORDER BY spec_rating DESC
LIMIT 10);



-- Q2) What is the average price of laptops from each brand, and which brands offer the best value for money based on spec ratings?
SELECT brand, AVG(price), spec_rating
FROM lap
GROUP BY brand, spec_rating
HAVING spec_rating > 84
ORDER BY TRUNCATE(AVG(price),3) DESC;


-- Q3) Identify the top 5 best-selling laptop models based on their sales prices.
SELECT brand, SUM(price) as total_sales
FROM lap
GROUP BY brand
ORDER BY SUM(price) DESC
LIMIT 5;


-- Q4) Which laptops are suitable for budget-conscious customers, considering models with a price below 30000 and a spec rating above 60?
SELECT brand, price, TRUNCATE(spec_rating,2)
FROM lap
WHERE price < 30000 and spec_rating > 60
ORDER BY price DESC;


-- Q5) Analyze the gaming laptop portfolio, highlighting models with the highest GPU memory and their corresponding prices.
SELECT brand, name, price, MAX(GPU)
FROM lap
WHERE name LIKE "%Gaming%"
GROUP BY brand, name, price
ORDER BY price DESC;


-- Q6) Determine the most preferred display sizes among customers and how they correlate with the average spec ratings.
SELECT display_size, COUNT(display_size) as count, TRUNCATE(AVG(spec_rating),2)
FROM lap
GROUP BY display_size 
ORDER BY COUNT(display_size) DESC;


-- Q7) Assess customer loyalty by examining how many customers tend to stick to a particular brand when purchasing laptops.
SELECT brand, COUNT(*) AS preference
FROM lap
GROUP BY brand
ORDER BY COUNT(*) DESC;


-- Q8) Evaluate the warranty periods offered by different brands and their potential impact on customer satisfaction and purchase decisions.
SELECT brand, warranty, COUNT(*) AS purchases
FROM lap
GROUP BY brand, warranty
ORDER BY COUNT(*) DESC;


-- Q9) Analyze the popularity of operating systems (Windows 11, Mac OS, Android) among customers and identify any emerging trends.
SELECT brand, OS, COUNT(OS) AS Popularity
FROM lap
WHERE OS IN ("Windows 11 OS", "Mac OS", "Android 11 OS")
GROUP BY brand, OS
ORDER BY COUNT(OS) DESC;


-- Q10) Based on sales performance and customer feedback, recommend which laptops should be prioritized for stock replenishment or potential marketing campaigns.
SELECT brand, COUNT(brand), name, TRUNCATE(AVG(spec_rating),2) 
FROM lap
GROUP BY brand, name
ORDER BY COUNT(brand) DESC, TRUNCATE(AVG(spec_rating),2) DESC;




-- CONCLUSION
/*
                   HP, MSI, Asus Model Lenovo has the highest rating and average price
                   Dell in Gaming Laptops have most demand as it has High performance
                   HP has the highest sales and also Popular amongst low level budget customers
                   
		As per the analysis HP brand has the highest demand among customer
*/
                   