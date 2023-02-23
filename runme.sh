#!/usr/bin/env bash

task=${1:-all}

# download/unpack shapefiles and upload into PostGIS
case $task in
  help)
    echo """Tasks you can run with this script:
  - database: downloads shapefiles and (re)creates the PostGIS DB
  - intersections: matches blockgroups to geodata
  - import: runs all census data imports
  - districts: runs analysis and outputs district-level census data
  - cps: runs analysis and outputs attendance boundary-level census data
If you don't specify a task, the script runs all of these in sequence.
    """
  ;;

  all | database)
    echo "=== Creating and populating database..."
    dropdb ccd_stats
    createdb ccd_stats
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