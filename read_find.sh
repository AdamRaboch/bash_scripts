#!/bin/bash

# Ask for user's name
read -p "Welcome! Please enter your name:" username

# Print a welcome message
echo "Hello, $username! Welcome to the file finder."

# Ask for the file to search
read -p "Please enter the name of the file you want to find:" filename

# Perform the file search and save results to find.txt
echo "Searching for '$filename' in the system..."
find /home -name "$filename" > find.txt 2>/dev/null

# Print the location of the search results
echo "Results have been saved in find.txt"
cat find.txt