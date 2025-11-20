function obs_note
    set -q OBSIDIAN_VAULT; or set OBSIDIAN_VAULT "$HOME/Documents/Obsidian Vault"
    
    if not test -d "$OBSIDIAN_VAULT"
        echo "Error: Obsidian Vault directory not found at $OBSIDIAN_VAULT"
        return 1
    end

    set -l note_title "Untitled"
    if test (count $argv) -gt 0
        set note_title "$argv"
    else
        set note_title "Untitled-$(date +%Y%m%d%H%M%S)"
    end
    
    # Check if Inbox exists
    set -l note_path "$OBSIDIAN_VAULT/$note_title.md"
    if test -d "$OBSIDIAN_VAULT/Inbox"
        set note_path "$OBSIDIAN_VAULT/Inbox/$note_title.md"
    else if test -d "$OBSIDIAN_VAULT/00 - Inbox"
        set note_path "$OBSIDIAN_VAULT/00 - Inbox/$note_title.md"
    end

    if not test -f "$note_path"
        touch "$note_path"
        echo "# $note_title" > "$note_path"
        echo "" >> "$note_path"
        echo "Created: $(date '+%Y-%m-%d %H:%M')" >> "$note_path"
        echo "" >> "$note_path"
    else
        echo "Note already exists, opening..."
    end
    
    # Open with default editor (likely Obsidian or system text editor)
    xdg-open "$note_path"
end

