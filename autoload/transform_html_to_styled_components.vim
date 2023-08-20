" transform_html_to_styled_components.vim Provide refactors from HTML to
" styled-components

function! s:mountStyledConstant(target, original) abort
  let l:styled_prefix = 'styled.'.a:original

  if a:original =~ '^\u'
    let l:styled_prefix = printf('styled(%s)', a:original)
  endif

  return printf('export const %s = %s``;', a:target, l:styled_prefix)
endfunction

" Section: Transform a regular HTML tag into a styled component version on a
" vertical split
" 1. Run this function on a html tag like <div></div>
" 2. A input will be shown asking you the name of this tag (need to be
" capitalized)
" 3. A vertical split will be opened on the file `styles.ts` with a pre
" defined styled line filled using the original tag and the target tag name
" information.
" 4. The tag will be turned into a S.YourTagName format
" Disclaimer: All the import statements will *not* be inserted automatically,
" use your LSP for that.
" Disclaimer: This function rely a lot on the [tagalong](https://github.com/AndrewRadev/tagalong.vim) plugin
function! transform_html_to_styled_components#TransformHTMLToStyled() abort
  let l:original_tag_name = expand('<cword>')
  let l:target_tag_name = input('Styled tag name: ')
  let l:content = s:mountStyledConstant(l:target_tag_name, l:original_tag_name)
  let l:styles_file_path = expand('%:h') . '/' . 'styles.ts'

  execute 'normal ciw' . 'S.'.l:target_tag_name

  if utils#SplitExistsForFile(l:styles_file_path)
    call utils#ChangeToSplitWithFile(l:styles_file_path)
  else
    call execute('vs '.l:styles_file_path)
  endif

  call append(line('$'), l:content)
  execute 'normal G'
endfunction
