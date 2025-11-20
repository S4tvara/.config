function obs_daily
    set -q OBSIDIAN_VAULT; or set OBSIDIAN_VAULT "$HOME/Documents/Obsidian Vault"
    
    if not test -d "$OBSIDIAN_VAULT"
        echo "Error: Obsidian Vault directory not found at $OBSIDIAN_VAULT"
        return 1
    end

    set -l date_str (date "+%Y-%m-%d")
    set -l daily_dir "$OBSIDIAN_VAULT"
    
    # Check for common Daily Notes folders
    if test -d "$OBSIDIAN_VAULT/Daily Notes"
        set daily_dir "$OBSIDIAN_VAULT/Daily Notes"
    else if test -d "$OBSIDIAN_VAULT/Daily"
        set daily_dir "$OBSIDIAN_VAULT/Daily"
    else if test -d "$OBSIDIAN_VAULT/Journal"
        set daily_dir "$OBSIDIAN_VAULT/Journal"
    end

    set -l note_path "$daily_dir/$date_str.md"

    if not test -f "$note_path"
        echo "# Daily Note: $date_str" > "$note_path"
        echo "" >> "$note_path"
    end

    # Append a timestamp for the new entry
    echo "" >> "$note_path"
    echo "## $(date '+%H:%M')" >> "$note_path"
    echo "" >> "$note_path"
    
    # Open the file
    xdg-open "$note_path"
end

