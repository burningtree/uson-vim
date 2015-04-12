" uson.vim - uson for vim
" Maitainer: Jan Stránský <jan.stransky@arnal.cz>
" version:   0.1
" 

let s:cmd = 'uson'
let s:leader_key = '<c-y>'

function! uson#expand(text, format)
  let result = system(s:cmd.' -op '.shellescape(a:text))
  if v:shell_error > 10
    echoerr 'No "uson" command installed!'
    echoerr 'Please install it by typing: "npm install -g uson"'
    return
  elseif v:shell_error
    echoerr 'μson error: '.result
    return
  endif
  return result
endfunction

function! uson#expandToJSON(text)
  return uson#expand(a:text, 'json')
endfunction

function! uson#expandIntelligent(feedkey) abort
  return "\<plug>(uson-expand)"
endfunction

function! uson#doExpand() abort

  let mode = mode()
  let orig = getreg('"')

  if mode == 'i'
    silent exe 'norm h'
  endif

  silent exe 'norm vaBy'
  let bmode = mode()

  if bmode == 'v'
    silent exe 'vi'
    "echo 'μson object not found'
    return ''
  endif

  let result = uson#expandToJSON(getreg('"'))
  if result == ''
    return ''
  endif

  silent exe 'norm vaBx'
  call setreg('"', result)
  silent exe 'norm P]}'
  call setreg('"', orig)
  if mode == 'i'
    exe 'norm a'
  endif

  return ''
endfunction

if !exists('g:uson_leader_key')
  let g:uson_leader_key = s:leader_key
endif

if !exists('g:uson_map_keys')
  let g:uson_map_keys = 1
endif

inoremap <silent> <plug>(uson-expand) <C-R>=uson#doExpand()<CR>
nnoremap <silent> <plug>(uson-expand) :<C-U>call uson#doExpand()<CR>

if g:uson_map_keys
  let lk = g:uson_leader_key
  exe 'imap '. lk . 'l <plug>(uson-expand)'
  exe 'nmap '. lk . 'l <plug>(uson-expand)'
endif

