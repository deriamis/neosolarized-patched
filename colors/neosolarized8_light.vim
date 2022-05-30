" this file allows us to change colorschemes with the vim command `colorscheme neosolarized` *after*
" the plugin has already been initialized, i.e., its setup command has run.

lua package.loaded['neosolarized8.palette'] = nil
lua package.loaded['neosolarized8.config'] = nil
lua package.loaded['neosolarized8.theme'] = nil

let g:neosolarized8_theme = "light"
lua require('neosolarized8').colorscheme()
