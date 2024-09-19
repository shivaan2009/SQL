select * from Zomato_Portfolio_Project..sales;
select * from Zomato_Portfolio_Project..product;
select * from Zomato_Portfolio_Project..goldusers_signup;
select * from Zomato_Portfolio_Project..users;

1. what is the total amount each customer spent on zomato

select userid,sum(price) as total_amt_customer_spent
from Zomato_Portfolio_Project..sales
left join Zomato_Portfolio_Project..product
	on sales.product_id = product.product_id
group by userid

2. How many days has each customer visited zomato
select userid,count(distinct created_date) as customer_visit_count
from Zomato_Portfolio_Project..sales
group by userid;

3. What was the first product purchased by each customer
select * from
(select userid,product_name,rank() over (partition by userid order by created_date) as rank_no
from Zomato_Portfolio_Project..sales
left join Zomato_Portfolio_Project..product
	on sales.product_id = product.product_id) a where rank_no = 1

4. What is the most purcahsed item on the menu and how many times was it purchased by all the customers

select userid,count(product_id) as count_product from Zomato_Portfolio_Project..sales 
where product_id = 
(select top 1 product_id
from Zomato_Portfolio_Project..sales
group by product_id
order by count(product_id) desc)
group by userid

5. Which item was the most popular for each customer
select * from 
(select *, rank() over(partition by userid order by cnt desc) as rnk from
(select userid,product_id,count(product_id) as cnt
from Zomato_Portfolio_Project..sales
group by userid,product_id)a)b where rnk = 1
