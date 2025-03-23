-- Dataset from https://www.kaggle.com/datasets/tawfikelmetwally/automobile-dataset

select *
from car_schema.automobile

1) Which cars have the best mpg?
select name, mpg, model_year, horsepower, weight
from car_schema.automobile
order by mpg DESC
limit 10

2) Which Cars have the most horsepower per weight?
select name, round(horsepower/weight * 100,2) AS Horsepower_Per_Weight_X_100, acceleration
from car_schema.automobile
Order By Horsepower_Per_Weight_X_100 DESC


3) List the top 5 quickest cars from USA, Japan, and Europe
with t1 as
(select origin ,name,acceleration
from car_schema.automobile
where origin = "usa"
order by acceleration
limit 5),
t2 as 
(select origin,name,acceleration
from car_schema.automobile
where origin = "europe"
order by acceleration
limit 5),
t3 as 
(select origin,name,acceleration
from car_schema.automobile
where origin = "japan"
order by acceleration
limit 5)
SELECT *
FROM (
  SELECT * FROM t1
  UNION ALL
  
  SELECT * FROM t2
  UNION ALL
  SELECT * FROM t3
) AS result;
