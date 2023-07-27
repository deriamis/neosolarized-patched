-- this file allows us to change colorschemes with the vim command `colorscheme neosolarized` *after*
-- the plugin has already been initialized, i.e., its setup command has run.

package.loaded['neosolarized8.palette'] = nil
package.loaded['neosolarized8.config'] = nil
package.loaded['neosolarized8.theme'] = nil

vim.g.neosolarized8_theme = nil
require('neosolarized8').colorscheme()
