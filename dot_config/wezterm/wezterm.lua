local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { 'nu' }
-- Utiliser le schéma de couleurs Tokyo Night Storm
config.color_scheme = 'Tokyo Night Storm'

-- Configurer la police
config.font = wezterm.font("UbuntuMono Nerd Font")
config.font_size = 19

-- Désactiver la barre d'onglets
config.enable_tab_bar = false

-- Masquer complètement la barre de titre
config.window_decorations = "NONE"

-- Opacité de la fenêtre
config.window_background_opacity = 0.90

-- Configuration des domaines SSH
config.ssh_domains = {
    {
        name = "nas_cloud",
        remote_address = "10.42.69.30",
        username = "apo",
    },
    {
        name = "multimedia",
        remote_address = "10.42.69.36",
        username = "apo",
    },
    {
        name = "k8s_master",
        remote_address = "10.42.69.99",
        username = "apo",
    },
    {
        name = "k8s_worker1",
        remote_address = "10.42.69.100",
        username = "apo",
    },
    {
        name = "k8s_worker2",
        remote_address = "10.42.69.102",
        username = "apo",
    },
    {
        name = "proxmox",
        remote_address = "10.42.169.200",
        username = "root",
    },
    {
        name = "proxmox_backup",
        remote_address = "10.42.169.203",
        username = "root",
    },
}

-- Configurer les raccourcis clavier pour un clavier AZERTY
config.keys = {

    {
        key = "q",
        mods = "ALT",
        action = wezterm.action.SendKey {
            key = "LeftArrow"
        }
    },
    {
        key = "r",
        mods = "ALT",
        action = wezterm.action.SendKey {
            key = "UpArrow"
        }
    },

    {
        key = "f",
        mods = "ALT",
        action = wezterm.action.SendKey {
            key = "DownArrow"
        }
    },

    {
        key = "d",
        mods = "ALT",
        action = wezterm.action.SendKey {
            key = "RightArrow"
        }
    },


    -- Créer un nouveau volet horizontal avec Ctrl + Maj + T
    {
        key = "T",
        mods = "CTRL|SHIFT",
        action = wezterm.action {
            SplitHorizontal = {
                domain = "CurrentPaneDomain"
            }
        }
    },

    -- Créer un nouveau volet vertical avec Ctrl + Maj + L
    {
        key = "L",
        mods = "CTRL|SHIFT",
        action = wezterm.action {
            SplitVertical = {
                domain = "CurrentPaneDomain"
            }
        }
    },

    -- Passer au volet suivant avec Ctrl + Maj + Tab
    { key = "Tab",      mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Next" } },

    -- Passer au volet précédent avec Ctrl + Maj + S
    { key = "S",        mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Prev" } },

    -- Copier dans le presse-papier avec Ctrl + Maj + C
    { key = "C",        mods = "CTRL|SHIFT", action = wezterm.action { CopyTo = "Clipboard" } },

    -- Coller depuis le presse-papier avec Ctrl + Maj + V
    { key = "V",        mods = "CTRL|SHIFT", action = wezterm.action { PasteFrom = "Clipboard" } },

    -- Fermer le volet avec Ctrl + Maj + W
    { key = "W",        mods = "CTRL|SHIFT", action = wezterm.action { CloseCurrentPane = { confirm = true } } },

    -- Naviguer vers le volet de gauche avec Ctrl + Maj + Left
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Left" } },

    -- Naviguer vers le volet de droite avec Ctrl + Maj + Right
    { key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Right" } },

    -- Naviguer vers le volet du haut avec Ctrl + Maj + Up
    { key = "UpArrow",  mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Up" } },

    -- Naviguer vers le volet du bas avec Ctrl + Maj + Down
    { key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Down" } },

    -- Se connecter aux différents serveurs SSH dans un nouveau volet horizontal
    { key = "1",        mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain", args = { "ssh", "apo@10.42.69.30" } } } },
    { key = "2",        mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain", args = { "ssh", "apo@10.42.69.36" } } } },
    { key = "3",        mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain", args = { "ssh", "apo@10.42.69.99" } } } },
    { key = "4",        mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain", args = { "ssh", "apo@10.42.69.100" } } } },
    { key = "5",        mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain", args = { "ssh", "apo@10.42.69.102" } } } },
    { key = "6",        mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain", args = { "ssh", "root@10.42.169.200" } } } },
    { key = "7",        mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain", args = { "ssh", "root@10.42.169.203" } } } },
}

-- Retourner la configuration à wezterm
return config
