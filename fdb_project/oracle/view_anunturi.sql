DROP VIEW anunt_view;

CREATE OR REPLACE VIEW anunt_view AS
WITH rest_doc AS (
  SELECT HTTPURITYPE.createuri('http://localhost:3000/anunt').getclob() AS doc 
  FROM dual
)
SELECT
  id,
  TO_DATE(date_str, 'YYYY-MM-DD') AS date_posted,
  description,
  kilometers,
  userid,
  carid
FROM JSON_TABLE(
  (SELECT doc FROM rest_doc), '$[*]'
  COLUMNS (
    id           NUMBER          PATH '$.id',
    date_str     VARCHAR2(20)    PATH '$.date',
    description  VARCHAR2(400)   PATH '$.description',
    kilometers   NUMBER          PATH '$.kilometers',
    userid       VARCHAR2(50)    PATH '$.userid',
    carid        NUMBER          PATH '$.carid'
  )
);

SELECT * FROM anunt_view;
