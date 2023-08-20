if exists("g:loaded_transform_html_to_styled_components")
  finish
endif

let g:loaded_transform_html_to_styled_components = 1

command! HTMLToStyled :call transform_html_to_styled_components#TransformHTMLToStyled()
