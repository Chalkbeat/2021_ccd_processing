drop table if exists add_name cascade;
drop table if exists add_frl cascade;
drop table if exists ccd_frl_combined cascade;

CREATE TABLE add_name AS (
    SELECT
          schools.SCHOOL_YEAR 
        , schools.FIPST 
        , schools.STATENAME 
        , schools.ST 
        , schools.SCH_NAME 
        , districts.LEA_NAME
        , districts.LEA_TYPE_TEXT
        , districts.CHARTER_LEA_TEXT
        , districts.level
        , schools.STATE_AGENCY_NO 
        , schools.UNION_TXT 
        , schools.ST_LEAID 
        , schools.LEAID 
        , schools.ST_SCHID 
        , schools.NCESSCH 
        , schools.SCHID 
        , schools.STUDENT_COUNT AS TOT_STUDENT_COUNT
        , schools.TOTAL_INDICATOR AS TOT_TOTAL_INDICATOR
        , schools.DMS_FLAG
    FROM ccd_frl_filter as schools

    LEFT JOIN ccd_directory as districts
        on districts.leaid = schools.leaid
);

CREATE TABLE add_frl AS (
    SELECT
          schools.*
          ,frl.NCESSCH AS CHECK_ID
          ,frl.DATA_GROUP
          ,frl.LUNCH_PROGRAM
          ,frl.STUDENT_COUNT AS FRL_STUDENT_COUNT
          ,frl.TOTAL_INDICATOR AS FRL_TOTAL_INDICATOR
    FROM ccd_frl_filter as states

    LEFT JOIN add_name as schools
        on states.NCESSCH = schools.NCESSCH
    LEFT JOIN ccd_frl as frl
        on frl.NCESSCH = states.NCESSCH
);

CREATE TABLE ccd_frl_combined AS (
    SELECT 
        SCHOOL_YEAR 
        , FIPST 
        , STATENAME 
        , ST 
        , SCH_NAME 
        , LEA_NAME
        , LEA_TYPE_TEXT
        , CHARTER_LEA_TEXT
        , LEVEL
        , STATE_AGENCY_NO 
        , UNION_TXT 
        , ST_LEAID 
        , LEAID 
        , ST_SCHID 
        , NCESSCH 
        , SCHID 
        , CHECK_ID
        , DATA_GROUP
        , LUNCH_PROGRAM
        , FRL_TOTAL_INDICATOR
        , FRL_STUDENT_COUNT AS FRL_ENRL
        , SUM(TOT_STUDENT_COUNT) AS TOTAL_ENRL
    FROM add_frl

    WHERE 1=1

    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21
);

\copy (select * from ccd_frl_combined) to 'output/all_frl_enrollment.csv' csv header;
