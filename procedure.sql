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
