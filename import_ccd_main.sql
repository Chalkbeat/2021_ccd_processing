drop table if exists ccd_main cascade;

create table ccd_main (
	SCHOOL_YEAR TEXT, 
	FIPST TEXT, 
	STATENAME TEXT, 
	ST TEXT, 
	SCH_NAME TEXT, 
	STATE_AGENCY_NO TEXT, 
	UNION_TXT TEXT, 
	ST_LEAID TEXT, 
	LEAID TEXT, 
	ST_SCHID TEXT, 
	NCESSCH TEXT, 
	SCHID TEXT, 
	GRADE TEXT, 
	RACE_ETHNICITY TEXT, 
	SEX TEXT, 
	STUDENT_COUNT NUMERIC, 
	TOTAL_INDICATOR TEXT, 
	DMS_FLAG TEXT
);

\copy ccd_main from 'data/main.csv' csv header;