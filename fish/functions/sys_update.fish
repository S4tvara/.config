function sys_update
    echo "🔄 Starting System Update..."
    
    # APT Update
    echo "📦 Updating APT repositories..."
    sudo apt update
    
    echo "📦 Upgrading APT packages..."
    sudo apt full-upgrade -y
    
    echo "🧹 Removing unused packages..."
    sudo apt autoremove -y
    sudo apt autoclean
    
    # Flatpak Update
    if type -q flatpak
        echo "📦 Updating Flatpaks..."
        flatpak update -y
    end
    
    # Snap Update (if present)
    if type -q snap
        echo "📦 Updating Snaps..."
        sudo snap refresh
    end

    # Firmware Update (fwupdmgr)
    if type -q fwupdmgr
        echo "📦 Checking for firmware updates..."
        fwupdmgr get-updates
        # We don't auto-update firmware as it might require reboot/confirmation
        echo "  (Run 'fwupdmgr update' manually if updates are available)"
    end
    
    echo "✅ System update complete!"
end

