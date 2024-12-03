def get_current_command_and_path [] {
    let current_line = (commandline)
    let parts = ($current_line | str trim | split row " ")
    let cmd = ($parts | first)
    let has_path = ($parts | length) > 1
    let current_path = if $has_path {
        let path = ($parts | last | str trim)
        if ($path | str starts-with "~") {
            ($path | path expand)
        } else {
            $path
        }
    } else {
        "."
    }

    {
        command: $cmd,
        path: $current_path
    }
}

def get_fzf_command [context: record] {
    let base_path = if ($context.path | path exists) {
        $context.path
    } else {
        "."
    }

    let is_dir_only = $context.command == "cd"

    let fd_cmd = if $is_dir_only {
        $"^fd --type d --hidden --exclude .git . ($base_path)"
    } else {
        $"^fd --type f --hidden --exclude .git . ($base_path)"
    }

    let preview_cmd = if $is_dir_only {
        "eza --tree --color=always {} | head -200"
    } else {
        "bat --color=always --line-range :500 {}"
    }

    {
        fd: $fd_cmd,
        preview: $preview_cmd,
        base_path: $base_path
    }
}

$env.config = ($env.config | upsert keybindings [
    {
        name: fuzzy_file_fzf
        modifier: control
        keycode: char_f
        mode: [emacs, vi_normal, vi_insert]
        event: {
            send: executehostcommand
            cmd: "let ctx = (get_current_command_and_path);
                 let fzf_cmd = (get_fzf_command $ctx);
                 let selected = (
                    nu -c $fzf_cmd.fd
                    | ^fzf --height 80%
                          --layout=reverse
                          --border
                          --preview $fzf_cmd.preview
                    | str trim
                 );
                 if not ($selected | is-empty) {
                    let current = ($ctx.path | str trim -r -c '/');
                    let to_insert = if ($selected | str starts-with $current) {
                        $selected | str replace $current ''
                    } else {
                        $selected | str replace ($current | path basename) ''
                    };
                    let has_trailing_slash = ($ctx.path | str ends-with '/');
                    let clean_insert = if $has_trailing_slash {
                        ($to_insert | str trim -l -c '/')
                    } else {
                        $to_insert
                    };
                    # S'assurer que le chemin est relatif si nécessaire
                    let final_insert = if ($clean_insert | str starts-with '/') {
                        ($clean_insert | str substring 1..)
                    } else {
                        $clean_insert
                    };
                    commandline edit --insert $final_insert
                 }"
        }
    }
])
