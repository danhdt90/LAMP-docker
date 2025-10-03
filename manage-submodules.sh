#!/bin/bash

# Script to manage submodules selectively
# Usage: ./manage-submodules.sh [command] [submodule_name]

SUBMODULES=("propolife-webs")

show_help() {
    echo "Usage: $0 [command] [submodule_name]"
    echo ""
    echo "Commands:"
    echo "  status              - Show status of all submodules"
    echo "  init <name>         - Initialize specific submodule"
    echo "  clean-init <name>   - Clean directory and initialize submodule"
    echo "  update <name>       - Update specific submodule"
    echo "  pull <name>         - Pull latest changes for specific submodule"
    echo "  deinit <name>       - Deinitialize specific submodule"
    echo "  list                - List available submodules"
    echo ""
    echo "Available submodules:"
    for sub in "${SUBMODULES[@]}"; do
        echo "  - $sub"
    done
}

case "$1" in
    "status")
        echo "=== Submodule Status ==="
        git submodule status
        ;;
    "init")
        if [ -z "$2" ]; then
            echo "Error: Please specify submodule name"
            show_help
            exit 1
        fi
        echo "Initializing submodule: $2"
        
        # Check if directory exists and is not a git repository
        if [ -d "src/$2" ] && [ ! -d "src/$2/.git" ]; then
            echo "⚠️  Directory src/$2 exists but is not a git repository"
            echo "Backing up existing content..."
            
            # Create backup directory
            backup_dir="src/${2}_backup_$(date +%Y%m%d_%H%M%S)"
            mv "src/$2" "$backup_dir"
            echo "✅ Existing content backed up to: $backup_dir"
        fi
        
        # Initialize the submodule
        if git submodule update --init "src/$2"; then
            echo "✅ Submodule $2 initialized successfully!"
            
            # If there was a backup, offer to restore non-git files
            if [ -d "$backup_dir" ]; then
                echo ""
                echo "📋 Backup available at: $backup_dir"
                echo "You can manually copy any custom files you need from the backup."
            fi
        else
            echo "❌ Failed to initialize submodule $2"
            
            # Restore backup if initialization failed
            if [ -d "$backup_dir" ]; then
                echo "Restoring backup..."
                mv "$backup_dir" "src/$2"
                echo "✅ Backup restored"
            fi
            exit 1
        fi
        ;;
    "clean-init")
        if [ -z "$2" ]; then
            echo "Error: Please specify submodule name"
            show_help
            exit 1
        fi
        echo "Clean initializing submodule: $2"
        
        # Force remove existing directory if it exists
        if [ -d "src/$2" ]; then
            echo "🗑️  Removing existing directory src/$2..."
            rm -rf "src/$2"
            echo "✅ Directory cleaned"
        fi
        
        # Initialize the submodule
        if git submodule update --init "src/$2"; then
            echo "✅ Submodule $2 clean initialized successfully!"
        else
            echo "❌ Failed to initialize submodule $2"
            exit 1
        fi
        ;;
    "update")
        if [ -z "$2" ]; then
            echo "Error: Please specify submodule name"
            show_help
            exit 1
        fi
        echo "Updating submodule: $2"
        git submodule update "src/$2"
        ;;
    "pull")
        if [ -z "$2" ]; then
            echo "Error: Please specify submodule name"
            show_help
            exit 1
        fi
        echo "Pulling latest changes for submodule: $2"
        git submodule update --remote "src/$2"
        ;;
    "deinit")
        if [ -z "$2" ]; then
            echo "Error: Please specify submodule name"
            show_help
            exit 1
        fi
        echo "Deinitializing submodule: $2"
        git submodule deinit "src/$2"
        ;;
    "list")
        echo "Available submodules:"
        for sub in "${SUBMODULES[@]}"; do
            echo "  - $sub"
        done
        ;;
    *)
        show_help
        ;;
esac
