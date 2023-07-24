-- Capstone Project
USE Sakila;

-- TASK1:Display the full names of the actors available in the database.
SELECT CONCAT(first_name,'  ',last_name) AS FullName_of_the_Actors FROM actor;

-- TASK2(i): Display the number of times each first name appears in the database. 
SELECT first_name AS FirstName_of_actor,count(first_name) AS RepeatedCount_FirstNames FROM actor GROUP BY first_name order by RepeatedCount_FirstNames desc;

-- TASK2(ii): What is the count of actors that have unique first name I the database? Display the first name of all these actors.
SELECT COUNT(DISTINCT first_name) AS 'Count of Unique FirstName' from actor;
SELECT DISTINCT first_name from actor;

-- TASK3(i):Display the number of times each last name appears in the database. 
SELECT last_name AS LastName_of_actor,count(last_name) AS RepeatedCount_LastNames FROM actor GROUP BY last_name;

-- TASK3(ii): Display the last name of all these actors.
SELECT DISTINCT last_name from actor;

-- TASK4(i): Display the list of records for the movies with the rating ‘R’
SELECT film_id,title,rating FROM film WHERE rating='R';

-- Task4(ii):Display the list of records for the movies that are not rated ‘R’
SELECT film_id,title,rating FROM film WHERE NOT rating='R';

-- Task4(iii): Display the list of records for the movies that are suitable for audience below 13 years of age.
SELECT film_id,title,rating FROM film WHERE rating!='R' AND rating!='NC-17';

-- Task5(i):Display the list of records for the movies where the replacement cost is upto $11.
SELECT title AS Film_Name,replacement_cost AS ReplacementCost_Upto_10 FROM film where replacement_cost<=11;

-- Task5(ii): Display the list of records for the movies where the replacement cost is between $11 and $20.
SELECT title AS Film_Name,replacement_cost AS ReplacementCost_Between11_20 FROM film WHERE replacement_cost Between 11 and 20;

-- Task5(iii): Display the list of records for all the movies in decending order of their replacement costs.
SELECT title AS Film_Name,replacement_cost AS Replacementcost_in_desc FROM film ORDER BY replacement_cost desc;

-- Task6: Display the names of the top 3 movies with the greatest number of actors.
SELECT title as Film_Name,count(a.actor_id) AS Count_of_actors FROM film as f 
join film_actor as fa ON f.film_id=fa.film_id 
join actor as a on fa.actor_id=a.actor_id
group by title order by Count_of_actors DESC LIMIt 3;

-- TASK7: Display the titles of movies starting with the letters ‘K’ and ‘Q’.
SELECT title as Film_Name from film where title Like'k%' or title Like 'Q%';

-- Task8: Display the names of all actors where the movie name is ‘Agent Truman’
SELECT title as Film_Name,Concat(first_name,'  ',last_name)AS FullName from film as f 
join film_actor as fa ON f.film_id=fa.film_id 
join actor as a on fa.actor_id=a.actor_id where title='AGENT TRUMAN';

-- Task9: Identify all the movies categorized as family films.
SELECT f.title as Film_Name,c.name as Category_name from film as f 
join film_category as fc ON f.film_id=fc.film_id 
join category as c on fc.category_id = c.category_id where c.name='family';

-- Task10(i): Display the  maximum, minimum and average rental rates of movies based on their ratings.The output must be in descending order of the average rental rates.
select rating,max(rental_rate) as Maximum,min(rental_rate) as Minimum,avg(rental_rate) as Average from film group by rating order by Average desc;

-- Task10(ii): Display the movie in descending order  of their rental  frequencies, so the management can maintain more copies of those movies
select title,count(rental_id) as Rental_Frequency from film as f join inventory as i on
f.film_id =i.film_id join rental as r
on r.inventory_id = i.inventory_id group by f.title order by count(rental_id) desc;

-- Task11: In how many film categories, the difference between the average film replacement cost ((disc-  DVD/Blue Ray) and film rental rate is greater than $15.
select c.name as Category_name,count(f.title) as Count_of_movies,avg(replacement_cost)-avg(rental_rate) as Cost_Difference from category as c 
join film_category as fc ON c.category_id=fc.category_id 
join film as f ON fc.film_id=f.film_id group by c.name having Cost_Difference>15 order by Count_of_movies desc;

-- Task12: Display the list of all film categories identified above ,along  with the corresponding average film replacement cost and average film rental rate.
select c.name as Category_name,count(title) as Count_of_FilmName from category as c
join film_category as fc ON c.category_id=fc.category_id 
join film as f ON fc.film_id=f.film_id group by c.name having count(title)>70;