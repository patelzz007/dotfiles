# ==============================================================================
# colors.zsh: named terminal colours, typed as an associative array.
#
#   print -- "${CLR[blue_b]}bold blue${CLR[reset]} normal"
#
# `_b` = bold. Replaces the old NC/RESET/BLUEB/... string variables.
# ==============================================================================

typeset -gA CLR=(
    reset    $'\e[0m'
    dim      $'\e[2m'
    red      $'\e[0;31m'    red_b     $'\e[1;31m'
    green    $'\e[0;32m'    green_b   $'\e[1;32m'
    yellow   $'\e[0;33m'    yellow_b  $'\e[1;33m'
    blue     $'\e[0;34m'    blue_b    $'\e[1;34m'
    purple   $'\e[0;35m'    purple_b  $'\e[1;35m'
    cyan     $'\e[0;36m'    cyan_b    $'\e[1;36m'
    white    $'\e[0;37m'    white_b   $'\e[1;37m'
)
