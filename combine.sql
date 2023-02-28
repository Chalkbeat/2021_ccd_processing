drop table if exists ccd_gender cascade;
drop table if exists add_name cascade;

CREATE TEMPORARY TABLE add_name AS (
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
        , schools.FIELD_UNION 
        , schools.ST_LEAID 
        , schools.LEAID 
        , schools.ST_SCHID 
        , schools.NCESSCH 
        , schools.SCHID 
        , schools.SEX 
        , schools.STUDENT_COUNT
        , schools.TOTAL_INDICATOR
        , schools.DMS_FLAG
    FROM ccd_states as schools

    LEFT JOIN ccd_directory as districts
        on districts.leaid = schools.leaid
);

CREATE TABLE ccd_gender AS (
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
        , FIELD_UNION 
        , ST_LEAID 
        , LEAID 
        , ST_SCHID 
        , NCESSCH 
        , SCHID 
        , SEX 
        , SUM(STUDENT_COUNT) AS HS_ENRL
    FROM add_name

    WHERE 1=1
    AND SEX IN ('Male','Female','Not Specified')

    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
);

\copy (select * from ccd_gender) to 'output/hs_enrollment.csv' csv header;
