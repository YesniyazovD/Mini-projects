#1 Выведите сколько пользователей добавили книгу 'Coraline',
сколько пользователей прослушало больше 10%. 

select * from audio_cards;
select * from audiobooks;
select * from listenings;



 SELECT COUNT(l.user_id), 
       EXTRACT(EPOCH FROM (l.finished_at - l.started_at)) AS difference
FROM audio_cards ac
JOIN audiobooks ab ON ac.audiobook_uuid = ab.uuid
JOIN listenings l ON l.audiobook_uuid = ab.uuid
WHERE ab.title LIKE 'Coraline'
GROUP BY l.user_id, difference
HAVING EXTRACT(EPOCH FROM (l.finished_at - l.started_at)) > 1301;

#2 По каждой операционной системе и названию книги выведите количество 
пользователей, сумму прослушивания в часах, не учитывая тестовые прослушивания. 
SELECT 
    l.os_name, 
    ab.title AS book_title, 
    COUNT(DISTINCT l.user_id) AS user_count, 
    SUM(EXTRACT(EPOCH FROM (l.finished_at - l.started_at)) / 3600) AS total_listening_hours
FROM listenings l
JOIN audiobooks ab ON l.audiobook_uuid = ab.uuid
WHERE l.is_test = 0
GROUP BY l.os_name, ab.title
ORDER BY total_listening_hours DESC;

#3 Найдите книгу, которую слушает больше всего людей. 
select ab.title, count(distinct l.user_id) from audiobooks ab
join listenings l ON l.audiobook_uuid = ab.uuid
group by ab.title
order by ab.title desc
limit 1;

# 4 Найдите книгу, которую чаще всего дослушивают до конца.

select ab.title, count(EXTRACT(EPOCH FROM (l.finished_at - l.started_at))) from audiobooks ab
join listenings l ON l.audiobook_uuid = ab.uuid
where EXTRACT(EPOCH FROM (l.finished_at - l.started_at)) =ab.duration
group by ab.title
order by ab.title desc
limit 1;