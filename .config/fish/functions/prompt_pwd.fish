function prompt_pwd --description 'Print the current working directory, substituting home with ~'
  echo $PWD | sed -e "s|^$HOME|~|"
end
