" Vim global plugin to search in all archives like in ~/.m2 and shows result 
"                   in new buffer. hit 'gf' on the desired archive 
" Last Change     :	2021 Feb 28
" Maintainer      :	Thomas Schneider <snieda@web.de>
" Licence         : GNU v3

" don't load it twice
if exists("g:loaded_fiand")
  finish
endif
let g:loaded_fiand = 1

function s:FindInAllArchives(search)
    let dirs = input("base directories: ", "~/.m2")
	let search = input("optional search string (empty to search on filenames only): ", a:search)
	if search == ""
	    let search = "_NOSEARCH_"
	endif
    let fff = system("./fia.sh " . dirs . " -r \"" . search . "\" FUZZY=tee")
	vsplit .unzip-list.txt
	"TODO: highlight search string 
	"put = fff
endfunction
command! -nargs=1 FindInAllArchives call <SID>FindInAllArchives(<f-args>)
noremap <unique> <script> <Plug>fiand;  <SID>FindInAllArchives
noremenu <script> Plugin.Add\ Find in All Archives    <SID>FindInAllArchives
noremap <leader>hh :call <SID>FindInAllArchives(expand("<cword>"))<CR>

