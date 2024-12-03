# Raccourcis Clés pour Neovim

## Modes
- **Normal Mode** (n) : Mode par défaut pour naviguer et exécuter des commandes.
- **Insert Mode** (i) : Mode pour insérer du texte.
- **Visual Mode** (v) : Mode pour sélectionner du texte.

## Navigation et Édition
### Normal Mode (n)
- 🔼 **Monter de 1 ligne** : `k`
- 🔽 **Descendre de 1 ligne** : `j`
- 🔼🔼 **Monter de 10 lignes** : `10k`
- 🔽🔽 **Descendre de 10 lignes** : `10j`
- ⬅️ **Aller au début de la ligne** : `0`
- ➡️ **Aller à la fin de la ligne** : `$`
- 🔍 **Rechercher le mot sous le curseur** : `<leader>pws`
- ➡️ **Avancer d'un mot** : `w` (ou `W` pour ignorer la ponctuation)
- ⬅️ **Reculer d'un mot** : `b` (ou `B` pour ignorer la ponctuation)
- ➡️ **Avancer au début du mot suivant** : `e` (ou `E` pour ignorer la ponctuation)
- ⬅️ **Retourner à la fin du mot précédent** : `ge` (ou `gE` pour ignorer la ponctuation)

- **Utilisation de Telescope**
  - 🔎 `<leader>pf` : Trouver des fichiers
  - 🔎 `<C-p>` : Trouver des fichiers dans Git
  - 🔎 `<leader>ps` : Chercher du texte dans le fichier
  - 🔎 `<leader>vh` : Afficher l'aide



### Insert Mode (i)
- ✏️ **Sortir en Normal Mode** : `Esc`
- 📋 **Copier** : `<C-c>` (écrase l'action normale)

### Visual Mode (v)
- 🔼 **Monter la sélection** : `Shift + J` (déplace la sélection d'une ligne vers le bas)
- 🔽 **Descendre la sélection** : `Shift + K` (déplace la sélection d'une ligne vers le haut)
- ➡️ **Indenter la sélection à droite** : `>` (en sélectionnant des lignes, il faut être en mode visuel)
- ⬅️ **Indenter la sélection à gauche** : `<` (en sélectionnant des lignes, il faut être en mode visuel)

## Gestion des Fichiers
- 🗂️ **Ouvrir les fichiers** : `<leader>pf` (recherche dans les fichiers du projet)
- 📂 **Ouvrir les fichiers git** : `<C-p>` (recherche dans les fichiers suivis par git)
- 🔍 **Recherche de texte** : `<leader>ps`

## Diagnostics et Complétion
- ✅ **Formater le code** : `<leader>f` (via LSP)
- ✨ **Compléter les suggestions de LSP** : `Tab` ou `Enter` (dans les suggestions)

## Autres Raccourcis
- ⌨️ **Annuler la dernière action** : `u`
- 🔄 **Refaire la dernière action annulée** : `Ctrl + r`
- 🖼️ **Ouvrir la fenêtre d'aide** : `<leader>vh`



# En COURS DE CONSTRUCTION :

`vim.g.mapleader = " "` : Définit la touche leader sur la barre d'espace.

`vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)` : Ouvre l'explorateur de fichiers avec <leader>pv en mode normal.

`vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")` : En mode visuel, déplace la sélection d'une ligne vers le bas et ajuste l'indentation.

`vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")` : En mode visuel, déplace la sélection d'une ligne vers le haut et ajuste l'indentation.

`vim.keymap.set("n", "J", "mzJz")` : Joint la ligne suivante à la ligne actuelle et garde le curseur à sa position initiale.

`vim.keymap.set("n", "<C-d>", "<C-d>zz") `: Descend d'une demi-page et centre l'écran sur la ligne du curseur.

`vim.keymap.set("n", "<C-u>", "<C-u>zz")` : Monte d'une demi-page et centre l'écran sur la ligne du curseur.

`vim.keymap.set("n", "n", "nzzzv") `: Recherche l'occurrence suivante et centre l'écran sur la ligne du curseur.

`vim.keymap.set("n", "N", "Nzzzv")` : Recherche l'occurrence précédente et centre l'écran sur la ligne du curseur.

`vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")`: Redémarre le serveur LSP avec <leader>zig.

`vim.keymap.set("n", "<leader>vwm", function() require("vim-with-me").StartVimWithMe() end)`: Démarre le partage de session Vim avec <leader>vwm.

`vim.keymap.set("n", "<leader>svwm", function() require("vim-with-me").StopVimWithMe() end)` : Arrête le partage de session Vim avec <leader>svwm.

`vim.keymap.set("x", "<leader>p", [["_dP"]])` : Colle sans modifier le registre de coupure en mode visuel.

`vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])` : Copie dans le presse-papiers système en mode normal et visuel.

`vim.keymap.set("n", "<leader>Y", [["+Y]])` : Copie la ligne dans le presse-papiers système en mode normal.

`vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")` : Supprime le texte sans l'enregistrer dans le registre.

`vim.keymap.set("i", "<C-c>", "<Esc>")` : Mappe Ctrl+c pour quitter le mode insertion (comme Esc).

`vim.keymap.set("n", "Q", "<nop>")` : Désactive la touche Q.

`vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")` : Ouvre un nouveau volet dans Tmux avec Ctrl+f.

`vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)` : Formate le code avec LSP en utilisant <leader>f.

`vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")` : Va à l'erreur suivante et centre l'écran sur le curseur.

`vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")` : Va à l'erreur précédente et centre l'écran sur le curseur.

`vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")` : Va à l'emplacement suivant et centre l'écran sur le curseur.

`vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")` : Va à l'emplacement précédent et centre l'écran sur le curseur.

`vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])` : Lance une recherche et remplacement sur le mot sous le curseur.

`vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })` : Rend le fichier actuel exécutable.

`vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")` : Insère un bloc de code if err != nil { ... } et return err.

`vim.keymap.set("n", "<leader>ea", "oassert.NoError(err, \"\")<Esc>F\";a")` : Ajoute une assertion assert.NoError pour vérifier qu'il n'y a pas d'erreur.

`vim.keymap.set("n", "<leader>el", "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i")` : Ajoute un bloc if err != nil qui enregistre l'erreur avec un logger.

`vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")` : Ouvre le fichier de configuration packer.lua de Neovim.

`vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")` : Lance la commande make_it_rain du plugin CellularAutomaton.

`vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)` : Recharge la configuration Vim avec <leader><leader>.
