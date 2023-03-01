Common Core Data processing pipeline
====================================

Prerequisites
-------------

* Bash v4 or higher
* [csvkit](https://csvkit.readthedocs.io/en/latest/tutorial/1_getting_started.html#installing-csvkit) is necessary to run the optional tasks for generating schemas from csv headers, but the main task sequence will run without it
* Postgres installed and runnable as the current user

Instructions
------------

### To run

Execute ``./runme.sh`` to step through the various scripts. That file is also commented, so you can see the individual processing steps and re-run them once the pipeline is initialized.

Execute a specific task as ``./runme.sh task_name``

### Sample query

To test import success try the following:

`psql ccd_stats`

`select distinct statename from districts;`

### Troubleshooting

If you receive an error stating that you don't have permissions to run `runme.sh`, but your permissions indicate you should be able to run the file, check whether the file is executable.

`ls -alh`

To make executable: 

`chmod 755 runme.sh`