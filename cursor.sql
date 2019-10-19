DROP PROCEDURE IF EXISTS mycursor;
delimiter //
CREATE PROCEDURE mycursor()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE  c_rollno int;
	DECLARE  c_name varchar(20);
	DECLARE  C_Student CURSOR  for SELECT rollno,name FROM old_RC where rollno not in(select rollno from new_RC);

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	BEGIN
		OPEN C_Student;
   		read_loop:LOOP
   			FETCH C_Student into c_rollno, c_name;   
    
   			IF done THEN
    	  		LEAVE read_loop;
   			END IF;           
    
    	  	insert into new_RC values(c_rollno, c_name);
   		END LOOP;
   		CLOSE C_Student;
	END;
END;
//
delimiter ;
