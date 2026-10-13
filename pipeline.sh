#!/bin/bash

count=$(grep ComputerScience ../exercises/students.txt | wc -l)
echo "ComputerScience students: $count"
