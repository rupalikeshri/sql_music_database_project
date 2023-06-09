
/* Q1: Who is the senior most employee based on job title? */

select top 1 * from employee_records 
order by levels desc;

/*Q2: Which countries have the most invoices? */

select count(*) as c,billing_country from invoice 
group by  billing_country
order by c desc;

/*Q3: Which are top 3 values of the invoice? */

select top 3 total from invoice
order by total desc;

/* Q4: Which city has the best customers? We would like to throw a promotional Music  Festival in the city we made the most money.
Write a query that  returns one city that has the highest sum of invoice totals.Return both the city name and sum of all invoice totals. */

select top 1 sum(total) as invoice_total,billing_total,billing_city from invoice
group by billing_city 
order by invoice_total disc;
 
/* Q5: Who  is the best customer? The customer who has spent the most money will be declared the best customer. Write query that 
returns the person who has spent the most money? */

select top 1 sum(invoice.total) as total,customer.customer_id,customer.first_name,customer.last_name from customer
inner join invoice 
on customer.customer_id=invoice.customer_id 
group by customer.customer_id,customer.first_name,customer.last_name
order by total desc;

/* Q6: Write query o return the email, first name, last name and genre of all rock music listeners. Return your list ordered 
alphabetically by email starting with A? */

select distinct email,first_name,last_name from customer
inner join invoice on customer.customer_id=invoice.customer_id
inner join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in(
select track_id from track 
join genre on track.genre_id=genre.genre_id
 where genre.name like 'rock')
 order by email;

/* Q7: Let's invite the artist who have written the most rok music in our dataset. Write a query the Artist name and total track
count of the top  10 rock bands. */

select top 10 count(artist.artist_id) as number_of_songs,artist.artist_id,artist.name from track
join albumrecords on albumrecords.album_id=track.album_id
join artist on artist.artist_id=albumrecords.artist_id
join genre on genre.genre_id=track.genre_id
group by artist.artist_id,artist.name
order by number_of_songs desc;

/* Q8: Return all the  track names that have a song length longer than the average song length. Return the Name and Milliseconds for
each track. Order by the song length with th longest songs listed fisrt.*/

select name,milliseconds from track
where milliseconds>(select avg(milliseconds) as avg_track_length
                      from track)
					   order by milliseconds desc;
