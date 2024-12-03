def get_icon [type: string, name: string] {
    match $type {
        "dir" => {
            # Dossiers spéciaux
            let dirname = ($name | path parse).stem
            match $dirname {
                ".git" => "" # nf-dev-git
                "node_modules" => "" # nf-dev-nodejs_small
                "src" | "source" => "" # nf-md-folder_code
                "dist" | "build" => "󱁿" # nf-md-folder_cog
                "docs" | "documentation" => "󱂷" # nf-md-folder_information
                "config" | "conf" => "󱁿" # nf-md-folder_cog
                "assets" | "images" | "img" => "󰉏" # nf-md-folder_image
                "components" => "󰉓" # nf-md-folder_multiple
                ".vscode" => "" # nf-dev-vscode
                _ => "" # nf-oct-file_directory
            }
        }
        "file" => {
            # Extension basée sur le nom de fichier
            let ext = ($name | path parse).extension
            let filename = ($name | path parse).stem

            # Check filename first
            let name_match = match $filename {
                "Dockerfile" => "" # nf-dev-docker
                "docker-compose.yml" | "docker-compose.yaml" => "" # nf-dev-docker
                "package.json" => "" # nf-dev-npm
                "package-lock.json" => "" # nf-dev-npm_old
                "Cargo.toml" => "🦀" # Rust crate
                "CMakeLists.txt" => "" # nf-seti-config
                "Makefile" => "" # nf-dev-terminal
                ".gitignore" | ".gitattributes" => "" # nf-dev-git
                "README" | "CHANGELOG" | "LICENSE" => "" # nf-fa-book
                ".env" => "" # nf-dev-terminal
                "requirements.txt" => "" # nf-dev-python
                _ => ""
            }

            if ($name_match != "") {
                $name_match
            } else {
                # Check extension
                match $ext {
                    # DevOps & Cloud
                    "tf" | "tfvars" => "󱁢" # nf-dev-terraform
                    "hcl" => "󱁢" # nf-dev-terraform
                    "tfstate" | "tfstate.backup" => "󱁢" # nf-dev-terraform
                    "yaml" | "yml" => "" # nf-dev-yaml
                    "json" => "" # nf-dev-code_json
                    "toml" => "" # nf-dev-code_array
                    "env" => "" # nf-dev-terminal

                    # Shell & Scripts
                    "sh" | "bash" | "zsh" => "" # nf-dev-terminal
                    "fish" | "nu" => "󰈺" # nf-dev-terminal_badge

                    # Web Development
                    "html" => "" # nf-dev-html5
                    "css" => "" # nf-dev-css3
                    "scss" | "sass" => "" # nf-dev-sass
                    "js" => "" # nf-dev-javascript
                    "ts" => "󰛦" # nf-seti-typescript
                    "jsx" | "tsx" => "" # nf-dev-react
                    "vue" => "﵂" # nf-seti-vue
                    "svelte" => "" # nf-seti-svelte

                    # Programming Languages
                    "py" => "" # nf-dev-python
                    "rs" => "🦀" # Rust
                    "go" => "" # nf-dev-go
                    "rb" => "" # nf-dev-ruby
                    "php" => "" # nf-dev-php
                    "java" => "" # nf-dev-java
                    "class" => "" # nf-dev-java
                    "kt" => "" # nf-dev-kotlin
                    "cpp" | "hpp" | "cc" | "hh" => "" # nf-dev-cpp
                    "c" | "h" => "" # nf-dev-c
                    "cs" => "" # nf-dev-csharp
                    "swift" => "" # nf-dev-swift
                    "scala" => "" # nf-dev-scala

                    # Data & Config
                    "xml" => "󰗀" # nf-dev-code_braces
                    "csv" => "" # nf-fa-table
                    "sql" => "" # nf-dev-database
                    "db" | "sqlite" | "sqlite3" => "" # nf-dev-database
                    "conf" | "config" => "" # nf-dev-gear
                    "ini" => "" # nf-dev-gear

                    # Documentation
                    "md" => "" # nf-oct-markdown
                    "rst" => "" # nf-fa-file_text
                    "txt" => "" # nf-fa-file_text_o
                    "pdf" => "" # nf-fa-file_pdf_o
                    "doc" | "docx" => "" # nf-fa-file_word_o
                    "xls" | "xlsx" => "" # nf-fa-file_excel_o
                    "ppt" | "pptx" => "" # nf-fa-file_powerpoint_o

                    # Images
                    "png" | "jpg" | "jpeg" | "gif" | "bmp" => "" # nf-fa-file_image_o
                    "svg" => "󰜡" # nf-dev-svg
                    "ico" => "" # nf-fa-file_image_o

                    # Archives
                    "zip" | "tar" | "gz" | "7z" | "rar" => "" # nf-fa-file_zip_o

                    # Other
                    "log" => "" # nf-fa-file_text_o
                    "lock" => "" # nf-fa-lock
                    _ => "" # nf-fa-file_o
                }
            }
        }
        _ => "" # nf-fa-question
    }
}


def ls_with_icons [path?: path] {
    let target_path = if ($path == null) { "." } else { $path }

    # Sauvegarde la config actuelle
    let original_config = $env.config.ls.use_ls_colors

    # Active temporairement les couleurs
    $env.config.ls.use_ls_colors = true

    # Exécute ls avec les couleurs
    let result = (ls $target_path
    | each { |entry|
        let icon = (get_icon $entry.type $entry.name)
        {
            name: $"($icon) ($entry.name)"
            type: $entry.type
            size: $entry.size
            modified: $entry.modified
        }
    }
    | sort-by type name)

    # Restaure la config originale
    $env.config.ls.use_ls_colors = $original_config

    # Retourne le résultat
    $result
}

alias ls = ls_with_icons
