# Alias for nvim if it exists
if nvim_loc="$(type -p nvim)" && [[ -n $nvim_loc ]]; then
	alias vim="nvim"
	alias vi="nvim"
	alias vimdiff="nvim -d"
	export EDITOR="nvim"
else
	export EDITOR="vim"
fi
export VISUAL="$EDITOR"