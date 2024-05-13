/*
-- Data importing

	-- Converted finance_2 from xls to csv file

-- Not able to import all data in starting

-- Data cleaning
	-- Converted dates format into "YYYY-MM-DD" format
    -- Normal number formats (Removing currency, accounting formats)
    -- removed 1000 seperator ( Ex. 12,578 --> 12578)
    -- Round to two decimal points (45.69874 --> 45.67)
    -- Removed unwanted columns ( Ex. Description)

-- All data imported succesfully

*/

create database Bank_Analytics ;

use bank_analytics;

# Total no. of loan

select count(id) as Total_no_of_loan from finance_1;

# Total loan amount

select concat('$',round(sum(loan_amnt)/1000000,2),'M') as Total_loan_amount from finance_1;

# Cumulative interest rate

select concat(round(avg(int_rate)*100,2),'%') as cumulative_int_rate from finance_1;

# ALL KPIS : - 

# Year wise loan amount Stats 
SELECT year(issue_d) AS Year_of_issue_date, concat("$",format(round(sum(loan_amnt)/100000,2),2),"M") AS Total_loan_amount 
FROM finance_1 
GROUP BY Year_of_issue_date
ORDER BY Year_of_issue_date;

# Grade and sub grade wise revol_bal

select grade , sub_grade , concat("$",format(sum(revol_bal)/1000000,2),"M") as revol_balance 
from finance_1 f1 join finance_2 f2 on f1.id = f2.id 
group by grade,sub_grade
order by grade,sub_grade; 

# Total Payment for Verified Status Vs Total Payment for Non Verified Status

select 
	case 
		when verification_status = 'verified' then 'Verified'
        when verification_status = 'source verified' then 'Verified' 
        else verification_status
	end as Total_Verification_status, concat("$",round(sum(total_pymnt)/1000000,2),"M") as Total_payment 
from finance_1 f1 join finance_2 f2 on f1.id = f2.id
group by Total_Verification_status;

# State wise and last_credit_pull_d wise loan status

select addr_state as State , count(last_credit_pull_d) as Count_last_credit_pull_date
from finance_1 f1 join finance_2 f2 on f1.id = f2.id
group by addr_state
order by Count_last_credit_pull_date desc;

# Home ownership Vs last payment date stats

select home_ownership, count(last_pymnt_d) as  Count_Last_payment_date
from finance_1 f1 join finance_2 f2 on f1.id = f2.id
group by home_ownership
order by Count_Last_payment_date desc;

