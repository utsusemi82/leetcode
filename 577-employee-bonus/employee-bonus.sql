# Write your MySQL query statement below
select emp.name, bonus.bonus from employee emp left join bonus 
on emp.empid = bonus.empid 
where bonus<1000 or bonus is null;