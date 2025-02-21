
# Задание №1 Создайте в MySQL новую базу данных users_adverts. После этого создайте в ней таблицу users 
# (данные в таблицу загружаем из csv файла Users, убедитесь, что колонка date содержит корректный тип 
# данных). После создания базы данных и таблицы, выполните следующие задания:

create database users_adverts;
create table users 
(
date_user DATE not null,
user_id varchar (100),
view_adverts int not null
);
select * from users;
#Напишите запрос SQL, выводящий одним числом количество уникальных пользователей
# в этой таблице в период с 2023-11-07 по 2023-11-15.

select count(distinct(user_id)) from users_adverts.users
where date_user > '2023-11-07' and date_user < '2023-11-15' ;

#2 Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 
select user_id,view_adverts as max_view from users
where view_adverts = (select max(view_adverts) from users);

select max(view_adverts) from users;

# 3 Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, 
# но учитывайте только дни с более чем 500 уникальными пользователями.

select date_user, avg(view_adverts) as max_avg_view, count(distinct(user_id)) as uniq_users from users
group by date_user
having count(distinct(user_id)) >500
order by avg(view_adverts) desc
limit 1;

#4 Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому
# пользователю. Отсортировать LT по убыванию.

select count(date_user) from users
group by user_id
order by count(date_user);

#5 Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день,
# а затем выясните, у кого самый высокий средний показатель среди тех, кто был активен 
# как минимум в 5 разных дней.

select user_id, avg(view_adverts) from users
where user_id in (
    select user_id 
    from users 
    group by user_id 
    having count(distinct date_user) >= 5)
group by user_id
order by avg(view_adverts) desc
limit 1;
