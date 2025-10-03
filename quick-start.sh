#!/bin/bash

# LAMP Docker Quick Start Script
# This script provides an interactive menu for optimizing VS Code workspace

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

print_logo() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════╗"
    echo "║                    🚀 LAMP Docker Quick Start                 ║"
    echo "║                  Performance Optimization Tool                ║"
    echo "╚═══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_menu() {
    echo -e "${BOLD}Choose your workflow:${NC}"
    echo ""
    echo -e "${GREEN}🎯 FOCUSED WORKFLOWS (Recommended)${NC}"
    echo "  1.  Work on PropoLife Webs (WordPress/Portfolio)"
    echo ""
    echo -e "${YELLOW}⚡ PERFORMANCE MODES${NC}"
    echo "  2. 🔧 Docker Management Only (Hide All Projects)"
    echo "  3. 👁️ Show All Projects (May impact performance)"
    echo ""
    echo -e "${BLUE}🛠️ UTILITIES${NC}"
    echo "  4. 📊 Show Current Status"
    echo "  5. 🧹 Clean Cache Files"
    echo "  6. ❓ Help & Tips"
    echo "  0. 🚪 Exit"
    echo ""
}

show_project_info() {
    local project="$1"
    
    case $project in
        "propolife-webs")
            echo -e "${GREEN}🌐 PropoLife Webs${NC}"
            echo "  📁 Location: src/propolife-webs"
            echo "  🛠️ Tech Stack: WordPress, PHP"
            echo "  🌐 Domains: http://propolife-webs.test, http://logprostyle.test"
            echo "  📖 Purpose: Portfolio and business websites"
            ;;
    esac
}

show_tips() {
    echo -e "${CYAN}💡 Performance Tips:${NC}"
    echo ""
    echo "🚀 Speed Improvements:"
    echo "  • Focused mode reduces file indexing by 70-80%"
    echo "  • Copilot responds faster with less context"
    echo "  • Search operations are significantly faster"
    echo "  • Memory usage is reduced substantially"
    echo ""
    echo "🔧 Best Practices:"
    echo "  • Always restart VS Code after changing modes"
    echo "  • Use focused mode when working on specific projects"
    echo "  • Run 'clean' regularly to remove cache files"
    echo "  • Use Docker management mode for infrastructure work"
    echo ""
    echo "📊 Current Workspace Size:"
    if command -v du >/dev/null 2>&1; then
        echo "  • Total size: $(du -sh . 2>/dev/null | cut -f1)"
        if [ -d "src" ]; then
            echo "  • Projects size: $(du -sh src 2>/dev/null | cut -f1)"
        fi
        if [ -d "data" ]; then
            echo "  • Docker data: $(du -sh data 2>/dev/null | cut -f1)"
        fi
    fi
    echo ""
    echo "🛠️ Available Commands:"
    echo "  ./optimize-workspace.sh focus <project>  # Focus on specific project"
    echo "  ./optimize-workspace.sh hide-all         # Maximum performance"
    echo "  ./optimize-workspace.sh show-all         # Show everything"
    echo "  ./optimize-workspace.sh status           # Check current state"
    echo "  ./optimize-workspace.sh clean            # Clean cache files"
    echo ""
}

execute_choice() {
    local choice="$1"
    
    case $choice in
        1)
            echo ""
            show_project_info "propolife-webs"
            echo ""
            echo -e "${YELLOW}Optimizing workspace for PropoLife Webs...${NC}"
            ./optimize-workspace.sh focus propolife-webs
            echo ""
            echo -e "${GREEN}✅ Ready to work on PropoLife Webs!${NC}"
            echo "💡 Restart VS Code for best performance"
            ;;
        2)
            echo ""
            echo -e "${YELLOW}Activating Docker Management Mode...${NC}"
            ./optimize-workspace.sh hide-all
            echo ""
            echo -e "${GREEN}✅ Docker management mode activated!${NC}"
            echo "🔧 All submodules hidden for maximum performance"
            echo "💡 Perfect for Docker configuration and debugging"
            ;;
        3)
            echo ""
            echo -e "${YELLOW}Showing all projects...${NC}"
            ./optimize-workspace.sh show-all
            echo ""
            echo -e "${GREEN}✅ All projects are now visible${NC}"
            echo -e "${RED}⚠️ Performance may be impacted with all projects visible${NC}"
            echo "💡 Consider using focused mode for better performance"
            ;;
        4)
            echo ""
            ./optimize-workspace.sh status
            ;;
        5)
            echo ""
            echo -e "${YELLOW}Cleaning cache files...${NC}"
            ./optimize-workspace.sh clean
            echo ""
            echo -e "${GREEN}✅ Cache cleaning completed!${NC}"
            ;;
        6)
            echo ""
            show_tips
            ;;
        0)
            echo ""
            echo -e "${GREEN}Thanks for using LAMP Docker Quick Start! 👋${NC}"
            exit 0
            ;;
        *)
            echo ""
            echo -e "${RED}❌ Invalid choice. Please try again.${NC}"
            ;;
    esac
}

# Main interactive loop
main() {
    # Check if we're in the correct directory
    if [ ! -f "docker-compose.yml" ]; then
        echo -e "${RED}❌ This script must be run from the LAMP-docker root directory${NC}"
        exit 1
    fi
    
    # Check if optimize-workspace.sh exists
    if [ ! -f "optimize-workspace.sh" ]; then
        echo -e "${RED}❌ optimize-workspace.sh not found. Please run from the correct directory.${NC}"
        exit 1
    fi
    
    while true; do
        clear
        print_logo
        print_menu
        
        echo -n "Enter your choice (0-6): "
        read -r choice
        
        execute_choice "$choice"
        
        if [ "$choice" != "0" ]; then
            echo ""
            echo -e "${CYAN}Press Enter to continue...${NC}"
            read -r
        else
            break
        fi
    done
}

# Run the main function
main "$@"
