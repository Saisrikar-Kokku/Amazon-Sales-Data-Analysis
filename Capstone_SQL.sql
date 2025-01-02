-- 1. What is the count of distinct cities in the dataset? 
-- select * from amazondata; 

select count(distinct(city)) as Distinct_Cities from amazondata;

-- 2.For each branch, what is the corresponding city?

select 
		branch,city 
			from amazondata 
					group by branch,city
                    order by branch;
                    
-- 3. What is the count of distinct product lines in the dataset? 

select count(distinct(product_line)) as Distinct_Product_Lines from amazondata;

-- 4. Which payment method occurs most frequently?

select 
		payment_method,COUNT(*) as PAY_Method_COunt,
        rank() over(order by COUNT(*) desc) as Rank_By_most_used_method
			from amazondata 
				group by payment_method
                order by PAY_Method_COunt desc;

-- 5.Which product line has the highest sales? 

SELECT  		
		product_line,sum(total) AS Total_sales,
         rank() over(order by sum(total) desc) as Rank_By_ProductLine
			FROM AMAZONDATA 
				GROUP BY product_line 
                ORDER BY Total_sales desc ;
                
-- 6.How much revenue is generated each month?

SELECT 
		monthname(DATE) AS Month , SUM(total) AS Total_sales 
			FROM amazondata
				GROUP BY Month
				ORDER BY Total_sales DESC ;
                
-- 7. In which month did the cost of goods sold reach its peak? 
SELECT 
		monthname(date) AS Month , sum(cogs) AS Cost_Of_Goods_Sold
			FROM amazondata 
            GROUP BY Month
            ORDER BY Cost_Of_Goods_Sold DESC 
            LIMIT 1;
-- 8.Which product line generated the highest revenue? 

SELECT  		
		product_line,sum(total) AS Total_sales,
         rank() over(order by sum(total) desc) as Rank_By_Highest_Revenue
			FROM AMAZONDATA 
				GROUP BY product_line 
                ORDER BY Total_sales desc ;
			
-- 9. In which city was the highest revenue recorded?

SELECT 
		city,sum(total) AS Total_Revenue
			FROM amazondata 
            GROUP BY city 
            ORDER BY Total_Revenue DESC ;

-- 10.Which product line incurred the highest Value Added Tax? 

SELECT 
		product_line,SUM(VAT) AS Value_Added_Tax ,
        rank() over(order by sum(VAT) desc) as Rank_By_VAT
			FROM amazondata 
            GROUP BY Product_Line 
            ORDER BY Value_Added_Tax DESC;
            
-- 11.For each product line,
--  add a column indicating "Good" if its sales are above average, otherwise "Bad." 

SELECT 
		product_line,SUM(total) AS Total_Sales ,
        CASE WHEN SUM(total) > AVG(total) THEN 'Good'
        ELSE 'Bad' END as Qualitative_Analysis
			FROM amazondata 
            GROUP BY Product_Line ;
            --  AVG VALUE '322.499568'
-- 12.Identify the branch that exceeded the average number of products sold.

SELECT 
		BRANCH , SUM(quantity) AS Products_Sold 
			FROM amazondata 
            GROUP BY BRANCH 
            HAVING  SUM(quantity) > (select  avg(quantity) from amazondata);
            
-- 13.Which product line is most frequently associated with each gender? 

SELECT 
		product_line,count(gender) as Gender_Count 
			FROM amazondata 
            GROUP  BY product_line
            ORDER BY Gender_Count DESC;
            
-- 14.Calculate the average rating for each product line.

SELECT 
		product_line,AVG(rating) AS Rating
        FROM amazondata 
        GROUP BY product_line;
	
-- 15.Count the sales occurrences for each time of day on every weekday

