-- TRIGGER
--прибавляет приставку ОС перед новосозданым в базе названии опер. сист.

CREATE OR REPLACE FUNCTION is_os() RETURNS trigger AS
$$
  DECLARE
  
  BEGIN
  	RAISE NOTICE 'NEW:%',NEW;
	NEW.os_name := 'OS: ' || NEW.os_name;
	return NEW;
	
  END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER os_updater
 BEFORE INSERT ON os
 FOR EACH ROW EXECUTE FUNCTION is_os();
