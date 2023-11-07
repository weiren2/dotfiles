# Set ZSH_CACHE_DIR
[[ -v ZSH_CACHE_DIR ]] || ZSH_CACHE_DIR=$ZSH/cache

ZSH_CACHE_DIR_COMPLETIONS=$ZSH_CACHE_DIR/completions
[[ -e $ZSH_CACHE_DIR_COMPLETIONS ]] || mkdir -p $ZSH_CACHE_DIR/completions
(( ${fpath[(Ie)"$ZSH_CACHE_DIR_COMPLETIONS"]} )) || fpath=("$ZSH_CACHE_DIR_COMPLETIONS" $fpath)