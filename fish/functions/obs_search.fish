function obs_search
    set -q OBSIDIAN_VAULT; or set OBSIDIAN_VAULT "$HOME/Documents/Obsidian Vault"
    
    if test (count $argv) -eq 0
        echo "Usage: obs_search <search_term>"
        return 1
    end
    
    if not test -d "$OBSIDIAN_VAULT"
        echo "Error: Obsidian Vault directory not found at $OBSIDIAN_VAULT"
        return 1
    end

    if type -q rg
        rg -i "$argv" "$OBSIDIAN_VAULT"
    else
        grep -r -i "$argv" "$OBSIDIAN_VAULT"
    end
end

