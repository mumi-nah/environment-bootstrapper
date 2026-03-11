#!/bin/bash
set -eu

if [[ ! -d $1 ]]; then
    mkdir -p "$1" && cd "$1"
    echo "created project folder"
else
    cd "$1"
fi

touch "$1"/setup.log
log_file=setup.log


COLOR_INFO='\033[0;36m'
COLOR_SUC='\033[0;32m'
COLOR_WARN='\033[0;31m'
COLOR_ERR='\033[0;31m'
COLOR_NC='\033[0m'

log_info() {
    local msg="[INFO] $(date): $1"
    echo -e "${COLOR_INFO}${msg}${COLOR_NC}"
    echo "$msg" >> "$log_file"
}

log_suc() {
    local msg="[SUCCESS] $(date): $1"
    echo -e "${COLOR_SUC}${msg}${COLOR_NC}"
    echo "msg" >> "$log_file"
}

log_warn() {
    local msg="[WARNING] $(date): $1"
    echo -e "${COLOR_WARN}${msg}${COLOR_NC}"
    echo -e "msg" >> "$log_file"
}

log_err() {
    local msg="[ERROR] $(date): $1"
    echo -e "${COLOR_ERR}${msg}${COLOR_NC}"
    echo -e "msg" >> "$log_file"
}


create_venv() {
    if [ -d ".venv/" ]; then
        log_info "virtual environment already exists"
        source .venv/bin/activate
        log_suc "activated existing virtual environment"
    else
        python3 -m venv .venv
        log_info "created virtual environment"
        source .venv/bin/activate
        log_suc "activated virtual environment"
    fi
}

upgrade_pip() {
    current_version=$(python3 -m pip --version | awk '{print $2}')
    latest_version=$(pip index versions pip 2>/dev/null | head -n 1 | awk '{print $NF}')
    if [ "$current_version" == "$latest_version" ]; then
        log_info "pip is up-to-date"
    else
        python3 -m pip install --upgrade pip  >> "$log_file" 2>&1
        log_suc "pip ugrade successful!"
    fi
}

create_gitignore() {
GITIGNORE_FILE=".gitignore"
    if [ -f "$GITIGNORE_FILE" ]; then
        log_warn "$GITIGNORE_FILE already exists"
    else
        cat > "$GITIGNORE_FILE" <<EOF
.venv/
venv/
*.pyc
__pycache__/
.pytest_cache/
.vscode/
.idea/
*.tmp
EOF
        log_suc "$GITIGNORE_FILE created successfully."
    fi
}


install_packages() {
    packages=("pandas" "requests")

    for pkg in "${packages[@]}"; do
        if ! python3 -m pip show "$pkg" > /dev/null 2>&1; then
            log_info "Installing $pkg..."
            python3 -m pip install "$pkg" >> "$log_file" 2>&1
            log_suc "$pkg Installed successfully!."
        else
            log_suc "$pkg Installed successfully!."
        fi
    done

}

main() {
    create_venv
    upgrade_pip
    create_gitignore
    install_packages
    log_suc "Environment setup completed!, environment is ready for use"
}

main
