# STUDY and PRACTICE of SQL_DATA BY BAIDAN 
#       AT 2021.01.06 based on《MySQL必知必会 第五版》 
#              ATTENTION：【】为解释说明


###顺序 SELECT * FROM * WHERE * GOURUP BY * HAVING * ORDER BY * LIMIT *

###登陆MySQL 
# mysql -u 用户名 -p -h 主机名 -P 端口号

###选择数据库
#USE 数据库名;

###显示指令集

##数据库&表
SHOW DATABASES;
SHOW TABLES;

##指定表单详情
#SHOW 表名 FROM 数据库; == DSCRIBE 表名;

##状态信息
SHOW STATUS;

##用户安全
SHOW GRANTS;

##服务器错误或警告信息
SHOW ERRORS;
SHOW WARNINGS;

###检索数据指令集

##指定列
#SELECT 列A,列B,列C FROM 表;

##全集
#SELECT * FROM 表;

##去重(不同的值)
#SELECT DISTINCT 列 FROM 表; 

##限制
#SELECT 列 FROM 表 LIMIT 开始位置,检索行数【默认剩余全集】;

###排序检索数据指令集
##基本升序
#SELECT 列,列 FROM 表 ORDER BY 列,列;

##基本降序
#SELECT 列,列 FROM 表 ORDER BY 列A DESC,列B ASC; 【列A降序 列B升序】

##最值寻找
#SELECT 列 FROM 表 ORDER BY 列 ASC/DESC LIMIT 1;

###过滤指令集

##匹配过滤数据
#SELECT 列 FROM 表 WHERE 过滤条件 ORDER BY 列; 【ORDER 一定要在WHERE后】
#【过滤条件 ①<>不等于 ②BETWEEN x AND y指定两值间 ③!=不等于 ④is NULL空值】

##比较数据过滤
#SELECT 列 FROM 表 WHERE 过滤条件A 操作符 过滤条件B;
#【操作符 AND OR IN NOT】
#【AND优先级高 要OR优先用括号() ex. WHERE (x=y OR x=z) AND x=r】
#【WHERE x NOT IN (y,z)】

##通配符过滤
#【LIKE是谓词 不是操作符】
#SELECT 列 FROM 表 WHERE 项 LIKE '%内%容%’;【%搜索多个匹配 区分大小写 注意空格0 不匹配NULL】
#SELECT 列 FROM 表 WHERE 项 LIKE '_内_容_';【_搜索单个匹配】

##正则表达式过滤
#【仅支持很小的子集】
#【.表示任意一个字符 |表示OR [ABC]表示[A|B|C]  [A-Z]表示A到Z任一】
#SELECT 列 FROM 表 WHERE 项 REGXP '内容';



###计算字段
#【处理应用检索数据 在SELECT语句内创建】

##拼接字段
#SELECT Concat(," ",) FROM 表 ORDER BY 项;

##使用别名
#【创建保存拼接字段供客户机应用】
#SELECT Concat(," ",) AS 别名 FROM 表 ORDER BY 项;

##执行计算
#SELECT 列+-*/列 AS 别名 FROM 表 ORDER BY 项;

###数据处理函数
#【少用 不易于移植 一定要写注释】
#【文本处理函数 日期和时间处理函数 数值处理函数】

###汇总数据函数
##聚集函数
#【维独COUNT(*)不忽略】
#SELECT 函数(列) AS 别名 FROM 表 WHERE 过滤条件;
##聚焦不同值
#【ALL默认 DISTINCT只含不同值且不能用于COUNT(*)】
#SELECT 函数(DISTINCT 列) AS 别名 FROM 表 WHERE 过滤条件;

###分组数据函数

##创建分组
#【WITH ROLLUP 在group分组字段的基础上再进行统计数据】
#SELECT 列,函数() AS 别名 FROM 表 GROUP BY 列 WITH POLLUP;

##过滤分组
#【WHERE在数据分组前进行过滤， HAVING在数据分组后进行过滤】
#SELECT 列.函数() AS 别名 FROM 表 GROUP BY 列 HAVING 过滤条件;

###子查询
#【子查询中列相同数目】
#SELECT 列 FROM 表 WHERE (SELECT 列 FROM 表 WHERE 过滤条件);

###联结表
##创建联结
#SELECT 列 FROM 表 WHERE 表.列=表.列;

##内部联结
#SELECT 列 FROM 表 INNER JOIN 表 ON 表.列=表.列;

