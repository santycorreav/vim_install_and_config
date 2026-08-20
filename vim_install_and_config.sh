#!/bin/bash

echo "Iniciando script de instalacion y configuracion de Vim para Void Linux..."

# 1. Verificar e instalar vim-x11
echo "Paso 1: Verificando instalacion de vim-x11..."
if xbps-query -l | grep -q "vim-x11"; then
    echo " -> vim-x11 ya se encuentra instalado en el sistema. Omitiendo instalacion."
else
    echo " -> vim-x11 no esta instalado. Se requieren permisos de administrador para instalar."
    sudo xbps-install -y vim-x11
    echo " -> Instalacion de vim-x11 completada exitosamente."
fi

# Definir rutas de los archivos
VIMRC_FILE="$HOME/.vimrc"
VIMRC_BACKUP="$HOME/.vimrc_backup"

# 2. Verificar existencia de .vimrc y crear backup
echo "Paso 2: Verificando la existencia del archivo .vimrc..."
if [ -f "$VIMRC_FILE" ]; then
    echo " -> El archivo .vimrc ya existe. Creando copia de seguridad en $VIMRC_BACKUP..."
    cp "$VIMRC_FILE" "$VIMRC_BACKUP"
    echo " -> Copia de seguridad creada."
else
    echo " -> No se encontro un archivo .vimrc previo. Se creara uno nuevo."
fi

# 3. Verificar si la configuracion ya esta aplicada y escribir el archivo
echo "Paso 3: Verificando si la configuracion actual ya esta aplicada..."
if [ -f "$VIMRC_FILE" ] && grep -q "EXPLORADOR DE ARCHIVOS (NETRW)" "$VIMRC_FILE"; then
    echo " -> La configuracion ya se encuentra presente en tu .vimrc. No se realizaran modificaciones para evitar duplicados."
else
    echo " -> Aplicando la configuracion de desarrollo en $VIMRC_FILE..."
    
    # Se usa cat con 'EOF' entre comillas simples para evitar la expansion de variables por parte de bash
    cat << 'EOF' > "$VIMRC_FILE"
" Guardar como ~/.vimrc
" Vimrc rapido y sin colores, con numeros de linea

set nocompatible          " Mantener todas las funciones de Vim (importante)
set number                " Mostrar numeros de linea

" Set number numeros en amarillo
highlight LineNr ctermfg=yellow ctermbg=NONE

" El numero de la linea actual, naranja suave (sin resaltar)
highlight CursorLineNr ctermfg=208 ctermbg=NONE cterm=NONE

" set relativenumber      " (opcional) numeros relativos; comenta si no lo quieres
set backspace=indent,eol,start  " Backspace normal

" --- Desactivar colores / colorscheme ---
" syntax off                " Apaga el resaltado de sintaxis (sin colores)
syntax on
set background=dark
colorscheme industry
highlight Normal ctermfg=229 guifg=#fef08a
set t_Co=256                " Terminal sin soporte de color
" set notermguicolors       " No usar truecolor en terminal

" --- Rendimiento / rapidez ---
set lazyredraw            " No redibujar durante macros (mas rapido)
set ttyfast               " Asume terminal rapida
set synmaxcol=200         " Limita columnas para resaltado (por si activas syntax)
set regexpengine=1        " Motor de regex clasico (mas rapido)
" set noshowmode            " No mostrar modo en la ultima linea
set noerrorbells          " Sin pitidos de error
set visualbell t_vb=      " Sin campana visual

" --- Funciones utiles (no desactivan nada importante) ---
filetype plugin indent on " Deteccion de tipo de archivo e indentacion
set hidden                " Permitir cambiar de buffer sin guardar
set wildmenu              " Mejor autocompletado en linea de comandos
set showcmd               " Mostrar comandos parciales
set incsearch             " Busqueda incremental
set hlsearch              " Resaltar resultados de busqueda
set ignorecase            " Ignorar mayusculas en busquedas
set smartcase             " Distinguir mayusculas si escribes alguna
set autoindent            " Indentacion automatica
set expandtab             " Usar espacios en lugar de tabuladores
set shiftwidth=2          " Indentacion de 2 espacios
set tabstop=2             " Tabulador = 2 espacios
set softtabstop=2         " Tabulador suave

" Si algun dia quieres recuperar los colores, comenta las 3 lineas de
" "Desactivar colores" y descomenta estas:
" syntax on
" set t_Co=256
" set termguicolors
"
" set cursorline      " Linea horizontal (resalta la fila del cursor)
" set cursorcolumn    " Linea vertical (resalta la columna del cursor)

set cursorline
set cursorcolumn

highlight CursorLine cterm=underline ctermbg=NONE
highlight CursorColumn ctermbg=235

" ===================== EXPLORADOR DE ARCHIVOS (NETRW) =====================
" Configuracion para barra lateral con arbol de archivos
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 20

" ¡SUPER IMPORTANTE para tu diseno!: Hace que las nuevas ventanas se abran a la derecha
" Asi queda: Arbol (Izquierda) -> .vimrc (Medio) -> .bashrc (Derecha)
set splitright

" Lider para atajos: tecla espacio
let mapleader = " "

" Alternar (abrir/cerrar) el explorador con <Space> + e
nnoremap <leader>e :Lexplore<CR>

" ===================== FUNCIONES PARA ABRIR ARCHIVOS DESDE NETRW =====================
function! NetrwMappings()
    " El <Enter> normal ya funciona nativamente en Lexplore para REEMPLAZAR el archivo 
    " en la ventana principal. No necesitamos programar nada extra.

    " Para ABRIR ADICIONAL (split vertical): 
    " Mapeamos <Space> + <Enter> para que ejecute la accion nativa de split vertical ('v')
    nmap <buffer> <leader><CR> v
endfunction

" Aplicar los atajos solo cuando estemos dentro del arbol
autocmd filetype netrw call NetrwMappings()

" ===================== ATAJO PARA CERRAR ARCHIVO ACTUAL =====================
" Con <Space> + q se cierra la ventana actual (el archivo), no cierra el arbol
function! CloseCurrentFile()
    if &filetype == 'netrw'
        echo "Estas en el arbol, usa <Space>e para cerrarlo"
        return
    endif
    close
endfunction
nnoremap <leader>q :call CloseCurrentFile()<CR>

" ===================== ATAJO PARA CAMBIAR ENTRE VENTANAS =====================
" Cambiar el foco entre ventanas (como Alt+Tab pero solo con Espacio y Tab)
" Con <Space> + Tab saltas de ventana en ventana
nnoremap <leader><Tab> <C-w>w
inoremap <leader><Tab> <C-w>w

" ===================== SOPORTE DE MOUSE =====================
" Habilitar el raton por si quieres usarlo en el arbol
set mouse=a
EOF
    echo " -> Configuracion de .vimrc aplicada correctamente."
fi

echo "Proceso finalizado. El entorno Vim esta listo."
