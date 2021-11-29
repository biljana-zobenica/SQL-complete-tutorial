-- SQL Data Types:

/* For example, COUNT works with any data type, but SUM 
only works for numerical data. In order to use SUM, the
 data must appear to be numeric, but it must also be
 stored in the database in a numeric form. */
 
 /* The INTEGER data type, for example, only stores whole
 numbers—no decimals. The DOUBLE PRECISION data type, on 
 the other hand, can store between 15 and 17 significant
 decimal digits. */
 
 -- Changing a column's data type
 
 /* It's particularly common for dates or numbers, for example,
 to be stored as strings. This becomes problematic when you want
 to sum a column and you get an error because SQL is reading 
 numbers as strings. When this happens, you can use CAST or CONVERT
 to change the data type to a numeric one that will allow you to
 perform the sum. */
 -- two different types of syntax:
 -- 1. CAST(column_name AS integer)
 -- 2. column_name::integer
 
/* Convert the funding_total_usd and founded_at_clean columns in the
 tutorial.crunchbase_companies_clean_date table to strings (varchar format)
 using a different formatting function for each one. */
 
SELECT 	CAST(funding_total_usd AS varchar) AS funding_total_usd_string,
		founded_at_clean::varchar AS founded_at_string
FROM tutorial.crunchbase_companies_clean_date;


 
 
 
