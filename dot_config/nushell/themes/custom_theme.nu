# Retrieve the theme settings
export def main [] {
    return {
        binary: '#bb9af7'
        block: '#7aa2f7'
        cell-path: '#a9b1d6'
        closure: '#7dcfff'
        custom: '#c0caf5'
        duration: '#e0af68'
        float: '#7dcfff'
        glob: '#c0caf5'
        int: '#bb9af7'
        list: '#7dcfff'
        nothing: '#f7768e'
        range: '#e0af68'
        record: '#7dcfff'
        string: '#836ace'

        bool: {|| if $in { '#7dcfff' } else { '#e0af68' } }

        date: {|| (date now) - $in |
            if $in < 1hr {
                { fg: '#f7768e' attr: 'b' }
            } else if $in < 6hr {
                '#f7768e'
            } else if $in < 1day {
                '#e0af68'
            } else if $in < 3day {
                '#7aa2f7'
            } else if $in < 1wk {
                { fg: '#7aa2f7' attr: 'b' }
            } else if $in < 6wk {
                '#7dcfff'
            } else if $in < 52wk {
                '#7aa2f7'
            } else { 'dark_gray' }
        }

        filesize: {|e|
            if $e == 0b {
                '#a9b1d6'
            } else if $e < 1mb {
                '#7dcfff'
            } else {{ fg: '#7aa2f7' }}
        }

        # Opérateurs et symboles
        shape_and: { fg: '#bb9af7' attr: 'b' }
        shape_binary: { fg: '#bb9af7' attr: 'b' }
        shape_block: { fg: '#7aa2f7' attr: 'b' }
        shape_bool: '#7dcfff'
        shape_closure: { fg: '#7dcfff' attr: 'b' }
        shape_datetime: { fg: '#7dcfff' attr: 'b' }
        shape_directory: '#7dcfff'
        shape_filepath: '#7dcfff'
        shape_flag: { fg: '#7dcfff' }
        shape_float: { fg: '#7dcfff' attr: 'b' }
        shape_garbage: { fg: '#FFFFFF' bg: '#FF0000' attr: 'b' }
        shape_glob_interpolation: { fg: '#7dcfff' attr: 'b' }
        shape_globpattern: { fg: '#7dcfff' attr: 'b' }
        shape_int: { fg: '#bb9af7' attr: 'b' }
        shape_keyword: { fg: '#bb9af7' attr: 'b' }
        shape_list: { fg: '#7dcfff' attr: 'b' }
        shape_literal: '#7aa2f7'
        shape_match_pattern: '#7aa2f7'
        shape_matching_brackets: { attr: 'u' }
        shape_nothing: '#f7768e'
        shape_operator: '#e0af68'
        shape_or: { fg: '#bb9af7' attr: 'b' }
        shape_pipe: { fg: '#bb9af7' attr: 'b' }
        shape_range: { fg: '#e0af68' attr: 'b' }
        shape_raw_string: { fg: '#c0caf5' attr: 'b' }
        shape_record: { fg: '#7dcfff' attr: 'b' }
        shape_redirection: { fg: '#bb9af7' attr: 'b' }
        shape_signature: { fg: '#7aa2f7' attr: 'b' }
        shape_string: '#7aa2f7'
        shape_string_interpolation: { fg: '#7dcfff' attr: 'b' }
        shape_table: { fg: '#7aa2f7' attr: 'b' }
        shape_vardecl: { fg: '#7aa2f7' attr: 'u' }
        shape_variable: '#bb9af7'

        # Commandes externes
        shape_external: { fg: '#f7768e' attr: 'b' }          # Non reconnues (rouge gras)
        shape_external_resolved: '#9ece6a'                   # Reconnues (vert)
        shape_externalarg: { fg: '#7dcfff' }                # Arguments (bleu)

        # Commandes internes
        shape_internalcall: '#9ece6a'                       # Appels internes (vert)
        shape_internal_name: '#9ece6a'                      # Noms internes (vert)
        shape_builtin: '#9ece6a'                           # Commandes builtin (vert)
        shape_custom: '#9ece6a'                            # Commandes customisées (vert)
        shape_directory_extension: '#9ece6a'               # Extensions (vert)

        # Couleurs de base
        foreground: '#c0caf5'
        background: '#24283b'
        cursor: '#c0caf5'

        # Éléments d'interface
        empty: '#7aa2f7'
        header: { fg: '#7aa2f7' attr: 'b' }
        hints: '#414868'
        leading_trailing_space_bg: { attr: 'n' }
        row_index: { fg: '#7aa2f7' attr: 'b' }
        search_result: { fg: '#f7768e' bg: '#a9b1d6' }
        separator: '#a9b1d6'
    }
}

export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

export def "update terminal" [] {
    let theme = (main)
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'

    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

use activate
