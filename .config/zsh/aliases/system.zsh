if $(gls &>/dev/null)
then
  alias l="gls -lAhF --group-directories-first --color"
  alias ll="gls -lAhF --group-directories-first --color"
  alias ls="gls -F --color"
fi