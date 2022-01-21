-- FUNCTION
--Возвращает сколько ноутов на этой операционной системе
CREATE OR REPLACE FUNCTION os_on_laptops(smth text) RETURNS int AS
$$
  DECLARE
    resultat integer;
  BEGIN
    SELECT COUNT(*) INTO result
    FROM laptops
    INNER JOIN os ON laptops.os_id = os.os_id
    WHERE os.os_name = smth;
    
   RETURN result;
  END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM os_on_laptops('without os')
