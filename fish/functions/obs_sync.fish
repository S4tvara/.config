function obs_sync
    set -q OBSIDIAN_VAULT; or set OBSIDIAN_VAULT "$HOME/Documents/Obsidian Vault"

    if not test -d "$OBSIDIAN_VAULT"
        echo "Error: Obsidian Vault directory not found at $OBSIDIAN_VAULT"
        return 1
    end

    echo "Syncing Obsidian Vault at $OBSIDIAN_VAULT..."
    
    # Save current directory
    set -l current_dir (pwd)
    
    cd "$OBSIDIAN_VAULT"
    
    # Check for changes
    if git status --porcelain | string length -q
        git add .
        set -l timestamp (date "+%Y-%m-%d %H:%M")
        git commit -m "Backup: $timestamp"
        
        echo "Pushing changes to remote..."
        git push
        
        if test $status -eq 0
            echo "✅ Vault successfully synced!"
        else
            echo "❌ Error pushing changes."
        end
    else
        echo "No changes to sync."
        # Pull just in case to be up to date
        git pull
    end
    
    # Return to original directory
    cd "$current_dir"
end