SELECT 
    CASE 
        WHEN DAYOFWEEK(date) = 1 THEN 'Sunday'
	WHEN DAYOFWEEK(date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(date) = 3 THEN 'Tuesday'
	WHEN DAYOFWEEK(date) = 4 THEN 'Wednesday'
WHEN DAYOFWEEK(date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(date) = 7 THEN 'Saturday'
    END AS DayOfWeek,
    HOUR(time) AS HourOfDay,
    COUNT(invoice_id) AS SalesCount
FROM 
    amazondata
GROUP BY 
    DayOfWeek, HourOfDay
ORDER BY 
    FIELD(DayOfWeek, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
    HourOfDay;
    
    
-- 16. Identify the customer type contributing the highest revenue.

	SELECT 
			customer_type, SUM(total) AS Revenue
				FROM amazondata 
                GROUP BY customer_type 
                ORDER BY Revenue DESC 
                LIMIT 1;
      
      -- select * from amazondata;  
-- 17.Determine the city with the highest VAT percentage

	SELECT 
			city , SUM(VAT) AS Value_Added_Tax , (5261.4655 / 15280.3045) * 100 AS Highest_VAT_Percent
				FROM amazondata 
                GROUP BY city
                ORDER BY Value_Added_Tax DESC
                LIMIT 1;
   
   -- 18.Identify the customer type with the highest VAT payments
       
       SELECT 
			customer_type,SUM(VAT) AS Value_Added_Tax 
				FROM amazondata 
                GROUP BY customer_type
                ORDER BY Value_Added_Tax DESC
                LIMIT 1;
                
-- 19.What is the count of distinct customer types in the dataset?

		SELECT 
			COUNT(DISTINCT(customer_type)) AS Distinct_Customer_Type
				FROM amazondata ;
                
-- 20.What is the count of distinct payment methods in the dataset? 

	SELECT 
			COUNT(DISTINCT(payment_method)) AS Distinct_Payment_Methods
				FROM amazondata ;
                
                -- select * from amazondata;  
-- 21.Which customer type occurs most frequently?
                
            SELECT 
					customer_type , COUNT(customer_type) AS Frequency ,
                    RANK() OVER(ORDER BY COUNT(customer_type) DESC) AS RANK_
						FROM amazondata 
                        GROUP BY customer_type 
                        ORDER BY Frequency DESC ;
                        
-- 22.Identify the customer type with the highest purchase frequency

	SELECT 
			customer_type, COUNT(invoice_id) AS Purchase_Frequency 
				FROM amazondata 
                GROUP BY customer_type
                ORDER BY Purchase_Frequency DESC;

-- 23.Determine the predominant gender among customers.

	WITH FEMALE_COUNTS AS (
    SELECT 
		1 as Ref,gender,COUNT(gender) AS Female_Count 
			FROM amazondata 
            where gender = 'Female' 
),
Male_Count AS(

	SELECT 
			1 as Ref,gender,COUNT(gender) AS Male_Count 
				FROM amazondata 
                WHERE gender = 'Male'
)
SELECT
		*
			FROM Male_Count MC INNER JOIN FEMALE_COUNTS FC
            ON MC.Ref = FC.Ref ;
            
            
-- 24.Examine the distribution of genders within each branch.
-- select * from amazondata; 

WITH MALE_DISTRIBUTION AS (
	SELECT 
			Branch  , COUNT(gender) AS Male_Count
				FROM amazondata 
                WHERE gender = 'Male'
                GROUP BY Branch 
                ORDER BY Male_Count DESC 
),
FEMALE_DISTRIBUTION AS 
(
	SELECT 
			Branch  , COUNT(gender) AS Female_Count
				FROM amazondata 
                WHERE gender = 'Female'
                GROUP BY Branch 
                ORDER BY Female_Count DESC 

)

SELECT 
		*
			FROM MALE_DISTRIBUTION MD INNER JOIN FEMALE_DISTRIBUTION FD 
            ON MD.Branch = FD.Branch ;
            
            
-- 25.Identify the time of day when customers provide the most ratings.
-- select * from amazondata; 

	SELECT 
			date ,HOUR(time) as  Hour_OF_TheDay , SUM(rating) AS Rating_SUM
				FROM amazondata 
                GROUP BY date,HOUR(time)
                ORDER BY Rating_SUM DESC ;
                
-- 26.Determine the time of day with the highest customer ratings for each branch

	SELECT 
			Branch,date ,HOUR(time) as  Hour_OF_TheDay , SUM(rating) AS Rating_SUM
				FROM amazondata 
                GROUP BY Branch,date,HOUR(time)
                ORDER BY Rating_SUM DESC ;
                
-- 27 . Identify the day of the week with the highest average ratings

SELECT 
    CASE 
	WHEN DAYOFWEEK(date) = 1 THEN 'Sunday'
        WHEN DAYOFWEEK(date) = 2 THEN 'Monday'
	WHEN DAYOFWEEK(date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(date) = 5 THEN 'Thursday'
	WHEN DAYOFWEEK(date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(date) = 7 THEN 'Saturday'
    END AS DayOfWeek,
    AVG(rating) AS AverageRating
FROM 
    amazondata
GROUP BY 
    DayOfWeek
ORDER BY 
    AverageRating DESC
LIMIT 1;

-- 28. Determine the day of the week with the highest average ratings for each branch.


SELECT 
    Branch,CASE 
	WHEN DAYOFWEEK(date) = 1 THEN 'Sunday'
        WHEN DAYOFWEEK(date) = 2 THEN 'Monday'
	WHEN DAYOFWEEK(date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(date) = 5 THEN 'Thursday'
	WHEN DAYOFWEEK(date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(date) = 7 THEN 'Saturday'
    END AS DayOfWeek,
    AVG(rating) AS AverageRating
FROM 
    amazondata
GROUP BY 
    Branch,DayOfWeek
ORDER BY 
    AverageRating DESC
LIMIT 1;

