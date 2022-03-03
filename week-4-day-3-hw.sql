
--1. List all customers who live in Texas (use JOINs)
--Ans:
--6 Jennifer Davis
--118 Kim Cruz
--305 Richard Mccrary
--400 Bryan Hardison
--561 Ian Still
SELECT district, customer_id,first_name,last_name, address.address_id
FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name
-- Ans: see below
SELECT first_name,last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;


--3. Show all customers names who have made payments over $175(use subqueries)
--Ans:
--Mary Smith
--Elizabeth Brown
--Jennifer Davis
--Rhonda Kennedy
--Clara Shaw
--Eleanor Hunt
--Marion Snyder
--Peter Menard
--Harold Martino
--Tommy Collazo
--Karl Seal
SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment 
	GROUP BY customer_id 
	HAVING sum(amount) > 175
	ORDER BY sum(amount) DESC
);

--4. List all customers that live in Nepal (use the city table)
-- Ans: Kevin Schuler
SELECT first_name, last_name 
FROM customer
WHERE address_id IN (
	SELECT address_id 
	FROM address 
	WHERE city_id IN (
		SELECT city_id
		FROM city 
		WHERE country_id = 66));


--5. Which staff member had the most transactions?
-- Ans: employee 2, Jon Stephens
SELECT staff_id, count(amount)
FROM payment
GROUP BY staff_id;


--6. How many movies of each rating are there?
-- Ans:
-- PG-13 - 223
-- NC-17 - 210
-- G - 178
-- PG - 194
-- R - 195
SELECT rating, count(film_id)
FROM film
GROUP BY rating;


--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name, customer_id 
FROM customer
WHERE customer_id IN ( 
	SELECT customer_id 
	FROM payment 
	GROUP BY customer_id 
	HAVING amount = 6.99);



--8. How many free rentals did our stores give away?
-- Ans: 24
SELECT count(amount)
FROM payment
WHERE amount = 0;
