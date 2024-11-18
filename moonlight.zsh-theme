# Define the prompt structure
PROMPT='
$fg[cyan]%n: $fg[yellow]$(get_pwd) $(git_prompt_info)
$fg[white]╰── $(virtualenv_prompt_info) '

# Function to display the current working directory, replacing the home path with ~
function get_pwd() {
  echo "${PWD/$HOME/~}"
}

# Function to display Git branch information, with customization for dirty and clean states
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Function to display virtual environment information
function virtualenv_prompt_info() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "($ZSH_THEME_VIRTUALENV_PREFIX`basename $VIRTUAL_ENV`$ZSH_THEME_VIRTUALENV_SUFFIX)"
  fi
}

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="(on branch: "
ZSH_THEME_GIT_PROMPT_SUFFIX=")$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]x "
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"

# Virtual environment prompt settings
ZSH_THEME_VIRTUALENV_PREFIX=""
ZSH_THEME_VIRTUALENV_SUFFIX=""

# Optional: Function to indicate if the current Git branch is "dirty" (uncommitted changes)
function parse_git_dirty() {
  git diff --quiet --ignore-submodules HEAD &>/dev/null
  [[ $? -ne 0 ]] && echo "$ZSH_THEME_GIT_PROMPT_DIRTY" || echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
}
