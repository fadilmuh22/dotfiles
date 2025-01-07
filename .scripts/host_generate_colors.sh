host_generate_colors() {
  # Resolve domain to IP if necessary
  input=$1
  if [[ "$input" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # It's already an IP address
    ip="$input"
  else
    # Resolve domain to IP
    ip=$(getent hosts "$input" | awk '{ print $1 }')
  fi
  
  # Hash the IP address (or domain's resolved IP)
  hash=$(echo -n "$ip" | sha256sum | awk '{print $1}')
  
  # Generate two colors based on the hash (hex color codes)
  bg="#${hash:0:6}"  # Background color using the first 6 characters of the hash
  fg="#${hash:6:6}"  # Foreground color using the next 6 characters of the hash
  
  # Return the colors
  echo "bg=$bg fg=$fg"
}

host_generate_colors "$1"
