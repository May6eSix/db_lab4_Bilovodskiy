-- FUNCTION
--Возвращает сколько ноутбуков на этой операционной системе
CREATE OR REPLACE FUNCTION os_on_laptops(smth text) RETURNS int AS
$$
  DECLARE
    result integer;
  BEGIN
    SELECT COUNT(*) INTO result
    FROM laptop
    INNER JOIN os ON laptop.os_id = os.os_id
    WHERE os.os_name = smth;
    
   RETURN result;
  END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM os_on_laptops('without os')


-- PROCEDURE
-- ищет название ноутов с этой видеокартой
CREATE OR REPLACE PROCEDURE gpu_notebook(smth text)
LANGUAGE plpgsql AS
$$
  DECLARE
    ss record;
  BEGIN
    FOR ss IN
      SELECT laptop.name
      FROM laptop
      INNER JOIN gpu ON laptop.gpu_id = gpu.gpu_id
      WHERE gpu.gpu_series = smth
    LOOP
      RAISE INFO 'Laptop: %', ss.name;
    END LOOP;
  END;
$$


CALL gpu_notebook('rx 560x')



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
 
insert into os( os_name)
	values('Windows 8')
	returning *;
 
select * from os
