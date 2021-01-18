

--------------------------------------------------
--------------- http://xuesql.cn/ ----------------
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
SELECT DISTINCT * 
FROM movies
ORDER BY Title ASC LIMIT 5
--4.【结果排序】按电影名字母序升序排列，列出上一题之后的5部电影--
SELECT DISTINCT *
FROM movies
ORDER BY Title ASC LIMIT 5 OFFSET
5;
--5.【结果排序】如果按片长排列，John Lasseter导演导过片长第3长的电影是哪部，列出名字即可==AVG()
SELECT Title
FROM movies
WHERE Director='John Lasseter'
ORDER BY Length_minutes ASC limit 1 offset
2;


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