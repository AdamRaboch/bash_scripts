#!/bin/bash

read -p "Enter your name:  "  name
echo "Your name is $name"

read -sp "Enter your password:  "  pass
echo "Your password is $pass"

#limit the length -n
#read -n 12 
# time to skip to next line 
#read -t 10


read -p "What is your name?"  name
echo "Hello $name"
#!/bin/bash

# Function to check internet connectivity
check_internet() {
    ping -c 1 8.8.8.8 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Internet is reachable."
    else
        echo "No internet connectivity."
    fi
}

# Call the function to check internet connectivity
check_internet

read -n 12 -p "What is your IP?"  ip
read -p "How many pings shall I send to your IP?"  ping
ping -c $ping $ip > pingresults.txt
cat pingresults.txt
exit 0
