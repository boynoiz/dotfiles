function bssh
    # Check if tmux is installed
    if not command -v tmux &>/dev/null
        echo "Error: tmux is not installed. Please install tmux to use this function."
        return 1
    end

    # Check if ssh is installed
    if not command -v ssh &>/dev/null
        echo "Error: ssh is not installed. Please install ssh to use this function."
        return 1
    end

    if test (count $argv) -eq 0
        echo "Usage: bssh <host1> <host2> <host3> ..."
        return 1
    end

    set -l hosts $argv
    set -l session_name "bssh"

    # Start a new tmux session if we're not already in one
    if test -z "$TMUX"
        tmux new-session -d -s $session_name
    else
        set session_name (tmux display-message -p '#S')
    end

    # Create the first pane and ssh to the first host
    tmux new-window -t $session_name: "ssh $hosts[1]"

    # Create panes for the rest of the hosts
    for host in $hosts[2..-1]
        tmux split-window -t $session_name: -h "ssh $host"
        tmux select-layout -t $session_name: tiled
    end

    # Enable synchronize-panes
    tmux set-window-option -t $session_name: synchronize-panes on

    # Attach to the session if we created a new one
    if test -z "$TMUX"
        tmux attach-session -t $session_name
    end
end
