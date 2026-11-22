--create books table (table 1)
Create Table Books(
Book_ID Serial PRIMARY KEY,
Title varchar(150),
Author varchar(100),
Genre varchar(100),
Published_Year int,
Price numeric(10,2),
Stock int
);

--Create Customer table (table 3)
Create Table Customer(
Customer_ID Serial PRIMARY KEY,
Name varchar(100),
Email varchar(100) UNIQUE,
Phone char(10),
City varchar(100),
Country varchar(100)
);

--Create Order table (table 2)
Create Table Orders(
Order_ID Serial PRIMARY KEY,
Customer_ID int References Customer(Customer_ID),
Book_ID int References Books(Book_ID),
Order_Date Date,
Quantity int,
Total_Amount numeric(10,2)
);


SELECT * FROM Books;
SELECT * FROM Orders;
SELECT * FROM Customer;


--Questions based on some basic queries...

--Q1.) Retrieve all books in the "fiction" genre

Select * From books
where genre='Fiction';

--Q2.) Find books published after the year 1950

Select * from books

where published_year>1950
Order by published_year asc;

--Q3.) Lists all customers from the canada

select * from customer
where country='Canada';

--Q4.) Show orders placed in November 2023

Select * from orders
Where order_date BETWEEN'2023-11-01'AND '2023-11-30'
Order by order_date asc;

--Q5.) Retrieve the total stocks of books available

Select sum(stock) as total_stocks from books;

--Q6.) Find the details of the most expensive book

Select * from books
Order by price desc
Limit 1;

--Q7.) Show all customers who ordered more than 1 quantity of a book

select * from orders
where quantity>1
Order by quantity asc;

--Q8.) Retrieve all orders where the total amount exceeds $20

Select * from orders
where total_amount>20 
Order by total_amount asc;

--Q9.) List all genres available in the books table

Select Distinct genre from books;

--Q10.) Find the book with lowest stock

Select * from books
Order by stock asc
Limit 1;

--Q11.) Calculate the total revenue generated from all orders

Select Sum(total_amount)AS Total_Revenue from orders;

--Question based on Advanced Queries.....

--Q1.) Retrieve the total number of books sold for each genre

Select b.genre, Sum(o.quantity) as total_sold_books
from books as b
INNER JOIN orders AS o
ON b.book_ID=o.book_ID
group by genre;

--Q2.) Find the average price of books in the "Fantasy" genre

Select avg(price) as average_price
from books
Where genre='Fantasy';

--Q3.) List customers who have placed at least 2 orders

Select c.customer_id,c.name,c.email,count(o.order_id)as total_orders
from customer as c
INNER JOIN orders as o
ON c.customer_id=o.customer_id
group by c.customer_id,c.name,c.email
having count(o.order_id)>=2;

--Q4.) Find the most frequently order books

Select o.book_id,b.title,count(o.order_id)as order_count
from orders as o
INNER JOIN books as b
ON o.book_id=b.book_id
group by o.book_id,b.title
order by order_count desc
LIMIT 1;

--Q5.) Show the top 3 most expensive books of 'Fantasy' Genre

Select * from books 
where genre='Fantasy'
order by price desc
Limit 3;

--Q6.) Retrieve the total quantity of books sold by each author

Select b.author,b.title,b.genre,sum(o.quantity)as total_quantity
from books as b
INNER JOIN orders as o
ON b.book_id=o.book_id 
group by b.author,b.title,b.genre
order by sum( o.quantity) desc;

--Q7.)List the cities where customers who spent over $30 are located

Select c.name,c.email,c.city,o.total_amount
from customer as c
inner join orders as o
on c.customer_id=o.customer_id
where total_amount>30;

--Q8.) Find the customer who spent the most on orders

Select c.customer_id,c.name,sum(total_amount)AS total_spent
From orders as o
INNER JOIN customer as c
ON c.customer_id=o.customer_id
group by c.customer_id,c.name
order by total_spent desc
LIMIT 1;

--Q9.) Calculate the stock remaining after fullfilling all orders

Select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0)AS order_quantity,
b.stock-coalesce(sum(o.quantity),0) as remaining_quantity
from books as b
LEFT JOIN orders as o
ON b.book_id=o.book_id
group by b. book_id
order by b.book_id;

