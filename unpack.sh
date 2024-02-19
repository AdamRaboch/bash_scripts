#!/bin/bash

# Function to decompress a single file
decompress_file() {
 	local file="$1"
    	local verbose="$2"
    	local success=0

    	# Check if the file exists
    	if [ -f "$file" ]; then

	# Check the type of compression using the file command
        compression_type=$(file "$file" | awk '{print $2}')

        # Decompress the file based on compression type
        case "$compression_type" in
            "gzip")
                if [ "$verbose" = true ]; then
                    echo "Unpacking $file..."
                fi
                gunzip -f "$file" && ((success++))
                ;;
            "bzip2")
                if [ "$verbose" = true ]; then
                    echo "Unpacking $file..."
                fi
                bunzip2 -f "$file" && ((success++))
                ;;
            "Zip")
                if [ "$verbose" = true ]; then
                    echo "Unpacking $file..."
                fi
                unzip -o "$file" && ((success++))
                ;;
            "compress")
                if [ "$verbose" = true ]; then
                    echo "Unpacking $file..."
                fi
                uncompress -f "$file" && ((success++))
                ;;
            *)
                if [ "$verbose" = true ]; then
                    echo "Ignoring $file"
                fi
                ;;
        esac
    		else
        		if [ "$verbose" = true ]; then
            		echo "Ignoring $file - Not a regular file"
        	fi
    	fi

    return $success
}

# Function to decompress all files in a directory
decompress_directory() {
    	local directory="$1"
    	local verbose="$2"
    	local total_success=0
    	local total_files=0

    	# Iterate over files in the directory
    	for file in "$directory"/*; do
        	if [ -f "$file" ]; then
            		decompress_file "$file" "$verbose" && ((total_success++))
            		((total_files++))
        	elif [ -d "$file" ] && [ "$recursive" = true ]; then
            		decompress_directory "$file" "$verbose"
        fi
    done

    	# Echo the number of archives decompressed in this directory
    	echo "Decompressed $total_success archive(s)"

    # Return the number of files that were not decompressed
	return $((total_files - total_success))
}

	# Main function
	main() {
    		local verbose=false
    		local recursive=false
    		local total_not_decompressed=0

    	# Parse command line options
    	while getopts "rv" option; do
        	case $option in
            	r)
                recursive=true
                ;;
            	v)
                verbose=true
                ;;
            	\?)
                echo "Invalid option: -$OPTARG" >&2
                ;;
        esac
    done
    shift $((OPTIND - 1))

    # Decompress each file or directory
    for arg in "$@"; do
        if [ -f "$arg" ]; then
            decompress_file "$arg" "$verbose" || ((total_not_decompressed++))
        elif [ -d "$arg" ]; then
            decompress_directory "$arg" "$verbose" || ((total_not_decompressed++))
        else
            if [ "$verbose" = true ]; then
                echo "Ignoring $arg - Not a regular file or directory"
            fi
            ((total_not_decompressed++))
        fi
    done

}

	# Execute the main function with command line arguments
	main "$@"
