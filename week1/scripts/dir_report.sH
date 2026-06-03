#!/bin/bash
set -euo pipefail

# Count total files
count_files() {
    local path="$1"
    local count
    count=$(find "$path" -type f | wc -l)
    echo "Total Files: $count"
}

# Count total directories
count_dirs() {
    local path="$1"
    local count
    count=$(find "$path" -type d | wc -l)
    echo "Total Directories: $count"
}

# Get total size
get_size() {
    local path="$1"
    local size
    size=$(du -sh "$path" | cut -f1)
    echo "Total Size: $size"
}

# Top 3 largest files
top_files() {
    local path="$1"
    echo "Top 3 Largest Files:"
    find "$path" -type f -exec du -sh {} + 2>/dev/null | sort -rh | head -3
}

# Main function
main() {
    # Check if argument was provided
    if [ -z "${1:-}" ]; then
        echo "Error: No directory path provided."
        echo "Usage: $0 <directory_path>"
        exit 1
    fi

    local dir="$1"

    # Check if path exists
    if [ ! -d "$dir" ]; then
        echo "Error: Directory '$dir' does not exist."
        exit 1
    fi

    echo "================================"
    echo "  Directory Report: $dir"
    echo "================================"
    count_files "$dir"
    count_dirs "$dir"
    get_size "$dir"
    top_files "$dir"
    echo "================================"
}

main "$@"
