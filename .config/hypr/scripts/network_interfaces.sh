interface=$(ip -o link show | awk -F': ' '$2 != "lo" {print $2}')

echo "{\"text\":\"$interface\"}"
