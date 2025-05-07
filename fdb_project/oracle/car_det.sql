delete CAR_DET;
CREATE OR REPLACE VIEW CAR_DET AS
SELECT 
    c.manufacturer,                 
    COUNT(a.id) AS total_anunturi,    
    AVG(a.kilometers) AS avg_kilometers,
    MIN(a.kilometers) AS min_kilometers,
    MAX(a.kilometers) AS max_kilometers 
FROM 
    car c
JOIN 
    anunt_view a ON c.id = a.carid         
GROUP BY 
    c.manufacturer;                
  
select * from  car_manufacturer_summary;


BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'auto_data',
    p_object         => 'CAR_DET',
    p_object_type    => 'VIEW',
    p_object_alias   => 'car_det',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/
 
--------------------------------------------------------------------------------

drop view USER_CAR_DET;
CREATE OR REPLACE VIEW USER_CAR_DET AS
SELECT 
    u.username,                
    COUNT(a.id) AS num_anunturi,
    AVG(a.kilometers) AS avg_kilometers,
    MAX(c.year) AS latest_car_year 
FROM 
    utilizatori_view_mongodb u
JOIN 
    anunt_VIEW a ON u.user_id = a.userid  
JOIN 
    car c ON a.carid = c.id     
GROUP BY 
    u.username;                 
 
 
select * from  USER_CAR_DET;



BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'auto_data',
    p_object         => 'USER_CAR_DET',
    p_object_type    => 'VIEW',
    p_object_alias   => 'user_car_det',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/