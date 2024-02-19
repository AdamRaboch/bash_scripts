#!/bin/bash

# Array declaration
shopping=('bread' 'cheese' 'butter' 'yogurt' 'eggs')

# Print the number of items on the shopping list
echo "The number of items on the shopping list is: ${#shopping[*]}"

# Print the first item on the shopping list
echo "The first item on the shopping list is: ${shopping[0]}"

# Print the last item on the shopping list
echo "The last item on the shopping list is: ${shopping[-1]}"

# Print all the items on the shopping list
echo "The items on the shopping list are: ${shopping[*]}"

