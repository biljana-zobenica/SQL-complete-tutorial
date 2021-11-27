  SELECT *
  FROM tutorial.us_housing_units;
  
  SELECT year,
       month,
       month_name,
       south,
       west,
       midwest,
       northeast
  FROM tutorial.us_housing_units;
  
 /* Without the double quotes, that query would 
 read 'West' and 'Region' as separate objects and
 would return an error. Note that the results will
 only return capital letters if you put column names
 in double quotes. */
  
  SELECT west AS West_Region,
       south AS South_Region
  FROM tutorial.us_housing_units;
  
  