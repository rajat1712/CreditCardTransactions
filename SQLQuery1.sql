select * from credit_card_transcations$

select * from credit_card_transcations$
where gender='M'

select * from credit_card_transcations$
where gender='F'

select card_type, count(*) as count
from credit_card_transcations$
group by card_type

select exp_type, count(*) as count
from credit_card_transcations$
group by exp_type

--1 write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

select * from credit_card_transcations$;

with cte1 as (
select top 5 city, sum(amount) as total_spend
from credit_card_transcations$
group by city
order by total_spend desc), 
cte2 as (
select sum(amount) as total_amount_spent
from credit_card_transcations$)

select x.city, x.total_spend, (x.total_spend/x.total_amount_spent)*100 as percentage from
(
select *
from cte1 c1, cte2 c2) x

-------------------------------------------------------------------------------------------------------

--2 write a query to print highest spend month and amount spent in that month for each card type
select * from credit_card_transcations$;

with cte as (
select top 1 x.Month_Number as Month_Number, sum(x.amount) as amount_spent
from
(
select *, MONTH(transaction_date) as Month_Number
from credit_card_transcations$) x
group by x.Month_Number
order by amount_spent desc)

select card_type, sum(amount) as total_spend
from credit_card_transcations$
where MONTH(transaction_date)=(select cte.Month_Number from cte)
group by card_type

---------------------------------------------------------------------------------------------

--3 write a query to find city which had lowest percentage spend for gold card type

select * from credit_card_transcations$;

with cte1 as (
select city, sum(amount) as total_spend_gold
from credit_card_transcations$
where card_type='Gold'
group by city),

cte2 as (
select SUM(amount) as total_amount
from credit_card_transcations$
where card_type='Gold')


select top 1 x.city, x.total_spend_gold, x.total_amount, 
(x.total_spend_gold/x.total_amount)*100 as percentage_spending
from
(
select *
from cte1, cte2) x
order by percentage_spending asc

----------------------------------------------------------------------------------------------

--4 write a query to find percentage contribution of spends by females for each expense type

select * from credit_card_transcations$;

with cte1 as 
(select * 
from 
credit_card_transcations$
where gender='F'),

cte2 as (
 select sum(amount) as total_female_spending
 from credit_card_transcations$
),

cte3 as (
select exp_type, sum(amount) as female_spending
from cte1
group by exp_type)

select x.exp_type, x.female_spending, x.total_female_spending,
(x.female_spending/x.total_female_spending)*100 as percentage
from
(
select *
from cte3, cte2) x

-------------------------------------------------------------------------------------------------

--5 during weekends which city has highest total spend to total no of transcations ratio 

select * from credit_card_transcations$;

WITH cte1 AS (
select *, DATEPART(weekday, transaction_date) as date_func
from credit_card_transcations$
where 
(DATEPART(weekday, transaction_date)=1 OR DATEPART(weekday, transaction_date)=7)
),
cte2 as (
select city, sum(amount) as total_spend
from cte1
group by city),
cte3 as (
select count(1) as countN from credit_card_transcations$
)

select top 1 x.*, (x.total_spend/x.countN) as ratio
from
(
select *
from cte2, cte3)  x
order by ratio desc













