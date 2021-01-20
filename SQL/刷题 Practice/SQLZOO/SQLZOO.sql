
------------------------------------------------------------------------
--------------- https://sqlzoo.net/wiki/SQL_Tutorial/zh ----------------
------------------------------------------------------------------------

----------------------------------------------------
----------------- by 白蛋 --------------------------
--https://github.com/hackerBaiDan/CS-DATA_Learning--
-----------------------------------------------------

-------------------------
------0 SELECT基础-------
-------------------------
---由一些简单的查询开始---
-------------------------
--1.这个例子使用了一个WHERE子句来显示“法国”的人口。注意字符串(数据文本)应该在“单引号”中;修改它以显示德国的人口--
SELECT population FROM world
WHERE name = 'Germany'
--2.检查列表单词IN允许我们检查列表中是否有项目。 该示例显示了“巴西”，“俄罗斯”，“印度”和“中国”国家的名称和人口。显示“瑞典”，“挪威”和“丹麦”的名称和人口。--
SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');
--3.哪些国家既不太小也不太大？BETWEEN 允许范围检查(指定的范围包括边界值)。下面的例子显示面积为250,000-300,000平方公里的国家。修改它以显示国家和面积在20万到25万之间的国家的面积。--
SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000;

-------------------------
------1个SELECT名称-------
-------------------------
-----文字样式匹配查询-----
-------------------------
--1.你可以用WHERE name LIKE 'B%'來找出以 B 為開首的國家。%是萬用字元,可以用代表任何字完。--
SELECT name FROM world
WHERE name LIKE 'Y%'
--2.找出以 Y 為結尾的國家。--
SELECT name FROM world
WHERE name LIKE '%Y'
--3.“Luxembourg 盧森堡”中有一個x字母,還有一個國家的名字中有x。列出這兩個國家。找出所有國家,其名字包括字母x。
SELECT name FROM world
WHERE name LIKE '%x%'
--4.“Iceland 冰島”和“Switzerland 瑞士”的名字都是以”land”作結束的。還有其他嗎?找出所有國家,其名字以 land 作結尾。
SELECT name FROM world
WHERE name LIKE '%land'
--5.“Columbia 哥倫比亞”是以 C 作開始,ia 作結尾的。還有兩個國家相同。找出所有國家,其名字以 C 作開始,ia 作結尾。
SELECT name FROM world
WHERE name LIKE 'C%ia'
--6.“Greece 希臘”中有雙 e 字。哪個國家有雙 o 字呢?找出所有國家,其名字包括字母oo。
SELECT name FROM world
WHERE name LIKE '%oo%'
--7.“Bahamas 巴哈馬”中有三個 a,還有嗎?找出所有國家,其名字包括三個或以上的a。
SELECT name FROM world
WHERE name LIKE '%a%a%a%'
--8.找出所有國家,其名字以t作第二個字母。--
SELECT name FROM world
WHERE name LIKE '_t%'
ORDER BY name
--9.找出所有國家,其名字都有兩個字母 o,被另外兩個字母相隔着。
SELECT name FROM world
WHERE name LIKE '%o__o%'
--10.找出所有國家,其名字都是 4 個字母的。
SELECT name FROM world
WHERE name LIKE '____'
--11.顯示所有國家名字,其首都和國家名字是相同的。
SELECT name FROM world
WHERE `name` = capital
--12.顯示所有國家名字,其首都是國家名字加上”City”。
SELECT name FROM world
WHERE capital LIKE '% City'
--13.找出所有首都和其國家名字,而首都要有國家名字中出現。
SELECT capital,name FROM world
WHERE capital LIKE concat('%',`name`,'%')
--14.找出所有首都和其國家名字,而首都是國家名字的延伸。你應顯示 Mexico City,因它比其國家名字 Mexico 長。你不應顯示 Luxembourg,因它的首都和國家名相是相同的。
SELECT name,capital FROM world
WHERE capital LIKE concat('%',`name`,'%') AND capital>name AND capital!=name
--15.顯示國家名字，及其延伸詞，如首都是國家名字的延伸。
SELECT name,REPLACE ( capital, `name`, '' ) AS ext 
FROM world 
WHERE capital LIKE concat( `name`, '%' ) AND capital != name

