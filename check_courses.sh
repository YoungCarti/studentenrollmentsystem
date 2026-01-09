#!/bin/bash
# Quick script to check courses in database
mysql -u root -padmin123 student_enrollment -e "SELECT course_id, course_code, course_name, instructor, capacity FROM courses ORDER BY course_id DESC LIMIT 10;"
