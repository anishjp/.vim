" set langmap=ik,jh,kj,hi,IK,JH,KJ,HI
" alternative: http://fitzsimmons.ca/post/2916403349/vim-ijkl
set macmeta
nn 0 ^
nn - :Ex<Cr>

" let mapleader = "§"
let mapleader = "`"
let maplocalleader = "\\"


"""""""""" completion

" https://stackoverflow.com/a/2138303
let g:stop_autocomplete=0

function! CleverTab(type)
    if a:type=='omni'
        if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
            let g:stop_autocomplete=1
            return "\<C-P>"
        elseif !pumvisible() && !&omnifunc
            return "\<C-X>\<C-O>\<C-P>"
        endif
    elseif a:type=='keyword' && !pumvisible() && !g:stop_autocomplete
        return "\<C-X>\<C-P>\<C-P>"
    elseif a:type=='next'
        if g:stop_autocomplete
            let g:stop_autocomplete=0
        else
            return "\<C-P>"
        endif
    endif
    return ''
endfunction

" inoremap <silent> <M-space> <C-R>=CleverTab('omni')<CR><C-R>=CleverTab('keyword')<CR><C-R>=CleverTab('next')<CR>

ino          <M-space>         <C-p>
ino          <M-p>             <C-p>
" ino          <S-space>         <C-x><C-o>

" Execute current line or current selection as Vim EX commands.
nnoremap <silent> <space>ve :exe getline(".")<CR>
vnoremap <silent> <space>ve :<C-w>exe join(getline("'<","'>"),'<Bar>')<CR>

"""""""""" clojure

" slurp/barf with autoindent
nmap  <M-right> >)=%(%
nmap  <M-left> mj<)mh='j

