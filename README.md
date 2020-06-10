# vim-tek-header 
[![Github License](https://img.shields.io/github/license/Nero-F/vim-tek-header)](https://github.com/Nero-F/vim-tek-header/blob/master/LICENSE)
=========
This little plugin will allows my fellow tek students to put their epitech headers in their Makefiles, .c, .h, .cpp, .hpp files

![](https://github.com/Nero-F/vim-tek-header/blob/master/rsrcs/vim-tek-header.gif)

# Installation
You can install it with your favorite vim package manager. 
I personally use [VimPlug](https://github.com/junegunn/vim-plug) so:
```
  " in your vimrc
  call plug#begin('~/.vim/plugged')
  ...
  Plug 'Nero-F/vim-tek-header'
  ...
  call plug#end()
```
# Usage
Make sure to use this plugin in proper files => .c, .cpp, .h, .hpp, Makefile. Otherwise an error will be promped.

The binding to trigger the header is `<leader> h` (~Not implemented the feature to bind other keys from the interpreter or from vimrc)(~~ next release).
Now you can write the name of the project or make it generate from the source folder by pressing **ENTER** (in this case make sure your vim instance started from this path).
Same goes for the project description but generate from the namefile if not specify.
  
*You will be able to disable these features in the next release*

# CONTRIBUTE
If you want me to add some new features feel free to submit an issue or a PR, I'll also be glad to hear your feedbacks.

## PS
This plugin is highly inspired from **Nicolas Polomack**'s *epitech-c-cpp-headers* wich is the one I used to use in VSCode.
