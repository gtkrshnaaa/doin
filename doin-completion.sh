_doin_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Define the directory where scripts are stored
    local scripts_dir="$HOME/.doin/availsh"

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        # If we are completing the first argument after 'doin'
        if [[ -d "$scripts_dir" ]]; then
            # List all .sh files, remove the .sh extension
            local commands=$(ls "$scripts_dir"/*.sh 2>/dev/null | xargs -n 1 basename | sed 's/\.sh$//')
            # Standard options
            local options="-v --version -h --help -l --list"
            
            COMPREPLY=( $(compgen -W "${commands} ${options}" -- ${cur}) )
        fi
    fi
    return 0
}

complete -F _doin_completions doin
