Common Core Data processing pipeline
====================================

Prerequisites
-------------

* Bash v4 or higher
* [csvkit](https://csvkit.readthedocs.io/en/latest/tutorial/1_getting_started.html#installing-csvkit) is necessary to run the optional tasks for generating schemas from csv headers, but the main task sequence will run without it
* Postgres installed and runnable as the current user

Data Sources
-------------

This is a simplified workflow to import and join enrollment school-level Common Core Data to district-level directory attributes. 

`main` branch uses:
* Public Elementary/Secondary School Universe Survey Data, (v.1a) for the 2021 - 2022 school years
    - Membership (school-level enrollment)
* Local Education Agency (School District) Universe Survey Data, (v.1a)
    - Directory (school-level directory that contains fuller district associations)

`frl` branch uses:
* Public Elementary/Secondary School Universe Survey Data, (v.1a) for the 2022 - 2023 school years
    - Membership (school-level enrollment)
* Local Education Agency (School District) Universe Survey Data, (v.1a)
    - Directory (school-level directory that contains fuller district associations)
* Provisional Common Core of Data  - Free and Reduced Lunch, for the 2022 - 2023 school year

This data is accessible on the NCES website's [CCD Data Files bulk downloader](https://nces.ed.gov/ccd/files.asp#Fiscal:2,LevelId:7,SchoolYearId:36,Page:1), under the nonfiscal -> school OR district -> 2021-22 OR 2022-23 selection in the search menu.

The header extraction and import processes are easily adaptable to additional Common Core Datasets, but you'll have to write fresh filter and join files if you want to incorporate new datasets.

The CCD schemas are fairly consistent for past years of Membership and Directory files.

Instructions
------------

### To run

Execute ``./runme.sh`` to step through the various scripts. That file is also commented, so you can see the individual processing steps and re-run them once the pipeline is initialized.

Execute a specific task as ``./runme.sh task_name``

### Sample query

To test import success try the following:

`psql ccd_stats`

`select distinct statename from ccd_directory;`

### Troubleshooting

If you receive an error stating that you don't have permissions to run `runme.sh`, but your permissions indicate you should be able to run the file, check whether the file is executable.

`ls -alh`

To make executable: 

`chmod 755 runme.sh`