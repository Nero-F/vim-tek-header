" Vim global plugin for EPITECH Headers
" Last Change:	2020 June 10
" Maintainer:	Fahad Assoumani <fahad.assoumani@epitech.eu>
" License:      This file is placed in the public domain

nnoremap <leader>h :call <SID>DumpTekHeader()<cr>

function! s:GetHeaderInfo(file_name)
    call inputsave()
    let project_name = input('Type Project Name => ')
    if empty(project_name)
        echo "PROJECT_NAME is generate based on the workspace name (set def_name=false to disable the feature :: available soon)"
        let project_name = split(getcwd(), '/')[-1]
    endif

    let file_desc = input('Type File Description => ')
    if empty(file_desc)
        echo "FILE_DESCRIPTION is generate based on the file name (set def_desc=false to disable the feature :: available soon)"
        let file_desc = a:file_name
    endif

    call inputrestore()
    return [project_name, file_desc]
endfunction

function s:ReturnNewlyPos(list, num)
    return [a:list[0], a:list[1] + a:num, a:list[2], a:list[3]]
endfunction

function s:CStyleHeader(info_list, file_ext, year)
    let line_nb = line('$')
    let current_cursor_pos = getpos('.')
    normal! gg
    let header = [
                \"/*", "** EPITECH PROJECT, " . a:year,
                \"** " . a:info_list[0],
                \"** File description:", "** " . a:info_list[1],
                \"*/", ""]
    call append(line('.') - 1, header)

    if (line_nb == 1 || line_nb == 0) && (a:file_ext ==# "h" || a:file_ext ==# "hpp")
        let cpp_header = toupper(a:info_list[1]) . (a:file_ext ==# "h" ? "_H_" : "_HPP_")
        let preprocessor_directives = [
                    \"#ifndef " . a:info_list[0],
                    \"    #define " . a:info_list[0], "", "",
                    \"#endif /* " . a:info_list[0] . " */" ]
        call append(line('.'), preprocessor_directives)
        " TODO: add class construcion function for hpp files
    endif
    
    call setpos('.', s:ReturnNewlyPos(current_cursor_pos, 7))
endfunction

function s:MakeStyleHeader(info_list, year)
    let line_nb = line('$')
    let current_cursor_pos = getpos('.')
    normal! gg
    let header = [
                \"##", "## EPITECH PROJECT, " . a:year,
                \"## " . a:info_list[0],
                \"## File description:", "## " . a:info_list[1],
                \"##", ""]
    call append(line('.') - 1, header)
    call setpos('.', s:ReturnNewlyPos(current_cursor_pos, 7))
endfunction

function! s:DumpTekHeader() 
    let reg_file_ext = '\v^(c|h)(pp)?$'
    let makefile = "Makefile"
    let current_year = strftime("%Y")
    let file_extension = expand("%:e")
    let file_name = expand("%:t:r")

    if !empty(matchstr(file_extension, reg_file_ext))
        call s:CStyleHeader(s:GetHeaderInfo(file_name), file_extension, current_year)
    elseif file_name == makefile
        call s:MakeStyleHeader(s:GetHeaderInfo(file_name), current_year)
    else
        echo "Can't apply header, the file type is not recognize!"
    endif
endfunction
