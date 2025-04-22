Create database Books_Analysis;
show tables;
drop table orders;
Select * from books;
Select * from customers;
Select * from orders;
#####################------------------------#################

# Retrieve all books in the "Fiction" genre:
Select * from books 
where Genre = 'Fiction';

# Find books published after the year 1950:
Select * from books
where Published_Year > 1950;

# List all customers from the Canada:
Select * from customers
where Country = 'Canada';

# Show orders placed in November 2023:
Select * from Orders
where Order_Date between '2023-11-01' and '2023-11-30'
order by Order_Date ASC;

# Retrieve the total stock of books available:
Select sum(Stock) as Total_Stock from books;

# Find the details of the most expensive book:
Select * from books
order by Price DESC
Limit 1;

# Show all customers who ordered more than 1 quantity of a book:
Select *  from Orders 
where Quantity > 1;

# Retrieve all orders where the total amount exceeds $20:
Select * from orders
where Total_Amount > 20;

# List all genres available in the Books table:
Select distinct(Genre) as all_genres from books;

# Find the book with the lowest stock:
Select * from books
order by Stock ASC
Limit 1;

# Calculate the total revenue generated from all orders:
Select sum(Total_Amount) as Total_Revenue from orders;

# Retrieve the total number of books sold for each genre:
Select books.Genre, sum(orders.Quantity) as Total_Book_Sold
from books inner join orders 
on books.Book_ID = orders.Book_ID
group by books.Genre;

# Find the average price of books in the "Fantasy" genre:
Select avg(Price) as Average_Price from books
Where Genre = 'Fantasy';

# List customers who have placed at least 2 orders:
Select Customers.Customer_ID, Customers.Name, count(Order_ID) as Total_Orders
from Customers join Orders
on Customers.Customer_ID = Orders.Customer_ID
Group by Customers.Customer_ID, Customers.Name
Having count(order_ID) >= 2;

# Find the most frequently ordered book:
Select count(O.Order_ID) as Order_Count, b.Title, o.book_ID
from orders o join books b 
on o.Book_ID = b.Book_ID
Group by o.book_ID, b.Title
order by Order_Count Desc
limit 1;

# Show the top 3 most expensive books of 'Fantasy' Genre:
Select * from books
Where genre = 'Fantasy'
order by Price DESC
Limit 3;

# Retrieve the total quantity of books sold by each author:
Select sum(o.Quantity) as Total_books_Sold, b.author
from books b join orders o on
b.book_ID = o.book_ID
group by b.author;

# List the cities where customers who spent over $30 are located:
Select c.Name, sum(o.Total_Amount) as total_Amount_Spent, c.city
from customers c join orders o on
c.customer_ID = o.customer_ID
Group by c.name, c.city
having sum(o.Total_Amount) > 30;

# Find the customer who spent the most on orders:
Select c.Name, c.Customer_ID, sum(o.Total_Amount) as Total_Spent
from customers c join orders o on
c.Customer_ID = o.Customer_ID
group by c.Name, c.Customer_ID
Order by Total_Spent DESC
Limit 1;

# Calculate the stock remaining after fulfilling all orders:
SELECT 
  b.book_id, 
  b.title, 
  b.stock, 
  COALESCE(SUM(o.quantity), 0) AS Order_Quantity,
  b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id;



