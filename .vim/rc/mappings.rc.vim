" Multi line move
inoremap jj <ESC>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
noremap <Down> gj
noremap <Up> gk

nnoremap Y y$
nmap <F6> <ESC>a<C-R>=strftime("%Y/%m/%d (%a) %H:%M:%S")

" Change tab width
nnoremap ts2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap ts4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap ts8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>

" Resize window
noremap <C-w>> 10<C-w>>
noremap <C-w>< 10<C-w><
noremap <C-w>+ 10<C-w>+
noremap <C-w>- 10<C-w>-

" Tab
nnoremap <M-n> :tabnew<CR>
nnoremap <M-Left> :tabprevious<CR>                                                                            
nnoremap <M-Right> :tabnext<CR>

" Indent keybind for shutcut
nnoremap > >>
nnoremap < <<

" Not yank is delete operation
vnoremap x "_x
nnoremap x "_x
vnoremap s "_s
nnoremap s "_s

" Jump quickfix
nnoremap <C-p> :<C-u>cp<CR>
nnoremap <C-n> :<C-u>cn<CR>
nnoremap [f :<C-u>cp<CR>
nnoremap ]f :<C-u>cn<CR>
nnoremap [F :<C-u>cfirst<CR>
nnoremap ]F :<C-u>clast<CR>

" Toggle quickfix
if exists('g:__QUICKFIX_TOGGLE_jfklds__')
    finish
endif
let g:__QUICKFIX_TOGGLE_jfklds__ = 1

function! ToggleQuickfix()
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction
nnoremap <script> <silent> <Space>q :call ToggleQuickfix()<CR>

" Jump locationlist
nnoremap [t :<C-u>lp<CR>
nnoremap ]t :<C-u>ln<CR>
nnoremap [T :<C-u>lfirst<CR>
nnoremap ]T :<C-u>llast<CR>

" Toggle locationlist
if exists('g:__LOCATIONLIST_TOGGLE_jfklds__')
    finish
endif
let g:__LOCATIONLIST_TOGGLE_jfklds__ = 1

function! ToggleLocationlist()
    let l:nr = winnr('$')
    lwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        lclose
    endif
endfunction
nnoremap <script> <Space>t :call ToggleLocationlist()<CR>


" Grep astarisk text
nnoremap <Space>gg :<C-u>grep '<C-r>=<SID>convert_pattern(@/)<CR>'<CR>
nnoremap <Space>gl :<C-u>grep '<C-r>=<SID>convert_pattern(@/)<CR>' %<CR>
function! s:convert_pattern(pat)
    let chars = split(a:pat, '\zs')
    let len = len(chars)
    let pat = ''
    let i = 0
    while i < len
        let ch = chars[i]
        if ch ==# '\'
            let nch = chars[i + 1]
            if nch =~# '[vVmM<>%]'
                let i += 1
            elseif nch ==# 'z'
                let i += 2
            elseif nch ==# '%'
                let i += 2
                let pat .= chars[i]
            else
                let pat .= ch
            endif
        else
            let pat .= ch
        endif
        let i += 1
    endwhile
    return escape(pat, '\')
endfunction

" Command line mode mapping emacs like
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
" cnoremap <C-n> <Down>
" cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>


" Rename current file
function! RenameFile() abort
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name !=# '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
noremap <Space>R :call RenameFile()<cr>

