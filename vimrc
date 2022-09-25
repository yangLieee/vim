
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"								Title
" => ColorScheme
" => General
" => VIM user interface
" => Files, backups and undo
" => Text, tab and indent(缩进) related
" => Visual mode Map related
" => Command mode related
" => Moving around, tabs and buffers
" => Map Key
" => Plugin
"	=> Vundle (插件管理器)
"	=> 
" => Help 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ColorScheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
colorscheme monokai


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $VIMRUNTIME/vimrc_example.vim		" 导入示例配置 
set encoding=utf-8  				" utf-8
set t_Co=256					" 使用 256 颜色
set nocompatible				" 不兼容 vi
set showcmd					" 底部显示输入的命令
set mouse=n        			 	" 支持鼠标模式
set mouse=i
set mouse=c
set mouse=h
set mouse=n
set number					" 默认显示行号，相对行号：:set relativenumber
set cursorline					" 当前行高亮
set selection=inclusive     			" 在选择文本时，光标所在位置也属于被选中的范围, exclusive
set selectmode=mouse,key    			" 使用鼠标
set laststatus=2				" 始终显示状态行 0:no / 1:show when muti windows / 2:yes
filetype indent on				" 自动检查 vim.py / vim.c / vim.js ...
set report=0        				" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set matchtime=5     				" 匹配括号高亮的时间(单位是十分之一秒) 
set clipboard=unnamed 		                " 设置粘贴板格式不变
set clipboard=unnamedplus
let mapleader = ","             		" 自定义一个控制键为，类似于：
let g:mapleader = ","


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7                		" 垂直移动时，将7条线设置为curors。。 
set wildmenu				" 当按Tab键弹出提示列表
set ruler			    	" 显示游标的行和列
set cmdheight=2         		" 命令行高度
set hid                	 		" 设置缓冲区不保存切换
" indent: 删除自动缩进的空格（set indent,set ai）
" eol:    插入模式下光标在行首，两行合并需要该配置
" start： 删除此次插入前的输入
set backspace=eol,start,indent
" 光标在行首方向键到上一行结尾
" `<`, `>`用作在视图模式下的，`[`, `]`用作在插入模式下
set whichwrap+=<,>,[,],h,l
set ignorecase          		" 搜索时忽略大小写,smartcase不忽略
set wrapscan    			" 删除空白行
set hlsearch            		" 高亮搜索的内容
set incsearch				" 搜索时输入关键字高亮匹配内容
:set nolazyredraw       		" 这个选项已经被现在的终端技术实现.如果我们设置了这个选项,我们就不会看到正在执行的宏. 
" set magic               		" Set magic on, for regular expressions
set mat=2               		" 当光标在大括号上方，匹配另一个括号
set noerrorbells        		" 出现错误不鸣叫
set novisualbell        		" 出现错误不闪烁
set vb t_vb=            		" 错发声就彻底被禁止
set tm=500



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile
set undofile			" save undo history
set undodir=~/.vim/undodir
if !isdirectory(&undodir)	" create undofir
	  call mkdir(&undodir, 'p', 0700)
  endif


" highlight and search
syntax on			    " 语法高亮
syntax enable
hi search cterm=bold ctermfg=236 ctermbg=210 guifg=#71d3b4 guibg=#233323	" high light --> pink
" highlight StatusLine guifg=SlateBlue guibg=Yellow             " 状态行颜色
" highlight StatusLineNC guifg=Gray guibg=White


" edit and backup 
set history=1000		" rmemeber history operator times
"set spell spelllang=en_us	" English spell check
set autoread			" open watch. if another task open and edit this file will warning 
set wildmode=longest:list,full
set fileencodings=ucs-bom,utf-8,gb18030,latin1		" deal with chinese


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent(缩进) related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4    		" 自动缩进所使用的空白数
set tabstop=4       		" 制表符占空格数
set softtabstop=4   		" 将连续数量的空格视为一个制表符
set expandtab       		" 扩展制表符号为空格
set autoindent      		" 打开自动缩进，= ai
set smarttab                	" 智能缩进， = si
" set textwidth=79    		" 编辑器每行字符数
set lbr                    	" 不会在单词中间断行
set tw=500                  	" 设置断行字符个数
set wrap                    	" 设置折行


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode Map related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
" 可视模式（Visual）下按 */# 可以查找匹配的字符串（不只是一个单词）
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
" function VisualSearch
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cno = cnoremap 用于命令行，相当于简写，例如：命令行输入 $h 自动映射后面字符
cno $h e ~/
cno $d e ~/Desktop/
cno $c e ./
cnoremap <C-A>	<Home>
cnoremap <C-E>	<End>
cnoremap <C-K>	<C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索： space -> / ; 反向搜索：space*2 -> ? 
map <space>f /
map <space>ff ?
map <silent> <leader><cr> :noh<cr>
 
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l


