drop table if exists ccd_frl_filter cascade;

create table ccd_frl_filter AS (
    SELECT
        ccd_main.* 
    FROM ccd_main

    WHERE 1=1
    AND ST IN ('NV','WA','NC','AR','IL','DE','OK','LA','VA')
    AND TOTAL_INDICATOR = 'Derived - Education Unit Total minus Adult Education Count'
);

\copy (select * from ccd_frl_filter) to 'output/frl_states_all_enrl.csv' csv header;
