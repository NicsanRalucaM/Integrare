ALTER SESSION SET container = XEPDB1; 

DROP USER auto_data CASCADE;

CREATE USER auto_data IDENTIFIED BY password;


grant connect, resource to auto_data;
grant CREATE VIEW to auto_data;
grant create database link to auto_data;

----
grant CREATE ANY DIRECTORY to auto_data;
grant execute on utl_http to auto_data;
grant execute on dbms_lob to auto_data;

grant CREATE DIMENSION, CREATE JOB, CREATE MATERIALIZED VIEW, CREATE SYNONYM to auto_data;


begin
  dbms_network_acl_admin.append_host_ace (
      host       => '*',
      lower_port => NULL,
      upper_port => NULL,
      ace        => xs$ace_type(privilege_list => xs$name_list('http'),
                                principal_name => 'auto_data',
                                principal_type => xs_acl.ptype_db));
  end;
/
COMMIT;

GRANT CONNECT, RESOURCE TO auto_data;
GRANT CREATE TABLE, CREATE VIEW, CREATE PROCEDURE TO auto_data;
GRANT ALTER ANY TABLE, DROP ANY TABLE, CREATE ANY TABLE, CREATE ANY VIEW TO auto_data;


GRANT CREATE TABLE TO auto_data;

ALTER USER auto_data QUOTA UNLIMITED ON USERS;



select* from users;