" Close the current buffer
map <leader>bd :Bclose<cr>
" Close all the buffers
map <leader>ba :1,300 bd!<cr>


" 好像有这个需要在查一遍
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
catch
endtry




vnoremap $1 <esc>`>a)<esc>`<i(<esc>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Map Key
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" number map
nmap 11 :set nu<cr>		" <cr> = enter
nmap 22 :set nonu<cr>
nmap 33 :noh<cr>		" find nothing 
" character map
nmap ww <C-w><C-w>
nmap -- 5<C-w>-
nmap ++ 5<C-w>+
nmap >> 5<C-w>>
nmap << 5<C-w><
" 退出
nmap qq :q!<cr>	
" 保存
nmap wa :w<cr>
" 竖直分屏
nmap vs :vs<cr>
" 水平分屏
nmap sp :sp<cr>
" Fn map
map <F3> :NERDTreeMirror<CR>	" 设置NerdTree
map <F3> :NERDTreeToggle<CR>
""查找区分大小写
nmap <F1> :set ic<cr>/
""查找不区分大小写
nmap <F2> :set noic<cr>
""新建标签
nmap tn :tabnew<space>
""关闭标签
nmap tc :tabclose<cr>
nmap ds :%s/\s\+$//<cr> " 需要学习
nmap nt :tabnext<cr>
nmap bd :bdelete<cr>
nmap vv :bnext<cr>
nmap zz :bprevious<cr>
nmap bb :b
"F7 for comment #
vmap <F7> :s=^\(#\)*=#=g<cr>:noh<cr>
nmap <F7> :s=^\(#\)*=#=g<cr>:noh<cr>
imap <F7> <ESC>:s=^\(#\)*=//=g<cr>:noh<cr>
vmap <C-F7> :s=^\(#\)*==g<cr>:noh<cr>
nmap <C-F7> :s=^\(#\)*==g<cr>:noh<cr>
imap <C-F7> <ESC>:s=^\(#\)*==g<cr>:noh<cr>
"F12 for //
vmap <F12> :s=^\(//\)*=//=g<cr>:noh<cr>
nmap <F12> :s=^\(//\)*=//=g<cr>:noh<cr>
imap <F12> <ESC>:s=^\(//\)*=//=g<cr>:noh<cr>
vmap <C-F12> :s=^\(\//\)*==g<cr>:noh<cr>
nmap <C-F12> :s=^\(\//\)*==g<cr>:noh<cr>
imap <C-F12> <ESC>:s=^\(\//\)*==g<cr>:noh<cr>
"F10 for <!-- -->
vmap <F10> :s=^\(//\)*=<!--=g<cr>:s=\(//\)*$=-->=g<cr>:noh<cr>
nmap <F10> :s=^\(//\)*=<!--=g<cr>:s=\(//\)*$=-->=g<cr>:noh<cr>
imap <F10> <ESC>:s=^\(//\)*=<!--=g<cr>:s=\(//\)*$=-->=g<cr>:noh<cr>
vmap <C-F10> :s=^\(<!--\)*==g<cr>:s=\(-->\)*$==g<cr>:noh<cr>
nmap <C-F10> :s=^\(<!--\)*==g<cr>:s=\(-->\)*$==g<cr>:noh<cr>
imap <C-F10> <ESC>:s=^\(<!--\)*==g<cr>:s=\(-->\)*$==g<cr>:noh<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ColorScheme
" https://github.com/joshdick/onedark.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => minibuffer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 Plugin 'minibufexpl.vim'
" let g:miniBufExplModSelTarget = 1 
" let g:miniBufExplorerMoreThanOne = 2 
" let g:miniBufExplModSelTarget = 0 
" let g:miniBufExplUseSingleClick = 1 
" let g:miniBufExplMapWindowNavVim = 1 
" 
" let g:miniBufExplMapWindowNavArrows = 1 
" let g:miniBufExplMapCTabSwitchBufs = 1 
" 
" let g:bufExplorerSortBy = "name"
" 
" autocmd BufRead,BufNew :call UMiniBufExplorer
" 
" map <leader>u :TMiniBufExplorer<cr>
" 



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => The NERD tree(文件目录)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'The-NERD-tree'
" 设置开启和关闭快捷键
nmap <silent> <F9> :NERDTreeMirror<CR>
nmap <silent> <F9> :NERDTreeToggle<CR>
let NERDTreeWinSize=45      " 窗口大小
let NERDTreeWinPos='right'   " 窗口位置
let NERDTreeShowLineNumbers=1   " 是否默认显示行号
let NERDTreeShowHidden=0        " 是否默认显示隐藏文件


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => indentLine (缩进)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'Yggdroot/indentLine'        "缩进插件下载
let g:indentLine_char='┆'           "缩进指示线符 
let g:indentLine_enabled = 1        "开启缩进指示

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 引号，路径补全
" https://github.com/Raimondi/delimitMate
" https://github.com/Shougo/deoplete.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin 'Valloric/YouCompleteMe', {'do':'python3 install.py'}
Plugin 'Raimondi/delimitMate'
Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MRU (最近打开的文件) 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'vim-scripts/mru.vim'
"  设置默认不包含哪些文件，默认空；
let MRU_Exclude_Files = '^/tmp/.*|^/var/tmp/.*'
" 设置默认在本窗口打开最近文件列表，而不是新的窗口；
let MRU_Use_Current_Window = 1 
let MRU_Window_Height = 15
let MRU_Max_Entries = 100
" 快捷键
map <leader>m :MRU<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => state line 状态栏插件
" https://github.com/itchyny/lightline.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'itchyny/lightline.vim'
let g:lightline = {
     \ 'colorscheme': 'wombat',
     \ 'active': {
     \   'left': [ [ 'mode', 'paste' ],
     \             [ 'readonly', 'filename', 'modified', 'helloworld' ] ]
     \ },
     \ 'component': {
     \   'helloworld': 'yangLiee'
     \ },
     \ }



call vundle#end()
 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 配置tagbar
" https://www.vim.org/scripts/script.php?script_id=3465
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 nmap <silent> tt :TagbarToggle<CR>        
 let g:tagbar_ctags_bin = 'ctags'                   "tagbar以来ctags插件
 let g:tagbar_left = 1                              "让tagbar在页面左侧显示，默认右边
 let g:tagbar_width = 30                            "设置tagbar的宽度为30列，默认40
 let g:tagbar_autofocus = 1                         "这是tagbar一打开，光标即在tagbar页面内，默认在vim打开的文件内
 let g:tagbar_sort = 0                              "设置标签不排序，默认排序
 set tags=tags;
 set autochdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  neocomplcache(自动补全)
" https://github.com/Shougo/neocomplcache.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件自动启动
let g:neocomplcache_enable_at_startup = 1 
" 默认选择第一个
let g:neocomplcache_enable_auto_select = 1





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Help
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 小技巧 
"
" 正常模式：
"       ciw     // 将光标所在的单词删除,然后进入插入模式
"       gf      // 头文件跳转
"       ctrl + w + r    //交换窗口
" 可视模式：
"       :aw     // 选择当前单词
"       :ab     // 选择被()包裹的区域(含括号)
"
"


" 插件使用：
"Vundle
"1. 功能：管理插件的插件,设置运行时路径，包括vundle和初始化,"设置运行时路径，包括vundle和初始化
"2. 使用：https://www.shuzhiduo.com/A/l1dyOo7VJe/
"        安装插件：启动vim，:PlugInstall; 命令行直接安装 vim +PluginInstall +qall
"        卸载插件：注释掉该文件相应行，启动vim，执行 :BundleClean
"        更新插件：BundleUpdate
"        显示插件：BundleList
"        查找插件：BundleSearch
"
"
" vim-commentary:
" 1. 功能：注释代码；
" 2. 使用：gcc / gcu    注释光标所在的当前行。
"          gcap / gcau  注释段落。如果函数之间是用空行分隔的，那么gcap会注释光标所在整个的函数。
"
"
" NERDTree :
" 1. 功能：提供了丰富的键盘操作方式来浏览和打开文件
" 2. 使用：
" 	   和编辑文件一样，通过h j k l移动光标定位
" 	   打开关闭文件或者目录，如果是文件的话，光标出现在打开的文件中
" 	   go 效果同上，不过光标保持在文件目录里，类似预览文件内容的功能
" 	   i和s可以水平分割或纵向分割窗口打开文件，前面加g类似go的功能
" 	   t 在标签页中打开
" 	   T 在后台标签页中打开
" 	   p 到上层目录
" 	   P 到根目录
" 	   K 到同目录第一个节点
" 	   J 到同目录最后一个节点
" 	   m 显示文件系统菜单（添加、删除、移动操作）
" 	   ? 帮助
" 	   q 关闭
"
"
"
" tarbar :
" 1. 功能：打开文件内的变量 函数等定义
" 2. 使用：
"        *  展开所有标签
"        =  折叠所有标签
"        o 在折叠与展开间切换，按o键，折叠标签，再按一次o，则展开标签，如此来回切换
"        p: 跳到定义位置，但光标仍然在tagbar原位置
"        shift+p(大写P): 打开一个预览窗口显示标签内容，如果在标签处回车跳到vim编辑页面内定义处，则预览窗口关闭
"
"
"
" indentLine
" 1. 功能： 显示缩进
" 2. 使用：
"
"
"
"
"
"
"           
"


