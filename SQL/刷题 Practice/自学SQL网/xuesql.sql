

--------------------------------------------------
--------------- http://xuesql.cn/ ----------------
--------------------------------------------------

--------------------------------------------------
--------------- by 白蛋 --------------------------
--https://github.com/hackerBaiDan/CS-DATA_Learning-
--------------------------------------------------


----------------------------------
-- SQL Lesson 1: SELECT 查询 101 --
-----------------------------------
--1.【简单查询】找到所有电影的名称title--
SELECT title
FROM movies;
--2.【简单查询】找到所有电影的导演--
SELECT Director
FROM movies;
--3.【简单查询】找到所有电影的名称和导演--
SELECT Title, Director
FROM movies;
--4.【简单查询】找到所有电影的名称和上映年份--
SELECT Title, Year
FROM movies;
--5.【简单查询】找到所有电影的所有信息--
SELECT *
FROM movies;
--6.【简单查询】找到所有电影的名称,Id和播放时长--
SELECT Title, Id, Length_minutes
FROM movies;

--------------------------------------------------
-- SQL Lesson 2: 条件查询 (constraints) (Pt. 1) --
--------------------------------------------------
--1.【简单条件】找到id为6的电影--
SELECT *
FROM movies
WHERE id=6;
--2.【简单条件】找到在2000-2010年间year上映的电影--
SELECT *
FROM movies
WHERE Year BETWEEN 2000 AND 2010;
--3.【简单条件】找到不是在2000-2010年间year上映的电影--
SELECT *
FROM movies
WHERE Year NOT BETWEEN 2000 AND 2010;
--4.【简单条件】找到头5部电影--
SELECT *
FROM movies
WHERE id<=5;
--5.【简单条件】找到2010（含）年之后的电影里片长小于两个小时的片子--
SELECT *
FROM movies
WHERE Year>=2010 AND Length_minutes<120;

--------------------------------------------------
-- SQL Lesson 3: 条件查询(constraints) (Pt. 2) --
--------------------------------------------------
--1.【复杂条件】找到所有Toy Story系列电影--
SELECT *
FROM movies
where Title LIKE '%Toy Story%'
--2.【复杂条件】找到所有John Lasseter导演的电影--
SELECT *
FROM movies
where Director ='John Lasseter'
--3.【复杂条件】找到所有不是John Lasseter导演的电影--
SELECT *
FROM movies
where Director !='John Lasseter'
--4.【复杂条件】找到所有电影名为 "WALL-" 开头的电影--
SELECT *
FROM movies
WHERE Title  LIKE 'WALL-%'
--5.【复杂条件】有一部98年电影中文名《虫虫危机》请给我找出来--
SELECT *
FROM movies
WHERE Title ="A Bug's Life" AND Year=1998

--------------------------------------------------------
-- SQL Lesson 4: 查询结果Filtering过滤 和 sorting排序 --
--------------------------------------------------------
--1.【结果排序】按导演名排重列出所有电影(只显示导演)，并按导演名正序排列--
SELECT DISTINCT Director
FROM movies
ORDER BY Director ASC
--2.【结果排序】列出按上映年份最新上线的4部电影--
SELECT DISTINCT *
FROM movies
ORDER BY Year DESC
LIMIT 4
--3.【结果排序】按电影名字母序升序排列，列出前5部电影--
SELECT DISTINCT * FROM movies
ORDER BY Title ASC LIMIT 5
--4.【结果排序】按电影名字母序升序排列，列出上一题之后的5部电影--
SELECT DISTINCT *FROM movies
ORDER BY Title ASC LIMIT 5 OFFSET 5;
--5.【结果排序】如果按片长排列，John Lasseter导演导过片长第3长的电影是哪部，列出名字即可==AVG()
SELECT Title FROM movies
WHERE Director='John Lasseter'
ORDER BY Length_minutes ASC limit 1 offset 2;

----------------------------------
-- SQL Review: 复习 SELECT 查询 --
----------------------------------
--1.【复习】列出所有加拿大人的Canadian信息(包括所有字段)--
SELECT *
FROM north_american_cities
WHERE Country='Canada'
--2.【复习】列出所有在Chicago西部的城市，从西到东排序(包括所有字段)--
SELECT *
FROM north_american_cities
WHERE Longitude<-87.629798
ORDER BY Longitude DESC
--3.【复习】用人口数population排序,列出墨西哥Mexico最大的2个城市(包括所有字段) --
SELECT *
FROM north_american_cities
WHERE Country='Mexico'
ORDER BY Population DESC
LIMIT 2
--4.【复习】列出美国United States人口3-4位的两个城市和他们的人口(包括所有字段)--
SELECT * FROM north_american_cities
WHERE Country='United States' ORDER BY 	Population  LIMIT 2 OFFSET 2


------------------------------------------
-- SQL Lesson 6: 用JOINs进行多表联合查询 --
------------------------------------------
--1.【联表】找到所有电影的国内Domestic_sales和国际销售额--
SELECT * FROM movies inner join boxoffice on movies.id = boxoffice.movie_id
--2.【联表】找到所有国际销售额比国内销售大的电影--
SELECT * FROM movies inner join boxoffice on movies.id = boxoffice.movie_id WHERE  Boxoffice.Domestic_sales<Boxoffice.International_sales
--3.【联表】找出所有电影按市场占有率rating倒序排列--
SELECT * FROM movies inner join Boxoffice on Movies.Id = Boxoffice.Movie_id ORDER BY rating DESC
--4.【联表】每部电影按国际销售额比较,排名最靠前的导演是谁,国际销量多少--
SELECT Director,International_sales FROM movies inner join Boxoffice on Movies.Id=Boxoffice.Movie_id ORDER BY International_sales DESC LIMIT 1


