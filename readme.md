Common Core Data processing pipeline
====================================

Prerequisites
-------------

* Bash v4 or higher
* Postgres installed and runnable as the current user

Instructions
------------

#### To run

Execute ``./runme.sh`` to step through the various scripts. That file is also commented, so you can see the individual processing steps and re-run them once the pipeline is initialized.

Execute a specific task as ``./runme.sh task_name``

##### Troubleshooting

If you receive an error stating that you don't have permissions to run `runme.sh`, but your permissions indicate you should be able to run the file, check whether the file is executable.

`ls -alh`

To make executable: 

`chmod 755 runme.sh`