drop table if exists ccd_states cascade;

create table ccd_states AS (
    SELECT
        ccd_main.* 
    FROM ccd_main

    WHERE 1=1
    AND ST IN ('CA','FL','NY','IL','NV')
    AND GRADE IN ('Grade 9','Grade 10','Grade 11','Grade 12')
);

\copy (select * from ccd_states) to 'output/hs_all_enrl.csv' csv header;
