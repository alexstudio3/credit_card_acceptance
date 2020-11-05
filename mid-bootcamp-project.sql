# 1. Create a database called `credit_card_classification`.

# 2. Create a table `credit_card_data` with the same columns as given in the csv file. Please make sure you use the correct data types for each of the columns.
create table credit_card_data_2 (
		customer_number int,
        offer_accepted varchar(45),
        reward varchar(45),
        mailer_type varchar(45),
        income_level varchar(45),
        bank_accounts_open int,
        overdraft_protection varchar(45),
        credit_rating varchar(45),
        credit_cards_held int,
        homes_owned int,
        household_size int,
        own_your_home varchar(45),
        balance float,
        average_balance_q1 int,
        average_balance_q2 int,
        average_balance_q3 int,
        average_balance_q4 int,
        PRIMARY KEY (customer_number)
        );

# 3. Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. To not modify the original data, if you want you can create a copy of the csv file as well. Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:
# Done

# 4.  Select all the data from table `credit_card_data` to check if the data was imported correctly.
SELECT count(*) FROM credit_card_classification.credit_card_data_2;

# 5.  Use the _alter table_ command to drop the column `q4_balance` from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
-- ALTER TABLE credit_card_data_2
-- DROP COLUMN average_balance_q4;

select * from credit_card_data2;
# 6.  Use sql query to find how many rows of data you have.
SELECT count(*) FROM credit_card_classification.credit_card_data_2;

#7.  Now we will try to find the unique values in some of the categorical columns:
 #   - What are the unique values in the column `Offer_accepted`?
 select distinct(offer_accepted) from credit_card_data_2;
 #   - What are the unique values in the column `Reward`?
  select distinct(reward) from credit_card_data_2;
 #   - What are the unique values in the column `mailer_type`?
  select distinct(mailer_type) from credit_card_data_2;
 #   - What are the unique values in the column `credit_cards_held`?
  select distinct(credit_cards_held) from credit_card_data_2;
 #   - What are the unique values in the column `household_size`?
  select distinct(household_size) from credit_card_data_2;

#8.  Arrange the data in a decreasing order by the `average_balance` of the house. Return only the `customer_number` of the top 10 customers with the highest `average_balances` in your data.
select * from credit_card_data_2
order by balance DESC
limit 10;

#9.  What is the average balance of all the customers in your data?
select format(avg(balance),2) from credit_card_data_2;

#10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data. Note wherever `average_balance` is asked, please take the average of the column `average_balance`: <!-- 🚨🚨🚨 @himanshu - can we rephrase this? -->
#    - What is the average balance of the customers grouped by `Income Level`? The returned result should have only two columns, income level and `Average balance` of the customers. Use an alias to change the name of the second column.
select income_level, format(avg(balance),2) from credit_card_data_2
group by income_level;
#    - What is the average balance of the customers grouped by `number_of_bank_accounts_open`? The returned result should have only two columns, `number_of_bank_accounts_open` and `Average balance` of the customers. Use an alias to change the name of the second column.
select bank_accounts_open, format(avg(balance),2) from credit_card_data_2
group by bank_accounts_open;
#    - What is the average number of credit cards held by customers for each of the credit card ratings? The returned result should have only two columns, rating and average number of credit cards held. Use an alias to change the name of the second column.
select credit_rating, format(avg(credit_cards_held),2) as number_of_cc from credit_card_data_2
group by credit_rating;
#    - Is there any correlation between the columns `credit_cards_held` and `number_of_bank_accounts_open`? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select credit_cards_held, sum(bank_accounts_open) from credit_card_data_2
group by credit_cards_held
order by credit_cards_held;
select bank_accounts_open, sum(credit_cards_held) from credit_card_data_2
group by bank_accounts_open
order by bank_accounts_open;

#11. Your managers are only interested in the customers with the following properties:
#    - Credit rating medium or high
#    - Credit cards held 2 or less
#    - Owns their own home
#    - Household size 3 or more
#    For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them? Can you filter the customers who accepted the offers here?
select * from credit_card_data_2
where credit_rating in ('medium','high') and credit_cards_held <=2 and own_your_home = 'Yes' and household_size >=3 and offer_accepted = 'Yes';
select count(*) from credit_card_data_2
where credit_rating in ('medium','high') and credit_cards_held <=2 and own_your_home = 'Yes' and household_size >=3 and offer_accepted = 'Yes';

# 12. Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. 
# Write a query to show them the list of such customers. You might need to use a subquery for this problem.
select avg(balance) from credit_card_data_2;
select customer_number, balance from credit_card_data_2
where balance < (select avg(balance) from credit_card_data_2);

# 13. Since this is something that the senior management is regularly interested in, create a view of the same query.
Create view customers_with_higher_avg_balance as 
	(select customer_number, balance from credit_card_data_2
	where balance < (select avg(balance) from credit_card_data_2)
    );
 select * from customers_with_higher_avg_balance;   

# 14. What is the number of people who accepted the offer vs number of people who did not?
select offer_accepted, count(customer_number) from credit_card_data_2
group by offer_accepted;

# 15. Your managers are more interested in customers with a credit rating of high or medium. What is the difference in average balances of the customers with high credit card rating and low credit card rating?
select customer_number, credit_rating from credit_card_data_2
where credit_rating in ('high','medium');

select credit_rating, avg(balance) as avg_bal_high  from credit_card_data_2
where credit_rating in ('high');
select credit_rating, avg(balance) as avg_bal_low from credit_card_data_2
where credit_rating in ('low');

select format((avg_bal_high - avg_bal_low),2) as diff_avg_bal_high_low from 
	(select credit_rating, avg(balance) as avg_bal_high from credit_card_data_2
	where credit_rating in ('high')) as high,
	(select credit_rating, avg(balance) as avg_bal_low from credit_card_data_2
	where credit_rating in ('low')) as low;

# 16. In the database, which all types of communication (`mailer_type`) were used and with how many customers?
select mailer_type, count(customer_number) from credit_card_data_2
group by mailer_type;

# 17. Provide the details of the customer that is the 11th least `Q1_balance` in your database.
select customer_number, average_balance_q1 from credit_card_data_2
order by average_balance_q1 ASC
Limit 11; 

select customer_number, average_balance_q1, ROW_NUMBER() OVER (ORDER BY average_balance_q1 ASC) AS int_row from credit_card_data_2;

select customer_number from (
		select customer_number, average_balance_q1, ROW_NUMBER() OVER (ORDER BY average_balance_q1 ASC) AS int_row from credit_card_data_2
        ) as sub1
where int_row ='11';

