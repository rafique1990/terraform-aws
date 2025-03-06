aws s3api list-buckets --query "Buckets[*].Name" --output text | while read bucket; do
    region=$(aws s3api get-bucket-location --bucket $bucket --output text 2>/dev/null)
    if [ "$region" == "None" ]; then
        region="us-east-1"
    fi
    echo "resource \"aws_s3_bucket\" \"$bucket\" {
  bucket = \"$bucket\"
  provider = aws
}" >> s3_buckets.tf
done
