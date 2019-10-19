
//Code For Trigger after update


drop trigger if exists Make_audit;
delimiter //
CREATE TRIGGER Make_audit
  AFTER UPDATE ON lib_book
  FOR EACH ROW
BEGIN
  INSERT INTO lib_Audit (bid, bname, qty)
  VALUES (OLD.bid, OLD.bname,OLD.qty);
END;
//

delimiter ;
