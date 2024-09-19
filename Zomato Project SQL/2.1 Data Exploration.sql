select * from Zomato_Portfolio_Project..sales;
select * from Zomato_Portfolio_Project..product;
select * from Zomato_Portfolio_Project..goldusers_signup;
select * from Zomato_Portfolio_Project..users;

6. Which item was first purchased by customer after they become a gold member

select * from 
(select *,rank() over(partition by userid order by created_date) as rank_no from 
(select sales.userid,created_date,gold_signup_date,product_id
from Zomato_Portfolio_Project..sales
inner join Zomato_Portfolio_Project..goldusers_signup 
	on sales.userid = goldusers_signup.userid
and created_date>gold_signup_date)a )b where rank_no = 1

7. Which item was purchased just before the customer become a gold member

select * from
(select *,rank() over(partition by userid order by created_date desc) as rank_no from
(select sales.userid,created_date,gold_signup_date,product_id
from Zomato_Portfolio_Project..sales
inner join Zomato_Portfolio_Project..goldusers_signup 
	on sales.userid = goldusers_signup.userid
and created_date<=gold_signup_date)a)b where rank_no=1

8. What is the total orders and amount for each memeber before they become a member

select sales.userid,sum(price) as total_amt,count(created_date) as total_orders
from Zomato_Portfolio_Project..sales
inner join Zomato_Portfolio_Project..goldusers_signup 
	on sales.userid = goldusers_signup.userid
inner join Zomato_Portfolio_Project..product
	on sales.product_id= product.product_id
and created_date<=gold_signup_date
group by sales.userid

9. If buying each product generates points for eg 5rs=2 zomato point and each product has different purchasing points 
for eg for p1 5rs=1 zomato point ,for p2 10rs=5 zomato points and p3 5rs=1zomato point

,calculate points collected by each customers and for which product most points have been given till now 

select userid,sum(zomato_points)*2.5 as total_money_earned from
(select c.*,sum_of_product/points as zomato_points from 
(select b.*,
case when product_id = 1 then 5
when product_id = 2 then 2
when product_id = 3 then 5
else 0 end as points from
(select a.userid,a.product_id,sum(price) as sum_of_product from
(select userid,created_date,sales.product_id,price
from Zomato_Portfolio_Project..sales
inner join Zomato_Portfolio_Project..product	
	on sales.product_id = product.product_id)a
group by a.userid,a.product_id)b)c)d
group by userid

select product_id,sum(zomato_points) as total_points_earned from
(select c.*,sum_of_product/points as zomato_points from 
(select b.*,
case when product_id = 1 then 5
when product_id = 2 then 2
when product_id = 3 then 5
else 0 end as points from
(select a.userid,a.product_id,sum(price) as sum_of_product from
(select userid,created_date,sales.product_id,price
from Zomato_Portfolio_Project..sales
inner join Zomato_Portfolio_Project..product	
	on sales.product_id = product.product_id)a
group by a.userid,a.product_id)b)c)d
group by product_id

10. In the first one year after customer joins the gold program (including their joint date) irrespective 
of what the customer has purchased they earn 5 zomato points for every 10rs spend who earned more 1 or 3 
and what was their points earning in their first year
(1 zomato pts = 2rs
0.5 zomato pts = 1rs)

select * from Zomato_Portfolio_Project..sales;
select * from Zomato_Portfolio_Project..goldusers_signup;

select sales.userid,created_date,gold_signup_date,sales.product_id,price,price*0.5 as zomato_pts
from Zomato_Portfolio_Project..sales
inner join Zomato_Portfolio_Project..goldusers_signup
	on sales.userid=goldusers_signup.userid
inner join Zomato_Portfolio_Project..product	
	on sales.product_id = product.product_id
where created_date>=gold_signup_date
and created_date<=DATEADD(year,1,gold_signup_date)
order by 1,2

11. rnk all the transaction of the customer

select *,rank() over(partition by userid order by created_date)
from Zomato_Portfolio_Project..sales

12. rnk all the transactions for each member whenever they are a zomato gold member for every non gold member transaction mark as na

select b.*,case when rnk=0 then 'na' else rnk end as rnkk from 
(select a.*,cast((case when gold_signup_date is null then 0 else rank() over (partition by userid order by created_date desc) end)as varchar) as rnk from
(select sales.userid,created_date,gold_signup_date,product_id
from Zomato_Portfolio_Project..sales
left join Zomato_Portfolio_Project..goldusers_signup
	on sales.userid=goldusers_signup.userid
and created_date>=gold_signup_date)a)b
