function killport
    if test (count $argv) -eq 0
        echo "Usage: killport <port>"
        return 1
    end

    set port $argv[1]
    
    # Find PID using lsof
    set pid (lsof -t -i:$port)
    
    if test -n "$pid"
        echo "Killing process on port $port (PID: $pid)..."
        kill -9 $pid
        if test $status -eq 0
            echo "Process killed successfully."
        else
            echo "Failed to kill process."
        end
    else
        echo "No process found listening on port $port."
    end
end

