file=config

while IFS='' read -r line || [[ -n "$line" ]]; do
  IFS=':' read -r protocol endpoint <<< "$line"
  echo "Protocol: $protocol - Endpoint: $endpoint"
done < "$file"