------------------------------------------
-- SQL Lesson 7: 外连接（OUTER JOINs） --
------------------------------------------
--1.【复习】找到所有有雇员的办公室(buildings)名字--
SELECT DISTINCT building FROM employees where building is not null
--2.【复习】找到所有办公室里的所有角色（包含没有雇员的）,并做唯一输出(DISTINCT)--
SELECT DISTINCT buildings.building_name, employees.Role FROM buildings left join employees on buildings.building_name = employees.building
--3.【难题】找到所有有雇员的办公室(buildings)和对应的容量--
SELECT DISTINCT Buildings.Building_name,Buildings.Capacity FROM Employees inner JOIN Buildings ON Employees.Building=Buildings.Building_name WHERE Building is not null


----------------------------------------
-- SQL Lesson 8: 关于特殊关键字 NULLs --
----------------------------------------
--1.【复习】找到雇员里还没有分配办公室的(列出名字和角色就可以)--
SELECT Employees.Role,Employees.Name FROM employees WHERE Building is NULL
--2.【难题】找到还没有雇员的办公室--
SELECT Building_name FROM buildings left join employees on buildings.building_name = employees.building WHERE Role IS NULL

--------------------------------------
-- SQL Lesson 9: 在查询中使用表达式 --
--------------------------------------
--1.【计算】列出所有的电影ID,名字和销售总额(以百万美元为单位计算)--
SELECT Id,Title,(Domestic_sales+International_sales)/1000000 as 销售总额 FROM movies inner join Boxoffice on Movies.Id=Boxoffice.Movie_id
--2.【计算】列出所有的电影ID,名字和市场指数(Rating的10倍为市场指数)--
SELECT Id,Title ,rating*10 as 市场指数 FROM movies inner join Boxoffice on Movies.Id=Boxoffice.Movie_id
--3.【计算】列出所有偶数年份的电影，需要电影ID,名字和年份--
SELECT ID,Title,Year FROM movies WHERE Year%2==0
--4.【难题】John Lasseter导演的每部电影每分钟值多少钱,告诉我最高的3个电影名和价值就可以--
SELECT Title,(Domestic_sales+International_sales)/Length_minutes AS 价值 FROM Movies inner join Boxoffice on Movies.Id=Boxoffice.Movie_id WHERE Director='John Lasseter' ORDER BY 价值 DESC LIMIT 3

----------------------------------------------
-- SQL Lesson 10: 在查询中进行统计I (Pt. 1) --
----------------------------------------------
--1.【统计】找出就职年份最高的雇员(列出雇员名字+年份）--
SELECT Name,max(Years_employed) FROM employees
--2.【分组】按角色(Role)统计一下每个角色的平均就职年份--
SELECT role,avg(Years_employed) FROM employees group by role
--3.【分组】按办公室名字总计一下就职年份总和--
SELECT Building,sum(Years_employed) FROM employees group by Building
--4.【难题】每栋办公室按人数排名,不要统计无办公室的雇员--
SELECT building,count(*) as count FROM employees where building is NOT null group by building


----------------------------------------------
-- SQL Lesson 11: 在查询中进行统计II (Pt. 2)--
----------------------------------------------
--1.【统计】统计一下Artist角色的雇员数量--
SELECT Count(*) AS 雇员数目 FROM employees WHERE Role='Artist'
--2.【分组】按角色统计一下每个角色的雇员数量--
SELECT role,count() FROM employees group by role
--3.【分组】算出Engineer角色的就职年份总计--
SELECT sum(Years_employed) FROM employees where role='Engineer'
--4.【难题】按角色分组算出每个角色按有办公室和没办公室的统计人数(列出角色，数量，有无办公室,注意一个角色如果部分有办公室，部分没有需分开统计）--
SELECT count(*) as count,Role,building is not null as 人数 FROM employees group by Role,人数

--------------------------------
-- SQL Lesson 12: 查询执行顺序--
--------------------------------
--1.【复习】统计出每一个导演的电影数量（列出导演名字和数量）--
SELECT DIRECTOR, count()AS 电影数量 FROM movies group by director
--2.【复习】统计一下每个导演的销售总额(列出导演名字和销售总额)--
SELECT DIRECTOR, sum(Domestic_sales+International_sales)AS 销售总额 FROM movies inner join Boxoffice on Movies.Id=Boxoffice.Movie_id group by director
--3.【难题】按导演分组计算销售总额,求出平均销售额冠军（统计结果过滤掉只有单部电影的导演，列出导演名，总销量，电影数量，平均销量)--
SELECT Director, SUM(Domestic_sales)+SUM(International_sales) AS TOTAL,count() AS COUNTS,(SUM(Domestic_sales)+SUM(International_sales))/count(*) as avg FROM MOVIES LEFT join Boxoffice on movies.Id=Boxoffice.movie_id group by director having countS > 1 order by avg DESC LIMIT 1
--4.【变态难】找出每部电影和单部电影销售冠军之间的销售差，列出电影名，销售额差额--
SELECT (SELECT (Domestic_sales+International_sales) as total_sale FROM movies left join boxoffice on movies.id = boxoffice.movie_id order by total_sale desc limit 1) - (Domestic_sales+International_sales) as sale_diff,title FROM movies left join boxoffice on movies.id = boxoffice.movie_id order by sale_diff desc
