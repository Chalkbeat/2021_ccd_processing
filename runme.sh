#!/usr/bin/env bash

task=${1:-all}

# download/unpack shapefiles and upload into PostGIS
case $task in
  help)
    echo """Tasks you can run with this script:
  - create_schema: uses csvkit to guess SQL titles and dtypes. likely requires typing revisions.
  - copy_headers: moves files from header folder to main (you might not want to use this if you're manually editing the table import files)
  - database: creates psql DB
  - import: runs all common core data imports
  - filter: limits school-level data to in-scope states
  - combine: adds district IDs and other characteristics to school-level data
If you don't specify a task, the script runs all of these in sequence.
    """
  ;;

  # HEADERS: generate createtable from headers (must be manually run)
  headers | create_schema)
    echo "=== Pulling headers to create schemas"
    pushd data
    mkdir -p headers
    for csv in *.csv; do
        table="import_${csv%.csv}"
        head -n 20 $csv | csvsql --no-constraints --tables $table > headers/$table.sql;
    done
    popd
  ;;&

  headers | copy_headers)
    echo "=== Adding header files to root directory"
    cp -a data/headers/*.sql .
  ;;

  # ALL: main tasks (run by default)
  all | database)
    echo "=== Creating and populating database..."
    dropdb ccd_stats
    createdb ccd_stats
  ;;&

  # create folders
  all | folders)
    echo "=== Creating file structure"
    mkdir -p output
  ;;&

  # load data
  all | import)
    echo "=== Loading ccd data..."
    for import in import*.sql; do
      psql ccd_stats -f $import;
    done
  ;;&

  # filter ccd data to in-scope topics
  all | filter)
    echo "=== Filtering ccd data..."
    for filter in filter*.sql; do
      psql ccd_stats -f $filter;
    done
  ;;&

  # combine ccd enrollment with ccd directory info
  all | combine)
    echo "=== Joining ccd directory to ccd student data..."
    for combine in combine*.sql; do
      psql ccd_stats -f $combine;
    done
  ;;&
esac