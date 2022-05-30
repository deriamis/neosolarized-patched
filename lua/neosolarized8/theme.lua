local M = {}

M.setup = function(config)
    config = require('neosolarized8.config').new(config)
    local real_apply = M.apply
    M.apply = function()
        real_apply(config)
    end
    return M
end

M.apply = function(config)
    config = config or require('neosolarized8.config').new()

    local palette = require('neosolarized8.palette').config(config)

    local Color = require('colorbuddy.init').Color
    local colors = require('colorbuddy.init').colors
    local Group = require('colorbuddy.init').Group
    local groups = require('colorbuddy.init').groups
    local styles = require('colorbuddy.init').styles

    vim.g.colors_name = 'neosolarized8_' .. config.theme

    -- Clear existing syntax highlighting
    vim.o.termguicolors = true
    if config.theme == "midnight" then
        vim.o.background = "dark"
    else
        vim.o.background = config.theme
    end
    vim.cmd [[ highlight clear ]]
    if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end

    for color_name, color_value in pairs(palette) do
        Color.new(color_name, color_value)
    end

    -- Generic highlight groups
    Group.new('Error', colors.red)
    Group.new('Warning', colors.yellow)
    Group.new('Information', colors.blue)
    Group.new('Hint', colors.cyan)

    local foreground = (config.theme == "light") and colors.base3 or colors.base0

    -- Modal highlighting
    if config.transparent then
        Group.new('Normal', foreground, nil, styles.none)
        Group.new('NormalNC', foreground, nil, styles.none)
    else
        Group.new('Normal', foreground, colors.base03, styles.none)
        Group.new('NormalNC', foreground, colors.base03, styles.none)
    end
    Group.new('Visual', colors.base01, colors.base03, styles.reverse)
    Group.new('VisualNOS', colors.none, colors.base02, styles.reverse)

    -- UI highlighting
    Group.new('Directory', colors.blue, colors.none, styles.none)
    Group.new('ErrorMsg', colors.red, colors.none, styles.reverse)
    Group.new('FoldColumn', colors.base0, colors.base02, styles.none)
    Group.new('Folded', colors.base0, colors.base02, styles.bold, colors.base03)
    Group.link('Terminal', groups.Normal)
    Group.new('ToolbarButton', colors.base1, colors.base02, styles.bold)
    Group.new('ToolbarLine', colors.none, colors.base02, styles.none)
    Group.new('CursorLine', colors.none, colors.base02:dark(0.03), styles.none, colors.base1:dark(0.03))
    Group.new('LineNr', colors.base01, colors.none, styles.none)
    Group.new('FloatBorder', colors.base1, colors.none, styles.none)
    Group.new('ColorColumn', colors.none, colors.base02:dark(0.03), styles.none)
    Group.new('Cursor', colors.base03, colors.base0, styles.none)
    Group.link('lCursor', groups.Cursor)
    Group.link('TermCursor', groups.Cursor)
    Group.new('TermCursorNC', colors.base03, colors.base01)
    Group.new('IncSearch', colors.orange, colors.none, styles.standout)
    Group.new('Search', colors.yellow, colors.none, styles.reverse)
    Group.new('MoreMsg', colors.blue, colors.none, styles.none)
    Group.new('ModeMsg', colors.blue, colors.none, styles.none)
    Group.new('Question', colors.cyan, colors.none, styles.bold)
    Group.new('WarningMsg', colors.red, colors.none, styles.none)
    Group.new('WildMenu', colors.base2, colors.base02, styles.reverse)
    Group.new('SignColumn', colors.base0, colors.none, styles.none)
    Group.new('Conceal', colors.blue, colors.none, styles.none)

    if config.diffmode == 'low' then
        Group.new('DiffAdd', colors.green, colors.none, styles.bold, colors.green)
        Group.new('DiffChange', colors.yellow, colors.none, styles.bold, colors.yellow)
        Group.new('DiffDelete', colors.red, colors.none, styles.bold)
        Group.new('DiffText', colors.blue, colors.none, styles.bold, colors.blue)
    elseif config.diffmode == 'high' then
        Group.new('DiffAdd', colors.green, colors.none, styles.reverse)
        Group.new('DiffChange', colors.yellow, colors.none, styles.reverse)
        Group.new('DiffDelete', colors.red, colors.none, styles.reverse)
        Group.new('DiffText', colors.blue, colors.none, styles.reverse)
    else
        Group.new('DiffAdd', colors.green, colors.base02, styles.none, colors.green)
        Group.new('DiffChange', colors.yellow, colors.base02, styles.none, colors.yellow)
        Group.new('DiffDelete', colors.red, colors.base02, styles.bold)
        Group.new('DiffText', colors.blue, colors.base02, styles.none, colors.blue)
    end

    if config.statusline == 'low' then
        Group.new('StatusLine', colors.base01, colors.base2, styles.reverse)
        Group.new('StatusLineNC', colors.base01, colors.base02, styles.reverse)
        Group.new('TabLine', colors.base01, colors.base02, styles.reverse)
        Group.new('TabLineFill', colors.base01, colors.base02, styles.reverse)
        Group.new('TabLineSel', colors.base0, colors.base3, styles.reverse)
        Group.new('VertSplit', colors.base01, colors.none, styles.none)
    elseif config.statusline == 'high' then
        Group.new('StatusLine', colors.base02, colors.base2, styles.reverse)
        Group.new('StatusLineNC', colors.base02, colors.base1, styles.reverse)
        Group.new('TabLine', colors.base01, colors.base02, styles.none)
        Group.new('TabLineFill', colors.base01, colors.base02, styles.none)
        Group.new('TabLineSel', colors.base2, colors.base02, styles.none)
        Group.new('VertSplit', colors.base02, colors.none, styles.none)
    else
        Group.new('StatusLine', colors.base0, colors.base02, styles.reverse)
        Group.new('StatusLineNC', colors.base01, colors.base02, styles.reverse)
        Group.new('TabLine', colors.base01, colors.base02, styles.reverse)
        Group.new('TabLineFill', colors.base01, colors.base02, styles.reverse)
        Group.new('TabLineSel', colors.base0, colors.base02, styles.reverse)
        Group.new('VertSplit', colors.base01, colors.none, styles.none)
    end

    Group.link('StatusLineTerm', groups.StatusLine)
	Group.link('NormalMode', groups.StatusLine)
	Group.link('InsertMode', groups.StatusLine)
	Group.link('ReplaceMode', groups.StatusLine)
	Group.link('VisualMode', groups.StatusLine)
	Group.link('CommandMode', groups.StatusLine)
    Group.link('StatusLineTermNC', groups.StatusLineNC)

    if config.visibility == 'high' then
        Group.new('CursorLineNr', colors.orange, colors.base02, styles.bold)
        Group.new('LineNr', colors.base0, colors.base02, styles.none)
        Group.new('NonText', colors.orange, colors.none, styles.bold)
        Group.new('SpecialKey', colors.orange, colors.none, styles.reverse)
        Group.new('SpellBad', colors.violet, colors.base3, styles.undercurl + styles.reverse, colors.red)
        Group.new('SpellCap', colors.violet, colors.base3, styles.undercurl + styles.reverse, colors.red)
        Group.new('SpellLocal', colors.yellow, colors.base3, styles.undercurl + styles.reverse, colors.red)
        Group.new('SpellRare', colors.cyan, colors.base3, styles.undercurl + styles.reverse, colors.red)
        Group.new('Title', colors.orange, colors.none, styles.bold)
        Group.new('MatchParen', colors.red, colors.base01, styles.bold + styles.reverse)
    elseif config.visibility == 'low' then
        Group.new('CursorLineNr', colors.base01, colors.base02, styles.bold)
        Group.new('LineNr', colors.base01, colors.base02, styles.none)
        Group.new('NonText', colors.base02, colors.none, styles.bold)
        Group.new('SpecialKey', colors.base02, colors.none, styles.bold)
        Group.new('SpellBad', colors.violet, colors.none, styles.undercurl, colors.violet)
        Group.new('SpellCap', colors.violet, colors.none, styles.undercurl, colors.violet)
        Group.new('SpellLocal', colors.yellow, colors.none, styles.undercurl, colors.yellow)
        Group.new('SpellRare', colors.cyan, colors.none, styles.undercurl, colors.cyan)
        Group.new('Title', colors.base01, colors.none, styles.bold)
        Group.new('MatchParen', colors.orange, colors.base02, styles.bold)
    else
        Group.new('CursorLineNr', colors.base0, colors.base02, styles.bold)
        Group.new('LineNr', colors.base00, colors.base02, styles.none)
        Group.new('NonText', colors.base00, colors.none, styles.bold)
        Group.new('SpecialKey', colors.base00, colors.base02, styles.bold)
        Group.new('SpellBad', colors.violet, colors.none, styles.undercurl, colors.violet)
        Group.new('SpellCap', colors.violet, colors.none, styles.undercurl, colors.violet)
        Group.new('SpellLocal', colors.yellow, colors.none, styles.undercurl, colors.yellow)
        Group.new('SpellRare', colors.cyan, colors.none, styles.undercurl, colors.cyan)
        Group.new('Title', colors.orange, colors.none, styles.bold)
        Group.new('MatchParen', colors.orange, colors.base02, styles.bold)
    end

    -- Generic syntax highlighting
    Group.new('Comment', colors.base01, colors.none, config.comment_italics and styles.italic or styles.none)
    Group.new('Constant', colors.cyan, colors.none, styles.none)
    Group.new('Identifier', colors.blue, colors.none, styles.none)
    Group.new('Statement', colors.green, colors.none, styles.none)
    Group.new('PreProc', colors.orange, colors.none, styles.none)
    Group.new('Type', colors.yellow, colors.none, styles.none)
    Group.new('Special', colors.red, colors.none, styles.none)
    Group.new('Underlined', colors.violet, colors.none, styles.none)
    Group.new('Ignore', colors.none, colors.none, styles.none)
    Group.new('Error', colors.red, colors.none, styles.none)
    Group.new('TODO', colors.magenta, colors.none, styles.bold)

    -- VimScript syntax highlighting
    Group.link('vimVar', groups.Identifier)
    Group.link('vimFunc', groups.Identifier)
    Group.link('vimUserFunc', groups.Identifier)
    Group.link('helpSpecial', groups.Special)
    Group.link('vimSet', groups.Normal)
    Group.link('vimSetEqual', groups.Normal)
    Group.new('vimCommentString', colors.violet)
    Group.new('vimCommand', colors.yellow)
    Group.new('vimCmdSep', colors.blue, colors.none, styles.bold)
    Group.new('helpExample', colors.base1)
    Group.new('helpOption', colors.cyan)
    Group.new('helpNote', colors.magenta)
    Group.new('helpVim', colors.magenta)
    Group.new('helpHyperTextJump', colors.blue, colors.none, styles.underline)
    Group.new('helpHyperTextEntry', colors.green)
    Group.new('vimIsCommand', colors.base00)
    Group.new('vimSynMtchOpt', colors.yellow)
    Group.new('vimSynType', colors.cyan)
    Group.new('vimHiLink', colors.blue)
    Group.new('vimGroup', colors.blue, colors.none, styles.underline + styles.bold)

    -- pum (popup menu)
    Group.new('Pmenu', groups.Normal, colors.base02, styles.none) -- popup menu normal item
    Group.new('PmenuSel', colors.base01, colors.base2, styles.reverse) -- selected item
    Group.new('PmenuSbar', colors.base02, colors.none, styles.reverse)
    Group.new('PmenuThumb', colors.base0, colors.none, styles.reverse)

    -- VimDiff
    Group.link('diffAdded', groups.Statement)
    Group.link('diffLine', groups.Identifier)

    -- airblade/vim-gitgutter
    Group.new('GitGutterAdd', colors.green)
    Group.new('GitGutterChange', colors.yellow)
    Group.new('GitGutterDelete', colors.red)
    Group.new('GitGutterChangeDelete', colors.red)
    Group.new('GitSignsAddLn', colors.green)
    Group.new('GitSignsAddNr', colors.green)
    Group.new('GitSignsChangeLn', colors.yellow)
    Group.new('GitSignsChangeNr', colors.yellow)
    Group.new('GitSignsDeleteLn', colors.red)
    Group.new('GitSignsDeleteNr', colors.red)
    Group.link('GitSignsCurrentLineBlame', groups.Comment)

    -- vim-git/gitcommit.vim
    Group.new('gitcommitSummary', colors.green)
    Group.new('gitcommitComment', colors.base01, colors.none, styles.italic)
    Group.link('gitcommitUntracked', groups.gitcommitComment)
    Group.link('gitcommitDiscarded', groups.gitcommitComment)
    Group.new('gitcommitSelected', groups.gitcommitComment)
    Group.new('gitcommitUnmerged', colors.green, colors.none, styles.bold)
    Group.new('gitcommitOnBranch', colors.base01, colors.none, styles.bold)
    Group.new('gitcommitBranch', colors.magenta, colors.none, styles.bold)
    Group.link('gitcommitNoBranch', groups.gitcommitBranch)
    Group.new('gitcommitDiscardedType', colors.red)
    Group.new('gitcommitSelectedType', colors.green)
    Group.new('gitcommitHeader', colors.base01)
    Group.new('gitcommitUntrackedFile', colors.cyan)
    Group.new('gitcommitDiscardedFile', colors.red)
    Group.new('gitcommitSelectedFile', colors.green)
    Group.new('gitcommitUnmergedFile', colors.yellow)
    Group.new('gitcommitFile', colors.base0)
    Group.link('gitcommitDiscardedArrow', groups.gitCommitDiscardedFile)
    Group.link('gitcommitSelectedArrow', groups.gitCommitSelectedFile)
    Group.link('gitcommitUnmergedArrow', groups.gitCommitUnmergedFile)

    -- neomake/neomake
    Group.new('NeomakeErrorSign', colors.orange)
    Group.new('NeomakeWarningSign', colors.yellow)
    Group.new('NeomakeMessageSign', colors.cyan)
    Group.new('NeomakeNeomakeInfoSign', colors.green)

    -- hrsh7th/nvim-cmp
    Group.new('CmpItemKindDefault', colors.green, colors.none, styles.none)
    Group.link('CmpItemMenuDefault', groups.Pmenu)

    -- glepnir/lspsaga
    Group.new('LspSagaCodeActionTitle', colors.green)
    Group.new('LspSagaBorderTitle', colors.yellow, colors.none, styles.bold)
    Group.new('LspSagaDiagnosticHeader', colors.yellow)
    Group.new('ProviderTruncateLine', colors.base02)
    Group.new('LspSagaShTruncateLine', groups.ProviderTruncateLine)
    Group.new('LspSagaDocTruncateLine', groups.ProviderTruncateLine)
    Group.new('LspSagaCodeActionTruncateLine', groups.ProviderTruncateLine)
    Group.new('LspSagaHoverBorder', colors.cyan)
    Group.new('LspSagaRenameBorder', groups.LspSagaHoverBorder)
    Group.new('LSPSagaDiagnosticBorder', groups.LspSagaHoverBorder)
    Group.new('LspSagaSignatureHelpBorder', groups.LspSagaHoverBorder)
    Group.new('LspSagaCodeActionBorder', groups.LspSagaHoverBorder)
    Group.new('LspSagaLspFinderBorder', groups.LspSagaHoverBorder)
    Group.new('LspSagaFloatWinBorder', groups.LspSagaHoverBorder)
    Group.new('LspSagaSignatureHelpBorder', groups.LspSagaHoverBorder)
    Group.new('LspSagaDefPreviewBorder', groups.LspSagaHoverBorder)
    Group.new('LspSagaAutoPreviewBorder', groups.LspSagaHoverBorder)
    Group.new('LspFloatWinBorder', groups.LspSagaHoverBorder)
    Group.new('LspLinesDiagBorder', groups.LspSagaHoverBorder)
    Group.new('LspSagaFinderSelection', colors.green, colors.none, styles.bold)
    --Group.new('SagaShadow', colors.base02)

    -- nvim-telescope/telescope.nvim
    Group.new('TelescopeMatching', colors.orange, groups.Special, groups.Special, groups.Special)
    Group.new('TelescopeBorder', colors.base01) -- float border not quite dark enough, maybe that needs to change?
    Group.new('TelescopePromptBorder', colors.cyan) -- active border lighter for clarity
    Group.new('TelescopeTitle', groups.Normal) -- separate them from the border a little, but not make them pop
    Group.new('TelescopePromptPrefix', groups.Normal) -- default is groups.Identifier
    Group.link('TelescopeSelection', groups.CursorLine)
    Group.new('TelescopeSelectionCaret', colors.cyan)

    -- TimUntersberger/neogit
    Group.new('NeogitDiffAddHighlight', colors.blue, colors.red)
    Group.new('NeogitDiffDeleteHighlight', colors.blue, colors.red)
    Group.new('NeogitHunkHeader', groups.Normal, colors.base02)
    Group.new('NeogitHunkHeaderHighlight', groups.Normal, colors.red)
    Group.new('NeogitDiffContextHighlight', colors.base2, colors.base02)
    Group.new('NeogitCommandText', groups.Normal)
    Group.new('NeogitCommandTimeText', groups.Normal)
    Group.new('NeogitCommandCodeNormal', groups.Normal)
    Group.new('NeogitCommandCodeError', groups.Error)
    Group.new('NeogitNotificationError', groups.Error, colors.none)
    Group.new('NeogitNotificationInfo', groups.Information, colors.none)
    Group.new('NeogitNotificationWarning', groups.Warning, colors.none)

    -- seblj/nvim-tabline
    Group.new('TabLineSeparatorActive', colors.cyan)
    Group.link('TabLineModifiedSeparatorActive', groups.TablineSeparatorActive)

    -- kevinhwang91/nvim-bqf
    Group.new('BqfPreviewBorder', colors.base01)
    Group.new('BqfSign', colors.cyan)

    -- Primeagen/harpoon
    Group.new("HarpoonBorder", colors.cyan)
    Group.new("HarpoonWindow", groups.Normal)

    Group.new("NvimTreeFolderIcon", colors.blue)

    -- phaazon/hop.nvim
    Group.link('HopNextKey', groups.IncSearch)
    Group.link('HopNextKey1', groups.IncSearch)
    Group.link('HopNextKey2', groups.IncSearch)

    -- Terminal
	vim.g.terminal_color_0 = colors.base02:to_rgb()
	vim.g.terminal_color_1 = colors.red:to_rgb()
	vim.g.terminal_color_2 = colors.green:to_rgb()
	vim.g.terminal_color_3 = colors.yellow:to_rgb()
	vim.g.terminal_color_4 = colors.blue:to_rgb()
	vim.g.terminal_color_5 = colors.magenta:to_rgb()
	vim.g.terminal_color_6 = colors.cyan:to_rgb()
	vim.g.terminal_color_7 = colors.base2:to_rgb()
	vim.g.terminal_color_8 = colors.base03:to_rgb()
	vim.g.terminal_color_9 = colors.orange:to_rgb()
	vim.g.terminal_color_10 = colors.base01:to_rgb()
	vim.g.terminal_color_11 = colors.base00:to_rgb()
	vim.g.terminal_color_12 = foreground:to_rgb()
	vim.g.terminal_color_13 = colors.violet:to_rgb()
	vim.g.terminal_color_14 = colors.base1:to_rgb()
	vim.g.terminal_color_15 = colors.base3:to_rgb()

    function M.translate(group)
        if vim.fn.has("nvim-0.6.0") == 0 then return group end

        if not string.match(group, "^LspDiagnostics") then return group end

        local translated = group
        translated = string.gsub(translated, "^LspDiagnosticsDefault", "Diagnostic")
        translated = string.gsub(translated, "^LspDiagnostics", "Diagnostic")
        translated = string.gsub(translated, "Warning$", "Warn")
        translated = string.gsub(translated, "Information$", "Info")
        return translated
    end

    local lspColors = {
        Error       = groups.Error,
        Warning     = groups.Warning,
        Information = groups.Information,
        Hint        = groups.Hint,
    }
    for _, lsp in pairs({ "Error", "Warning", "Information", "Hint" }) do
        local lspGroup = Group.new(M.translate("LspDiagnosticsDefault" .. lsp), lspColors[lsp])
        Group.link(M.translate("LspDiagnosticsVirtualText" .. lsp), lspGroup)
        Group.new(M.translate("LspDiagnosticsUnderline" .. lsp), colors.none, colors.none, styles.undercurl, lspColors[lsp])
    end

    for _, name in pairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
        Group.link(M.translate(name), groups.CursorLine)
    end

    return M
end

return M
