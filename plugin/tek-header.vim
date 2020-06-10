nnoremap <leader>h :call <SID>DumpTekHeader()<cr>

function! GetHeaderInfo(file_name)
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

function ReturnNewlyPos(list, num)
    return [a:list[0], a:list[1] + a:num, a:list[2], a:list[3]]
endfunction

function CStyleHeader(info_list, file_ext, year)
    let line_nb = line('$')
    let current_cursor_pos = getpos('.')
    normal! gg
    let header = [
                \"/*", "** EPITECH PROJECT " . a:year,
                \"** " . a:info_list[0],
                \"** File description: ", "** " . a:info_list[1],
                \"*/", ""]
    call append(line('.') - 1, header)

    echom a:file_ext
    if (line_nb == 1 || line_nb == 0) && (a:file_ext ==# "h" || a:file_ext ==# "hpp")
        let cpp_header = toupper(a:info_list[1]) . (a:file_ext ==# "h" ? "_H_" : "_HPP_")
        let preprocessor_directives = [
                    \"#ifndef " . cpp_header,
                    \"#define " . cpp_header, "", "",
                    \"#endif /* " . cpp_header . " */" ]
        call append(line('.') - 1, preprocessor_directives)
        " TODO: add class construcion function for hpp files
    endif
    let new_cursor_pos = returnnewlypos(current_cursor_pos, 7)
    call setpos('.', new_cursor_pos)
endfunction

function MakeStyleHeader(info_list, year)
    let line_nb = line('$')
    let current_cursor_pos = getpos('.')
    normal! gg
    let header = [
                \"#", "## EPITECH PROJECT " . a:year,
                \"## " . a:info_list[0],
                \"## File description: ", "## " . a:info_list[1],
                \"#", ""]
    call append(line('.') - 1, header)
    let new_cursor_pos = ReturnNewlyPos(current_cursor_pos, 7)
    call setpos('.', new_cursor_pos)
endfunction

function! s:DumpTekHeader() 
    let reg_file_ext = '\v^(c|h)(pp)?$'
    let makefile = "Makefile"
    let current_year = strftime("%Y")
    let file_extension = expand("%:e")
    let file_name = expand("%:t:r")

    if !empty(matchstr(file_extension, reg_file_ext))
        call CStyleHeader(GetHeaderInfo(file_name), file_extension, current_year)
    elseif file_name == makefile
        call MakeStyleHeader(GetHeaderInfo(file_name), current_year)
    else
        echo "Can't apply header, the file type is not recognize!"
    endif
endfunction
