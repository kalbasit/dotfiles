# swap() -- switch 2 filenames around
# Credit: https://github.com/Daenyth/dotfiles/blob/a22723420e780f04a77ebab8dd2737cfaba43c42/.bashrc#L77-L85
function swap()
{
  local TMPFILE="$( mktemp -p . swap.XXXXXXX )"
    mv "$1" "${TMPFILE}"
    mv "$2" "$1"
    mv "${TMPFILE}" "$2"
}
