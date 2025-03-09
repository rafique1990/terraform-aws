#!/bin/bash

# Set the source directory and target directory for the combined files
SOURCE_DIR="$HOME/terraform-aws/generated/aws"
TARGET_DIR="$HOME/terraform-aws/generated/aws/combined"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Loop through all the subdirectories in the SOURCE_DIR
for resource_dir in "$SOURCE_DIR"/*/; do
  # Get the resource name by removing the base path (SOURCE_DIR)
  resource_name=$(basename "$resource_dir")

  # Print message for the current resource directory being processed
  echo "Processing $resource_name..."

  # Exclude non-essential files and copy .tf files
  find "$resource_dir" -type f -name "*.tf" ! -name "terraform.tfstate" ! -name "outputs.tf" -exec cp {} "$TARGET_DIR" \;

  # Optionally rename files to avoid name conflicts or clarify the source resource
  for tf_file in "$TARGET_DIR"/*.tf; do
    # Get the base file name
    base_name=$(basename "$tf_file")
    
    # Check if the file is from a specific resource and rename accordingly
    if [[ $base_name == *"lambda"* ]]; then
      mv "$tf_file" "$TARGET_DIR/$(basename $resource_name)_$base_name"
    elif [[ $base_name == *"dynamodb"* ]]; then
      mv "$tf_file" "$TARGET_DIR/$(basename $resource_name)_$base_name"
    else
      mv "$tf_file" "$TARGET_DIR/$(basename $resource_name)_$base_name"
    fi
  done
done

# Optional: Print success message after the process is complete
echo "All relevant .tf files have been copied and renamed to the '$TARGET_DIR' directory."
