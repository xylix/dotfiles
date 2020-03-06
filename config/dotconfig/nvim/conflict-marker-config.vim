" Disable conflict market feature that requires matchit.vim
let g:conflict_marker_enable_matchit = 0
" Replace conflict marker plugin default coloring settings with own
let g:conflict_marker_highlight_group = ''
" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'
" Set highlight colors
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049 
highlight ConflictMarkerTheirs guibg=#344f69 
highlight ConflictMarkerEnd guibg=#2f628e
"Keep none: cn or :ConflictMarkerNone
"Keep ours: co or :ConflictMarkerOurselves
"Keep theirs: ct or :ConflictMarkerThemselves
"Keep both cb or :ConflictMarkerBoth

