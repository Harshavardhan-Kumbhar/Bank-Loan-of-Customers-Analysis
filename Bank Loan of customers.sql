create database Bank_Analytics ;

use bank_analytics;

# ALL KPIS : - 

# Year wise loan amount Stats 
  
SELECT year(issue_d) AS Year_of_issue_date, concat("$",format(round(sum(loan_amnt)/100000,2),2),"M") AS Total_loan_amount FROM finance_1 
GROUP BY Year_of_issue_date
ORDER BY Year_of_issue_date;

# Grade and sub grade wise revol_bal

select grade , sub_grade , concat("$",format(sum(revol_bal)/1000000,2),"M") as revol_balance from finance_1 f1 join
finance_2 f2 on f1.id = f2.id 
group by grade,sub_grade
order by grade,sub_grade; 

# Total Payment for Verified Status Vs Total Payment for Non Verified Status

select verification_status status , concat("$",round(sum(total_pymnt)/1000000,2),"M") as Total_payment from finance_1 f1 join
finance_2 f2 on f1.id = f2.id
group by verification_status;

# State wise and last_credit_pull_d wise loan status

select addr_state as State , sum(last_credit_pull_d) as Last_credit_pull_date
from finance_1 f1 join finance_2 f2 on f1.id = f2.id
group by addr_state
order by Last_credit_pull_date desc;

# Home ownership Vs last payment date stats

select home_ownership, sum(last_pymnt_d) as Last_payment_date
from finance_1 f1 join finance_2 f2 on f1.id = f2.id
group by home_ownership
order by Last_payment_date desc;
