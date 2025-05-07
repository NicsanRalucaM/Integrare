drop view anunturi_cu_useri_si_masini;
CREATE OR REPLACE VIEW anunturi_cu_useri_si_masini AS
SELECT
  c.manufacturer AS car_manufacturer,
  c.model        AS car_model,
  a.kilometers   AS milage,
  c.engine_capacity   AS engine_capacity,
  us.username    AS posted_by,
  a.description AS description
FROM
  anunt_view a
JOIN
  car c ON a.carid = c.id
JOIN
  utilizatori_view_mongodb us ON a.userid = us.user_id;
  
select * from anunturi_cu_useri_si_masini;


BEGIN
    ORDS.ENABLE_SCHEMA(p_enabled => TRUE,
                       p_schema => 'auto_data',
                       p_url_mapping_type => 'BASE_PATH',
                       p_url_mapping_pattern => 'auto',
                       p_auto_rest_auth => FALSE);
    COMMIT;
END;
/

BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'auto_data',
    p_object         => 'UTILIZATORI_VIEW_MONGODB',
    p_object_type    => 'VIEW',
    p_object_alias   => 'utilizatori',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/

BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'auto_data',
    p_object         => 'ANUNTURI_CU_USERI_SI_MASINI',
    p_object_type    => 'VIEW',
    p_object_alias   => 'anunturi_cu_useri_si_masini',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/



















  