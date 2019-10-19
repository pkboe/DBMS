DROP PROCEDURE IF EXISTS p1;

delimiter //

create procedure p1(IN rno int, IN bname varchar(20))
begin 
	declare d1 date;
	declare daycnt int;
	declare fine_amt int;


	select DOI into d1 from borrower where rollno = rno and  bookname = bname;

	select DATEDIFF(now(),d1) into daycnt;

	if (daycnt > 15 and daycnt < 30) then 
		set fine_amt = daycnt * 5;		
		insert into fine(rollno,date_of_fine,amount) values (rno,now(),fine_amt);	
	elseif (daycnt > 30) then 
		set fine_amt = daycnt * 50; 			
		insert into fine(rollno,date_of_fine,amount) values (rno,now(),fine_amt);	
	end if;
	
	update borrower set status = 'Revisted' where rollno = rno;
		
end;

//

delimiter ;
