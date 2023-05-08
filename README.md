# todo-quickfix

This is a Neovim plugin that demonstrates using Treesitter
to parse the source code in the current buffer,
place selected lines in the quickfix list,
and open the quickfix list.

It is an implementation of the plugin described in the YouTube video
"Writing Plugins - It's Never Been Easier (NeovimConf 2022)" by DevOnDuty
at https://www.youtube.com/watch?v=PdaObkGazoU.

To configure use of this plugin, create the file
`~/.config/nvim/lua/user/plugins/todo-quickfix.lua` containing the following:

```lua
return {
  "mvolkmann/todo-quickfix.nvim",
  lazy = false, -- load on startup, not just when required
  config = true -- require the plugin and call its setup function
}
```

Open a source file containing TODO comments and enter `:TodoQF`.

