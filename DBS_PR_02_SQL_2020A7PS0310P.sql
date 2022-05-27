create database library;
use library;

create table student
(
student_id int auto_increment,
full_name varchar(30),
mobile_number varchar(10),
dues int(7),
constraint student_id primary key(student_id)
);

create table book
(
publisher varchar(30),
    author varchar(30),
    book_ID int auto_increment,
    title varchar(40),
   -- availability bool,
    price_per_day int(7),
    no_of_copies int(10),
    constraint book_ID primary key(book_ID)
);

create table book_status
(
stat bool,
    issue_ID int auto_increment,
    book_ID int,
    issue_date date,
    return_date date,
    -- due_date date,
    student_id int,
    constraint issue_ID primary key(issue_ID),
    constraint book_stat_sid_fk foreign key(student_id) references student(student_id),
    constraint book_stat_bid_fk foreign key(book_ID) references book(book_ID)
);


   
create table room
(
    room_ID int auto_increment,
    avail bool,
    room_name varchar(15),
    constraint room_ID primary key(room_ID)
);


create table slots
(
    student_id int,
    date_of_booking Date,
    room_ID int,
    slot_ID int auto_increment,
    constraint slot_ID primary key(slot_ID),
    constraint slots_student_id_fk foreign key(student_id) references student(student_id),
    constraint slots_room_id_fk foreign key(room_ID) references room(room_ID)
);




insert into student values('001', 'Bhavya Kalyani', '7021323971',0);
insert into student values('002', 'Mitul Chadha', '9810413685',0);
insert into student values('003', 'Arjav Jain', '8506088998',0);
insert into student values('004', 'Vansh Gupta', '9899446116',0);
insert into student values('005', 'Sid Mehrotra', '9988776655',0);
insert into student values('006', 'Sarthak Arora', '7087797760',0);
insert into student values('007', 'Darshil','8128536843',0);


insert into book values('Penguin Publishers', 'Paulo Coelho', '001', 'The Alchemist','10','4');
insert into book values('Penguin Publishers', 'Enid Blyton', '002', 'Famous Five','20','5');
insert into book values('Pearson Publishers', 'Enid Blyton', '003', 'Secret Seven','15','7');
insert into book values('HarperCollins Publishers', 'Rick Riordan', '004', 'Lightning Thief', '12','8');
insert into book values('Oak Publishers', 'JK Rowling', '005', 'Harry Potter','17','3');
insert into book values('meow', 'Steve Smith', '006', 'kitty kat','7','3');


insert into book_status values(1,'000001','001','2022-01-21','2022-01-25','002');
insert into book_status values(1,'000002','005','2022-01-22','2022-01-27','001');
insert into book_status values(1,'000003','003','2022-01-23','2022-02-10','005');
insert into book_status values(1,'000004','002','2022-01-24','2022-01-30','006');
insert into book_status values(0,'000005','006','2022-01-25','2022-02-07','003');
insert into book_status values(1,'000006','004','2022-01-26','2022-01-31','004');


insert into room values('001',1,'brainstorm');
insert into room values('002',1,'department');
insert into room values('003',1,'clubs');
insert into room values('004',1,'gd');

insert into slots values('001','2022-01-28','002','000001');
insert into slots values('002','2022-01-29','003','000002');
 insert into slots values('003','2022-01-30','001','000003');

select * from slots;

-- query to issue a book from the library
set transaction isolation level serializable;
start transaction;
-- we intend to issue the book 'kitty kat'
update book set no_of_copies = no_of_copies - 1 where title = "kitty kat" and no_of_copies > 0;
-- if the number of copies constraint satisfies, we can insert the transaction into the book_status
insert into book_status(stat, book_ID, issue_date, return_date, student_id) values(0,'006',current_date(),null,'002');
-- upadtion done
commit ;



-- query to return a book start
update book set no_of_copies = no_of_copies + 1 where title= 'kitty kat';
update book_status
set return_date=current_date(), stat=1
where stat=0 and book_ID='006';
select * from book_status;
-- query to return a book ended




-- query to book a room start
set transaction isolation level serializable;
start transaction;
-- we wish to book the room 'brainstrom'
update room
set avail = 0
where room_name = "brainstorm" and avail=1;
-- if the room is available, we can insert the booking into the slot table
insert into slots(student_id, date_of_booking, room_ID) values('002', current_date(), '1');
commit ;
select * from slots;
-- query to book a ended




-- query to calculate the dues from a single book issue/returned started
create view v1 as select * from student natural join book natural join book_status;
update v1 set dues=(return_date-issue_date)*price_per_day + dues where full_name= 'Mitul Chadha';
select * from v1;

-- query to calculate the dues from a single book issue/returned ended


-- query to insert a student into the table
insert into student(full_name,mobile_number,dues) values('pranav','1243567980',0);
-- end

-- query to display the students who have dues pending
select * from student where dues>0;
-- end

-- query to clear dues of a particular student
update student
set dues=0
where student.full_name='Mitul Chadha';
-- end



-- query to add a new book
insert into book(publisher,author,title,price_per_day,no_of_copies) values('beeboom','zophie','chronicles','7','5');
-- end


-- query to delete a  particular student from the database

delete from student
where student_id='008';
-- end

-- query to drop database
drop database library;