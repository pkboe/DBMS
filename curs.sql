
//Code for Cursor:

drop procedure if exists p_grade;

    delimiter //
    create procedure p_grade()
    begin

	DECLARE done INT DEFAULT FALSE;

        declare s_marks int;
        declare s_rollno int;
        declare s_name varchar(30);
        declare s_class varchar(80);
        declare s_student cursor For Select  rollno, name, marks from stud_marks;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

         open s_student;
	
	 read_loop: LOOP
        	  fetch s_student  into s_rollno,s_name,s_marks;

	IF done THEN
	      LEAVE read_loop;
	END IF;

         if(s_marks<=1500 and s_marks>=990) then
	         set s_class='Distinction';

        elseif(s_marks<=989 and s_marks>=900) then
        	 set s_class='First Class';
        
        elseif (s_marks<=899 and s_marks>=825) then
            set s_class='Higher Second Class';

	else
	 set s_class='Pass';

	end if;
	 insert into result(rollno,name,class)values(s_rollno,s_name,s_class);

  END LOOP;
         close s_student;
         end;
//

delimiter ;