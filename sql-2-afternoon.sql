-- PRACTICE JOINS

SELECT unit_price FROM invoice_line WHERE unit_price > 0.99

SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total FROM invoice 
INNER JOIN customer ON invoice.customer_id = customer.customer_id

SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name FROM customer
INNER JOIN employee ON customer.support_rep_id
= employee.employee_id


SELECT album.title, artist.name FROM album 
INNER JOIN artist ON album.artist_id = artist.artist_id

SELECT playlist_track.track_id FROM playlist_track
INNER JOIN playlist ON playlist.playlist_id = playlist_track.playlist_id
WHERE playlist.name = 'Music'

SELECT track.name FROM track
INNER JOIN playlist_track ON playlist_track.track_id = track.track_id
WHERE playlist_track.playlist_id = 5

SELECT track.name, playlist.name FROM track
INNER JOIN playlist_track ON track.track_id = playlist_track.track_id
INNER JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id

 SELECT track.name, album.title FROM track
INNER JOIN album ON track.album_id = album.album_id
INNER JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Alternative & Punk'

-- PRACTICE NESTED QUERIES 

SELECT unit_price FROM invoice_line WHERE unit_price > 0.99

SELECT * FROM playlist_track 
WHERE playlist_id IN(SELECT playlist_id FROM playlist WHERE name = 'Music')

SELECT * FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5)

SELECT * FROM track 
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name ='Comedy') 

SELECT * FROM track 
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball')

SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE artist_id IN 
 (SELECT artist_id FROM artist WHERE name = 'Queen'))


-- PRACTICE UPDATING ROWS

UPDATE customer
SET fax = null 
WHERE fax IS NOT NULL


UPDATE customer 
SET company = 'Self'
WHERE company IS NULL

UPDATE customer 
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett'

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track 
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS NULL

-- GROUP BY

SELECT count(*), genre.name FROM track
INNER JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name

SELECT count(*), genre.name
FROM track 
INNER JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Pop' OR genre.name = 'Rock'
GROUP BY genre.name

SELECT artist.name, count(*)
FROM album
INNER JOIN artist ON artist.artist_id = album.artist_id
GROUP BY artist.name

-- DELETE ROWS

DELETE FROM practice_delete 
WHERE type = 'bronze';

DELETE FROM practice_delete 
WHERE type = 'silver';

DELETE FROM practice_delete 
WHERE value = 150

-- eCommerce Simulation

 CREATE TABLE users (id serial PRIMARY KEY,
                    name VARCHAR(255),
                    email VARCHAR(255))

 CREATE TABLE products(id serial PRIMARY KEY,
                      name VARCHAR(255),
                      price INTEGER)
CREATE TABLE orders (id serial PRIMARY KEY,
                    name VARCHAR(100),
                     price INTEGER,
					 total INTEGER,
                     FOREIGN KEY (id) REFERENCES products(id));


 INSERT INTO users (name, email) 
 VALUES
 ('mark', 'mark123@gmail.com'),
 ('stevie', 'stevie456@hotmail.com'),
 ('Carlos', 'carlos909@gmail.com')
 INSERT INTO products(name,price) 
 VALUES
 ('tv', 400),
 ('radio', 40),
 ('phone', 500);
 
 INSERT INTO orders (id, name, price, total) 
 VALUES
 (1,'tv',400, 400),
 (2,'radio',40, 40),
 (3,'phone', 500,500);

 
 SELECT *
 FROM orders;

 SELECT * FROM products
 WHERE id = 1;

 SELECT * FROM orders
 WHERE users.id = 1;

 SELECT SUM(total)
 FROM orders
 WHERE users.id = 2


 SELECT COUNT(*) FROM orders
 where users.id = 3;