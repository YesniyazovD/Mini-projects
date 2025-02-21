create database mini_project;

drop table T_TAB2;
create table T_TAB1
(ID INT UNIQUE,
GOODS_TYPE VARCHAR(20),
QUANTITY INT, 
AMOUNT INT,
SELLER_NAME VARCHAR(20)
);

select * from T_TAB1;

create table T_TAB2
(
ID INT UNIQUE, 
NAME_seller VARCHAR (20),
SALARY INT, 
AGE INT
);

select * from T_TAB2;

#Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE).
# Какое количество уникальных категорий товаров вернёт запрос?
select distinct(goods_type) from T_TAB1
group by goods_type;

SELECT 
    (SELECT COUNT(DISTINCT GOODS_TYPE) FROM T_TAB1) AS unique_category_count, 
    (SELECT GROUP_CONCAT(DISTINCT GOODS_TYPE ORDER BY GOODS_TYPE SEPARATOR ', ')
    FROM T_TAB1) AS category_list;
    
    #2 Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных 
    #телефонов. Какое суммарное количество и суммарную стоимость вернул запрос?
    
    select sum(QUANTITY), sum(QUANTITY*AMOUNT) from t_tab1
    where GOODS_TYPE like 'MOBILE PHONE';
    
    #3 Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. 
    # Какое кол-во сотрудников вернул запрос?
    select NAME_seller from t_tab2
    where salary >100000
    group by NAME_seller;
    
    select count(NAME_seller) from (select NAME_seller from t_tab2
    where salary >100000
    group by NAME_seller) as t;
    
    #Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, 
    #а также минимальную и максимальную заработную плату.

    select min(age), max(age), min(salary), max(salary) from t_tab2;
    
    #Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.
    
    select avg(quantity) from t_tab1
    where GOODS_TYPE in ('printer','keyboard');
    
   #6 Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.
select seller_name, sum(amount*quantity) from t_tab1
group by seller_name;

#7 Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, стоимость товара, 
# заработную плату и возраст сотрудника MIKE.

select t1.seller_name, t1.goods_type,t1.QUANTITY, t1.AMOUNT, t2.salary, t2.age from t_tab1 t1
join t_tab2 t2 on t1.SELLER_NAME=t2.NAME_seller
where SELLER_NAME like 'MIKE';

#Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал.
# Сколько таких сотрудников?
select name_seller, age from t_tab2 t2
join t_tab1 t1 on t1.SELLER_NAME=t2.NAME_seller
where QUANTITY =0;

select count(*) from (select name_seller, age from t_tab2 t2
join t_tab1 t1 on t1.SELLER_NAME=t2.NAME_seller
where QUANTITY =0) as NO_num;

#9 Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет?
# Какое количество строк вернул запрос?
select name_seller, salary, age from t_tab2
where age < 26;

select count(*) from (select name_seller, salary, age from t_tab2
where age < 26) as c;

#10 Сколько строк вернёт следующий запрос:
SELECT * FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name_seller = t.seller_name
WHERE t2.name_seller = 'RITA';

select count(*) from (SELECT t.seller_name, t2.name_seller FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name_seller = t.seller_name
WHERE t2.name_seller = 'RITA') as b;
