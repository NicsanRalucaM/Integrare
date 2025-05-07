drop function get_restheart_data_media;
CREATE OR REPLACE FUNCTION get_restheart_data_media(pURL VARCHAR2, pUserPass VARCHAR2) 
RETURN clob IS
  l_req   UTL_HTTP.req;
  l_resp  UTL_HTTP.resp;
  l_buffer clob; 
begin
  l_req  := UTL_HTTP.begin_request(pURL);
  UTL_HTTP.set_header(l_req, 'Authorization', 'Basic ' || 
    UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(UTL_I18N.string_to_raw(pUserPass, 'AL32UTF8')))); 
  l_resp := UTL_HTTP.get_response(l_req);
  UTL_HTTP.READ_TEXT(l_resp, l_buffer);
  UTL_HTTP.end_response(l_resp);
  return l_buffer;
end;
/
--SELECT get_restheart_data_media('http://localhost:8080/utilizatori', 'admin:secret') from dual;
--SELECT HTTPURITYPE.createuri('http://admin:secret@localhost:8080/utilizatori').getclob() as doc from dual;

drop view utilizatori_view_mongodb;
CREATE OR REPLACE VIEW utilizatori_view_mongodb AS
WITH json AS
    (SELECT get_restheart_data_media('http://localhost:9090/users', 'admin:secret') doc FROM dual)
SELECT DISTINCT
  user_id, username, birthday
FROM JSON_TABLE(
    (SELECT doc FROM json),
    '$[*]'
    COLUMNS (
        user_id   PATH '$.id'       
      , username  PATH '$.username' 
      , birthday  PATH '$.birthday' 
    )
);

SELECT * FROM utilizatori_view_mongodb;
