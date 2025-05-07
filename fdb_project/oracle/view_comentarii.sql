drop view comentarii_view;
CREATE OR REPLACE VIEW comentarii_view AS
WITH rest_doc AS (
  SELECT HTTPURITYPE.createuri('http://localhost:3000/comentarii').getclob() AS doc 
  FROM dual
)
SELECT
  id,
  userid,
  anuntid,
  commenttext
FROM JSON_TABLE(
  (SELECT doc FROM rest_doc), '$[*]'
  COLUMNS (
    id           NUMBER          PATH '$.id',
    userid       VARCHAR2(50)    PATH '$.userid',
    anuntid      NUMBER          PATH '$.anuntid',
    commenttext  VARCHAR2(1000)  PATH '$.commenttext'
  )
);

SELECT * FROM comentarii_view;

