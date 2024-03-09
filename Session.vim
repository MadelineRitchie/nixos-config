let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/nixos-config
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +15 machines/mystique-2024-02/nixos/configuration.nix
badd +1 machines/mystique-2024-02/nixos/flake.lock
badd +17 ~/nixos-config/mystique-flake.nix
badd +1 machines/mystique-2024-02/nixos/hardware-configuration.nix
badd +7 switch
badd +0 bootstrap-new-nixos.ps1
badd +0 lsiommu-simple.sh
badd +0 lsiommu.sh
badd +39 users/madeline/home.nix
badd +90 users/shared.nix
badd +28 ~/repos/gvolpe-nix-config/switch
badd +1 machines/mystique-2024-02/nixos/flake.nix
argglobal
%argdel
$argadd machines/mystique-2024-02/nixos/configuration.nix
$argadd machines/mystique-2024-02/nixos/flake.lock
$argadd ~/nixos-config/mystique-flake.nix
$argadd machines/mystique-2024-02/nixos/hardware-configuration.nix
edit ~/nixos-config/mystique-flake.nix
argglobal
3argu
balt machines/mystique-2024-02/nixos/flake.nix
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 17 - ((16 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 17
normal! 029|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
