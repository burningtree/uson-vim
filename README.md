# uson-vim

Emmet-like plugin for Vim. With this plugin you can easily transform μson into JSON or YAML.

## Tutorial

Write your μson object:
```
{number:[1 2 3]}
```

and expand it to JSON by <kbd>Ctrl</kbd> + <kbd>y</kbd> <kbd>l</kbd>.


Command | Keystroke | Mapping 
------- | --------- | ------------
Transform to JSON | <kbd>Ctrl</kbd> + <kbd>y</kbd> <kbd>l</kbd> | `<Plug>(uson-expand)`


## Installation
I recommend installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and then simply copy and paste:

```
cd ~/.vim/bundle
git clone git://github.com/burningtree/uson-vim.git
```

## Licence
MIT