##高级联结
#【表别名，只在查询执行使用，不返回客户机】
#自联结    SELECT 表别名1.列,表别名2.列 FROM 表 AS 表别名1,表 AS 表别名2 WHERE 过滤条件；
#自然联结  SELECT 表别名1.* FROM 表 AS 表别名1 WHERE 过滤条件;
#外部联结  SELECT 表.列 FROM 表 LEFT/RIGHT OUTER JOIN 项 ON 过滤条件;【左表联结 右表联结】

###组合查询
#【UNION中只能用一条ORDER BY】
#【默认去重 UNION ALL非去重】
#【组合多个SELECT 几个SELECT用几个UNION】
#SELECT 列 FROM 表 WHERE 过滤 UNION SELECT 列 FROM 表 WHERE 过滤;

###全文本搜索
#【先CREATE TABLE 加上FULLTEXT(列)】
#【不区分大小写 除非用BINARY】
##基本格式
#SELECT 列 FROM 表 WHERE Match(列) Against("内容");

##查询扩展搜索【所在行相关内容也被搜索】
#SELECT 列 FROM 表 WHERE Match(列) Against("内容" WITH QUERY EXPANSION);

##布尔文本搜索
#【无FULLTEXT也可以使用】
#SELECT 列 FROM 表 WHERE Match(列) Against("内容 布尔操作符 内容" IN BOOLEAN MODE);
#【布尔操作符  +包含 -排除 >包含等级大于 <包含等级小于 *通配符 '"AB"'匹配A和B 'AB'匹配A或B】

###插入数据
##基本格式
#INSERT INTO 表( , ) VALUES( , ),( , );【更加安全】

##插入检索出的数据
#SELECT INTO 表( , ) SELECT 列 FROM 表 WHERE 过滤;

###更新删除数据
#【更新删除操作前先用SELECT检查】
##更新数据
#UPDATE 列 SET 修改 WHERE 过滤;
#UPDATE IGNORE 列 SET 修改 WHERE 过滤;【忽略错误】

##删除数据
#DELETE FROM 表 WHERE 过滤;【仅删除整行非列 为了删除制定列用UPDATE】
#TRUNCATE TABLE 删除所有行

###操纵表

##创建表
#CREATE TALBE 表( , )ENGINE =InnoDB/AUTO _INCREMENT;
#【列名 类型 NOT NULL AUTO_INCREMENT 自动增量】
#【列名 类型 NOT NULL DEFAULT * 默认值且不允许函数作为默认值】
#【搜索引擎 InnoDB事务处理且不支持全文搜索 MEMORY速度快存储内存 MyISAM性能高支持全文搜索 不支持事务处理】
#【主键 PRIMARY KEY(列)】

##更新表
#ALTER TABLE 表 ADD/DROP 列;

##删除表
#DROP TABLE 表;

##重命名表
#RENAME TABLE 表 to 表;

###使用视图
#【虚拟的表 只包含使用时动态检索数据的查询】
#【隐藏复杂的SQL 预先过滤/处理数据】
#创建视图 CREATE VIEW 视图;
#删除视图 DROP VIEW 视图;
#查看视图 SHOW CREATE VIEW 视图;
#更新视图 INSERT/UPDATE/DELETE 视图;
#SELECT 列 FROM 视图 WHERE 过滤;

###存储过程
#【更简单、安全、高性能】
#创建存储过程 CREATE PROCEDURE 储存名() BEGIN **** END；
#使用存储过程 CALL 存储名();
#删除存储过程 DROP PROCEDURE IF EXISTS 存储名;
#使用参数变量 CREATE PROCEDURE 存储名(OUT/IN/INOUT 变量 DECIMAL) BEGIN END;
#显示参数变量 SELECT @变量;

###全球化和本地化
##字符集和校对顺序
#显示字符集描述和默认校对 SHOW CHARACTER SET;
#显示所支持校对的完整列表 SHOW COLLATION;
#显示指定字符集和校对 SHOW VARIABLES LIKE "%";
#指定列设置字符集和校对范围 CREATE TABLE 表()DEFAULT CHARACTER SET 列 COLLATE 列;

###安全管理
##访问控制
#管理用户 USE 数据库; SELECT 表 FROM 用户;
#创建用户账号 CREATE USER 用户名 IDENTIFIED BY '密码';
#重命名用户 RENAME USER 用户名 to 新用户名;
#删除用户 DROP USER 用户名;
#查看访问权限 SHOW GRANTS FOR 用户名;
#赋予访问权限 GRANT SELECT【权限名】 ON 数据库.*【所有表】 TO 用户名;
#撤销访问权限 REVOKE SELECT【权限名】 ON 数据库.* FROM 用户名;
#更改口令 SET PASSWORD FOR 用户名 = Password('新密码');

###数据库维护
#备份数据库 mysqldump
#显示所有状态信息 ANALYZE TABLE 表;


