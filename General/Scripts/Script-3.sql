
use sakila;

-- 1. customer 테이블에서 고객의 customer_id, first_name, last_name, email을 조회하고 customer_id가 작은 순서대로 정렬하세요.

select customer_id, first_name, last_name
from customer
order by customer_id asc;

-- 2. film 테이블에서 영화의 rating별 영화 개수를 조회하고 영화 개수가 많은 순서대로 정렬하세요.

select rating, count(*) as 조회
from film
group by rating
order by 조회 desc;

-- 3. 각 영화 카테고리의 이름과 해당 카테고리에 속한 영화의 개수를 조회하고 영화 개수가 많은 순서대로 정렬하세요.

select name, count(*) as 카테고리별
from category 
	join film_category on category.category_id = film_category.category_id
	join film on film_category.film_id = film.film_id
group by name
order by 카테고리별 desc;

-- 4. 각 고객의 customer_id, 이름, 성, 총 결제금액을 조회하고 총 결제금액이 높은 고객부터 정렬하되, 총 결제금액이 같은 경우 customer_id가 작은 순서대로 정렬하여 상위 10명만 출력하세요.

select c.customer_id, c.first_name, c.last_name, sum(amount) as 총금액
from customer as c
	join payment on c.customer_id = payment.customer_id
group by customer_id
order by 총금액 desc, customer_id asc
limit 10;


-- 5. rental_date를 기준으로 2005년 7월에 대여된 영화의 제목과 rental_date를 조회하고 같은 영화가 여러번 대여된 경우 각각 출력하세요.

select title as 제목, rental_date
from rental
	join inventory on rental.inventory_id = inventory.inventory_id
	join film on film.film_id = inventory.film_id
where month(rental.rental_date) = 7;

-- 6. 각 배우의 이름과 출연한 영화 개수를 조회하되 출연 영화가 30편 이상인 배우만 출력하고 출연 영화 수가 많은 순서대로 정렬하세요.

select last_name, count(film_actor.film_id) as 출연횟수
from actor
	join film_actor on actor.actor_id = film_actor.actor_id
group by last_name
having 출연횟수 >= 30
order by 출연횟수 desc;

-- 7. category, film_category, inventory, rental 테이블을 이용하여 카테고리별 총 대여 횟수를 조회하고, 총 대여 횟수가 1,000회 이상인 카테고리만 대여 횟수가 많은 순서대로 출력하세요.

select category.name, count(rental.inventory_id) 대여횟수
from category
	join film_category on category.category_id = film_category.category_id
	join inventory on inventory.film_id = film_category.film_id
	join rental on rental.inventory_id = inventory.inventory_id
group by category.name
having 대여횟수 >= 1000
order by 대여횟수 desc;


-- 8. 고객별 총 결제금액을 구한 뒤 전체 고객의 평균 총 결제금액보다 많은 금액을 결제한 고객의 이름과 총 결제금액을 조회하고 총 결제금액이 높은 순서대로 정렬하세요.

select customer.last_name as 이름, sum(amount) as 총결제
from customer
	join payment on customer.customer_id = payment.customer_id
group by last_name
having 총결제 >= (
	select sum(amount) / count(distinct customer_id)
	from payment
)
order by 총결제 desc;

-- 9. actor, file_actor, film_category, category 테이블을 이용하여 Action카테고리와 Comedy카테고리의 영화에 모두 출연한 배우의 actor_id, first_name, last_name을 조회하고 actor_id가 작은 순서대로 정렬하세요.

select distinct actor.actor_id, actor.first_name, actor.last_name
from actor
	join film_actor on actor.actor_id = film_actor.actor_id
	join film_category on film_actor.film_id = film_category.film_id
	join category on film_category.category_id = category.category_id
where category.name in ("Action","Comedy")
order by actor_id;

-- 10. file 테이블에서 각 영화등급(rating)별 평균 대여료(rental_rate)를 구하고, 자신이 속한 등급의 평균 대여료보다 대여료가 높은 영화의 제목, 등급, 대여료를 조회하여 대여료가 높은 순서대로 출력하세요.
with avg_table as (
	select rating, avg(rental_rate) as avg_rate
	from film
	group by rating
)
select film.title, film.rating, film.rental_rate, avg_rate as 평균대여료
from film
	join avg_table on avg_table.rating = film.rating
where film.rental_rate > avg_rate
order by film.rental_rate desc;

 



















