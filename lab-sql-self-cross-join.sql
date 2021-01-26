-- # Lab | SQL Self and cross join

-- In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

-- 1. Get all pairs of actors that worked together.
select
    a1.actor_id,
	a2.actor_id
from sakila.film_actor a1
join sakila.film_actor a2          
on a1.film_id = a2.film_id
and a1.actor_id <> a2.actor_id
where a2.actor_id > a1.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
select
	t1.customer_id as customer_id1,
	t2.customer_id as customer_id2,
	count(*) as coincidences
from
(select rt.customer_id, inv.film_id from sakila.rental as rt join sakila.inventory as inv using (inventory_id)) as t1
join
(select	rt.customer_id, inv.film_id from sakila.rental as rt join sakila.inventory as inv using (inventory_id)) as t2
on t1.film_id = t2.film_id
and t1.customer_id != t2.customer_id
and t1.customer_id > t2.customer_id
group by t1.customer_id, t2.customer_id
having coincidences > 3
order by coincidences desc
;

-- 3. Get all possible pairs of actors and films.
select * from(
	select distinct concat(first_name,' ',last_name) as actor from sakila.actor
) sub1
cross join (
	select distinct title from sakila.film
) sub2;
