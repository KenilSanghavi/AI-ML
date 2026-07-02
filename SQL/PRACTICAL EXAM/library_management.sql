create table authors(
author_id int primary key,
name varchar(30),
    email varchar(40)
);  

create table books(
bookid int primary key,
title  varchar(30),
author_id int references authors(author_id),
category varchar(20),
isbn int,
published_date date,
price float,
available_copies int
);
 
 
create table transactions(
transaction_id int primary key,
member_id int references members(member_id),
book_id int references books(book_id),
borrow_date date,
return_date date,
fine_amount float
);
 
create table members(
member_id int primary key,
name varchar(30),
email varchar(30),
phone_number varchar(10),
membership_date date
); 

insert into authors values(6,'rahul shah','rahul@gmail.com');

insert into books values(106,'java programming',6,'science',123456,'2024-01-10',450,8);

insert into members values(6,'amit patel','amit@gmail.com','9876543210','2024-05-01');

update books set available_copies=available_copies-1 where bookid=101;

update books set available_copies=available_copies+1 where bookid=101;

delete from members where member_id not in(select member_id from transactions where borrow_date>=date_sub(curdate(),interval 1 year));

select * from books where available_copies>0;

select * from books where year(published_date)>2015;

select * from books order by price desc limit 5;

select * from members where year(membership_date)<2022;

select * from books where category='science' and price<500;

select * from books where not available_copies>0;

select * from members where year(membership_date)>2020 or member_id in(select member_id from transactions group by member_id having count(book_id)>3);

select * from books order by title;

select member_id,count(book_id) as total_books from transactions group by member_id;

select category,count(*) as total_books from books group by category;

select category,count(*) as total_books from books group by category;

select avg(price) as average_price from books;

select book_id,count(*) as total_borrowed from transactions group by book_id order by total_borrowed desc limit 1;

select sum(fine_amount) as total_fines from transactions;

select books.title,authors.name from books inner join authors on books.author_id=authors.author_id;

select members.*,transactions.* from members inner join transactions on members.member_id=transactions.member_id;

select books.title,authors.name from books inner join authors on books.author_id=authors.author_id;

select members.*,transactions.* from members left join transactions on members.member_id=transactions.member_id;

select books.*,transactions.* from transactions right join books on transactions.book_id=books.bookid where transactions.book_id is null;

select members.*,transactions.* from members left join transactions on members.member_id=transactions.member_id union select members.*,transactions.* from members right join transactions on members.member_id=transactions.member_id where members.member_id is null;

select * from books where bookid in(select book_id from transactions where member_id in(select member_id from members where year(membership_date)>2022));

select * from books where bookid=(select book_id from transactions group by book_id order by count(*) desc limit 1);

select * from members where member_id not in(select member_id from transactions);

select year(published_date) as publication_year,count(*) as total_books from books group by year(published_date);

select transaction_id,datediff(return_date,borrow_date) as late_days from transactions;

select transaction_id,date_format(borrow_date,'%d-%m-%Y') as formatted_date from transactions;

select upper(title) from books;

select trim(name) from authors;

select ifnull(email,'not provided') from authors;

select book_id,count(*) as total_borrowed,rank() over(order by count(*) desc) as ranking from transactions group by book_id;

select member_id,borrow_date,count(*) over(partition by member_id order by borrow_date) as cumulative_books from transactions;

select member_id,name,case when member_id in(select member_id from transactions where borrow_date>=date_sub(curdate(),interval 6 month)) then 'active' else 'inactive' end as membership_status from members;

select title,case when year(published_date)>2020 then 'new arrival' when year(published_date)<2000 then 'classic' else 'regular' end as category_status from books;