-------------------------
----SELECT from World----
-------------------------
--對表格World查詢全球各國的資料。
-------------------------
--1.閱讀此表的注意事項 觀察運行一個簡單的SQL命令的結果。
SELECT name, continent, population FROM world
--2.如何使用WHERE來篩選記錄。 顯示具有至少2億人口的國家名稱。 2億是200000000，有八個零。
SELECT name FROM world
WHERE population>200000000
--3.找出有至少200百萬(2億)人口的國家名稱，及人均國內生產總值。
SELECT name,gdp/population AS 人均国内生产总值 FROM world
WHERE population>200000000
--4.顯示'South America'南美洲大陸的國家名字和以百萬為單位人口數。 將人口population 除以一百萬(1000000)得可得到以百萬為單位人口數。
SELECT name,population/1000000 AS 百萬為單位人口數 FROM world
WHERE continent='South America'
--5.顯示法國，德國，意大利(France, Germany, Italy)的國家名稱和人口
SELECT name,population FROM world
WHERE name='France' or name='Germany' or name='Italy'
--6.顯示包含單詞“United”為名稱的國家。
SELECT name FROM world 
WHERE name LIKE '%United%'
--7.成為大國的兩種方式：如果它有3百萬平方公里以上的面積，或擁有250百萬(2.5億)以上人口。展示大國的名稱，人口和面積。
SELECT name,population,area FROM world
WHERE population >250000000 OR area > 3000000
--8.美國、印度和中國(USA, India, China)是人口又大，同時面積又大的國家。排除這些國家。顯示以人口或面積為大國的國家，但不能同時兩者。顯示國家名稱，人口和面積
SELECT name, population, area FROM world 
WHERE (area > 3000000 AND population < 250000000) OR(area < 3000000 AND population > 250000000)
--9.對於南美顯示以百萬計人口，以十億計2位小數GDP。
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world 
WHERE continent = 'South America'
--10.顯示萬億元國家的人均國內生產總值，四捨五入到最近的$ 1000。
SELECT name, ROUND(gdp/population/1000)*1000 FROM world 
WHERE gdp > 1000000000000
--11.显示名称-但以N开头的国家/地区为大洋洲，但要用大洋洲代替
SELECT name
       ,CASE WHEN continent='Oceania' 
             THEN 'Australasia'
             ELSE continent 
        END
FROM world
WHERE name LIKE 'N%'
--12.显示名称和大陆——但用欧亚大陆代替欧洲和亚洲;替代美国-每个国家在北美或南美或加勒比。显示以A或B开头的国家
SELECT name
       ,CASE WHEN continent='Asia' 
             THEN 'Eurasia'
             WHEN continent='Europe' 
             THEN 'Eurasia'
             WHEN continent = 'North America' 
             THEN 'America'
             WHEN continent = 'South America' 
             THEN 'America'
             WHEN continent = 'Caribbean' 
             THEN 'America'
             ELSE continent
        END
FROM world
WHERE name LIKE 'A%' OR name LIKE 'B%'
--13.展示所有国家的名称、原始大陆和新大陆。
SELECT name,continent
       ,CASE WHEN continent='Oceania' 
             THEN 'Australasia'
             WHEN continent IN ('Eurasia', 'Turkey') 
             THEN 'Europe/Asia' 
             WHEN continent = 'Caribbean'  AND name LIKE 'B%'
             THEN 'North America'
             WHEN continent = 'Caribbean'
             THEN 'South America'
             ELSE continent
        END
FROM world
ORDER BY name;
