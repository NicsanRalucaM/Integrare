drop view user_activity;
CREATE OR REPLACE VIEW user_activity AS
WITH user_comments AS (
    SELECT
        c.userid AS user_id,
        COUNT(c.id) AS num_comments
    FROM comentarii_view c
    GROUP BY c.userid
),
user_anunturi AS (
    SELECT
        a.userid AS user_id,
        COUNT(a.id) AS num_anunturi
    FROM anunt_view a
    GROUP BY a.userid
),
usernames AS (
    SELECT 
        user_id, 
        username
    FROM utilizatori_view_mongodb 
)
SELECT 
    u.user_id, un.username,
    COALESCE(uc.num_comments, 0) AS num_comments,   
    COALESCE(ua.num_anunturi, 0) AS num_anunturi    
FROM (
    SELECT DISTINCT userid AS user_id FROM comentarii_view
    UNION
    SELECT DISTINCT userid AS user_id FROM anunt_view
) u
LEFT JOIN user_comments uc ON u.user_id = uc.user_id
LEFT JOIN user_anunturi ua ON u.user_id = ua.user_id
LEFT JOIN usernames un ON u.user_id = un.user_id; 

select * from user_activity;

BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'auto_data',
    p_object         => 'USER_ACTIVITY',
    p_object_type    => 'VIEW',
    p_object_alias   => 'activity',
    p_auto_rest_auth => FALSE
  );
  COMMIT;
END;
/

 