nmap <M-o> o(

noremap ' `
" eval form under cursor
nmap <f3> mlcpp'l
" eval surrounding top level def
nmap <M-f3> ml[[cpp'l
" eval word under cursor
nmap <S-f3> mlcpaw'l
" move to mark t, eval form and move back
map <D-f3> mk'tcpp'k

" copy last eval to os clipboard
nmap <f4> :Last<CR>ggVG<D-c>:pc<CR>
" paste copied eval produced above and format it as clojure
nmap <S-f4> <D-a><D-v>:v/^;/d<cr>:%s/^;/<cr>:set ft=clojure<cr>
" paste copied eval to new tab
nmap <D-f4> <f4><D-t><S-f4>
" paste copied eval to a vertical split in the next tab
nmap <M-f4> <f4><D-right>:vsp<cr>:enew<cr><S-f4>

nmap <M-i> <I
nmap <M-a> >I
nmap <M-I> \i
nmap <M-A> \I

"""""""""" disable middle mouse button pasting
map   <MiddleMouse>    <Nop>
map   <2-MiddleMouse>  <Nop>
map   <3-MiddleMouse>  <Nop>
map   <4-MiddleMouse>  <Nop>
imap  <MiddleMouse>    <Nop>
imap  <2-MiddleMouse>  <Nop>
imap  <3-MiddleMouse>  <Nop>
imap  <4-MiddleMouse>  <Nop>

"""""""""" disable middle mouse button pasting
" map  <Left>  <Nop>
" map  <Right>  <Nop>
" map  <Up>  <Nop>
" map  <Down>  <Nop>

"""""""""" macvim
if has("gui_macvim")
  let macvim_skip_cmd_opt_movement = 1
  let macvim_hig_shift_movement = 0

  runtime macmap.vim
endif

"""""""""" shortcuts
nn  <silent> <D-Cr>            :set fullscreen!<CR>
nn  <silent> TT                :call Tabnew()<CR>:e ~/Dropbox/Documents/todo/today.txt<CR>

"""""""""" tabs
nn  <silent> <D-w>             :q<CR>
nn  <silent> <Leader>w         :q<CR>
nn  <silent> <D-S-w>           :bwipeout<CR>
nn  <silent> <Leader>w         :bwipeout<CR>
nn  <silent> <D-t>             :call Tabnew()<CR>
nn  <silent> <D-n>             :call Tabnew()<CR>
nn  <silent> <D-Left>          gT
nn  <silent> <Leader><Left>    gT
nn  <silent> <D-Right>         gt
nn  <silent> <Leader><Right>   gt
nn  <silent> <D-M-Left>        :call MoveTabLeft()<CR>
nn  <silent> <D-M-Right>       :call MoveTabRight()<CR>

"""""""""" global CWD manipulation
nn  <silent> <Leader>-         :call CwdUp()<CR>
nn  <silent> <Leader>=         :call CwdDown()<CR>
nn  <silent> <Leader>0         :call CwdCurrent()<CR>:call FizzyReIndexCwd()<CR>

"""""""""" windows, buffers and files
nn  <silent> <D-q>             :qa<CR>
nn  <silent> <Leader>q         :qa<CR>

nn  <silent> <D-s>             :up<CR>
nn  <silent> <Leader>s         :up<CR>

nn  <silent> <Cr>              <C-^>
" nn  <silent> <C-Tab>           :e %:h<Cr><Cr>
nn  <silent> <Tab>             <C-w>w
nn  <silent> <D-]>             <C-w>w
nn  <silent> <D-[>             <C-w>w

nn  <silent> <Leader>h         :sp<CR>
" nn  <silent> <Leader>i         :sp<CR>
nn  <silent> <Leader>v         :vsp<CR>

nn  <silent> <D-d>             :vsp<CR>
nn  <silent> <D-D>             :sp<CR>

nn  <silent> <C-w>o            <Nop>
nn  <silent> <C-w>\            <C-w>\|
nn  <silent> <C-w>-            <C-w>_
nn  <silent> <C-w><Bs>         <C-w>=
nn  <silent> <C-w><CR>         <C-w>\|<C-w>_
nn  <silent> <Leader><Bs>      <C-w>=
nn  <silent> <Leader><CR>      <C-w>\|<C-w>_

"""""""""" directory browsing
nn  <silent> <D-e>             :call BrowserFromCurrentDir()<CR>
nn  <silent> <Leader>e         :call BrowserFromCurrentDir()<CR>

nn  <silent> <D-E>             :call BrowserFromCurrentFilePath()<CR>
nn  <silent> <Leader>E         :call BrowserFromCurrentFilePath()<CR>

"""""""""" fuf-fizzy
nn  <silent> <D-r>             :FufFizzyFile<CR>
nn  <silent> <Leader>r         :FufFizzyFile<CR>

nn  <silent> <D-R>             :FufFizzyDir<CR>
nn  <silent> <Leader>R         :FufFizzyDir<CR>

nn  <silent> <D-\>             :call FizzyReIndexCwd()<CR>
nn  <silent> <Leader>\         :call FizzyReIndexCwd()<CR>

nn  <D-k>                      :Ack<Space>
nn  <Leader>k                  :Ack<Space>

"""""""""" selections
nn   <silent> <special> <F2>            :let @/ = ""\|nohlsearch<CR>
ino  <special> <F2>            <C-o>:let @/ = ""\|nohlsearch<CR>

" select the most recent pasted text, generally works
" intended to be similar to gv
nn gb '[V']

"""""""""" toggle switches
nn  <silent> <Leader>a         :set wrap!<CR>
nn  <silent> <Leader>l         :set list!<CR>
nn  <silent> <Leader>p         :set paste!<CR>
nn  <silent> <Leader>n         :set number!<CR>

"""""""""" indenting
" TODO check with template expansion
" TODO check if works in normal mode
vn  <silent> >>                >gv

vn  <silent> <<                <gv

nn  <silent> <C-Right>         >>
vn  <silent> <C-Right>         >gv
ino <silent> <C-Right>         <C-o>>><C-o>2l

nn  <silent> <C-Left>          <<
vn  <silent> <C-Left>          <gv
ino <silent> <C-Left>          <C-o><<<C-o>2h

"""""""""" swap lines
" TODO make it work with visual mode (move a selected block up and down)
nn  <silent> <C-Up>            :call SwapUp()<CR>
nn  <silent> <C-Down>          :call SwapDown()<CR>

ino <silent> <C-Up>            <C-o>:call SwapUp()<CR>
ino <silent> <C-Down>          <C-o>:call SwapDown()<CR>

"""""""""" expansions
ino <C-space> <C-p>
" ino ,.        <C-p>

"""""""""" <3 _
" helpers to use _ and - like word boundaries
" TODO maybe use smartcase.vim
nn va9 va(
nn vi9 va(
nn va0 va)
nn vi0 vi)

nn           c_                ct_
nn           cr                ct_
nn           vr                vt_
nn           yr                yt_
nn           dr                dt_
nn           gur               gut_
nn           gUr               gUt_

nn           car               bct_
nn           var               bvt_
nn           yar               byt_
nn           dar               bdt_
nn           guar              bgut_
nn           gUar              bgUt_

nn           cir               F_lct_
nn           vir               F_lvt_
nn           yir               F_lyt_
nn           dir               F_ldt_
nn           guir              F_lgut_
nn           gUir              F_lgUt_

nn           c-                ct-
nn           ce                ct-
nn           ve                vt-
nn           ye                yt-
nn           de                dt-
nn           gue               gut-
nn           gUe               gUt-

nn           cae               bct-
nn           vae               bvt-
nn           yae               byt-
nn           dae               bdt-
nn           guae              bgut-
nn           gUae              bgUt-

nn           cie               F-lct-
nn           vie               F-lvt-
nn           yie               F-lyt-
nn           die               F-ldt-
nn           guie              F-lgut-
nn           gUie              F-lgUt-

" TODO make it work at beginning/end of line
nn           c<space>                ct<space>
nn           v<space>                vt<space>
nn           y<space>                yt<space>
nn           d<space>                dt<space>
nn           gu<space>               gut<space>
nn           gU<space>               gUt<space>

nn           ca<space>               bct<space>
nn           va<space>               bvt<space>
nn           ya<space>               byt<space>
nn           da<space>               bdt<space>
nn           gua<space>              bgut<space>
nn           gUa<space>              bgUt<space>

nn           ci<space>               F<space>lct<space>
nn           vi<space>               F<space>lvt<space>
nn           yi<space>               F<space>lyt<space>
nn           di<space>               F<space>ldt<space>
nn           gui<space>              F<space>lgut<space>
nn           gUi<space>              F<space>lgUt<space>

" TODO ?!
" nn >t vat>
" nn <t vat<


"""""""""" cmaps
" cno <expr> / getcmdtype() == '/' ? '\/' : '/'


"""""""""" dash
nmap <silent> <F1> <Plug>DashGlobalSearch


"""""""""" dev

vmap zz :'<,'>!../../bin/zprint-filter<CR>
nmap zz va(:'<,'>!../../bin/zprint-filter<CR>

func! ZprintFilterBuffer()
  let l:winview = winsaveview()
  :1,$!../../bin/zprint-filter
  call winrestview(l:winview)
endf

nmap ZA :call ZprintFilterBuffer()<CR>

"""""""""" other random TODO ?
" echo highlight group at cursor location
map <leader>hl  :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Enclose
"vnoremap <silent> <M-{> >gv:<C-u>call Enclose('{', 1)<CR>
"vnoremap <silent> <M-/> :<C-u>call Enclose('/', 0)<CR>

" Execute last command
"inoremap <M-:> <C-o>:echo ':' . @: \| execute @:<CR>
"nnoremap <M-:> :echo ':' . @: \| execute @:<CR>

" remove duplicate newlines and whitespace
" call KeyMap('n',  'L',    'r',       ':%s/\n\n/\r/<CR>')
" call KeyMap('v',  'L',    'r',       ':s/\n\n/\r/<CR>')
" call KeyMap('n',  'L',    'R',       ':%s/\s\s*$//<CR>')
" call KeyMap('v',  'L',    'R',       ':s/\s\s*//<CR>')

" format sql
" :%s/\(FROM\|LEFT\|RIGHT\|INNER\|WHERE\|GROUP\|ORDER\|LIMIT,\)/\r<CR>:%s/\(AND\|,\)/&\r<CR>
