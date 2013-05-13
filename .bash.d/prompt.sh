if [ -z "$HOSTNAME_SYMBOL" ]; then
  HOSTNAME_SYMBOL=$(_chemical_element_to_symbol $HOSTNAME)
  export HOSTNAME_SYMBOL
fi

PS1="\$HOSTNAME_SYMBOL \w "
