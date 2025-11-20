function myip
    echo "🏠 Local IP:"
    ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1
    
    echo ""
    echo "🌍 Public IP:"
    curl -s ifconfig.me
    echo "" # Newline after curl output
end

