alias a29=". ~/.venv/ansible29/bin/activate.fish"
alias tm="tmux new-session -A -s main"
alias ls="exa --git --icons --group-directories-first"
alias v="nvim"
alias vim="nvim"
alias cat="bat -f -p -P"
alias less="bat -f -p"

set -x MANPAGER "bat -f -p"
set -x PAGER "bat -f -p"
set -x EDITOR "nvim"

set -U fish_user_paths ~/go/bin/ $fish_user_paths


set fish_greeting

# Options
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "verbose"

# Colors
set green (set_color green)
set magenta (set_color magenta)
set normal (set_color normal)
set red (set_color red)
set yellow (set_color yellow)

set __fish_git_prompt_color_branch magenta --bold
set __fish_git_prompt_color_dirtystate white
set __fish_git_prompt_color_invalidstate red
set __fish_git_prompt_color_merging yellow
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Icons
set __fish_git_prompt_char_cleanstate '✔'
set __fish_git_prompt_char_conflictedstate '×'
set __fish_git_prompt_char_dirtystate '+'
set __fish_git_prompt_char_invalidstate '╳'
set __fish_git_prompt_char_stagedstate '●'
set __fish_git_prompt_char_stashstate '📦'
set __fish_git_prompt_char_stateseparator '|'
set __fish_git_prompt_char_untrackedfiles '…'
set __fish_git_prompt_char_upstream_ahead '∧'
set __fish_git_prompt_char_upstream_behind '∨'
set __fish_git_prompt_char_upstream_diverged '❖'
set __fish_git_prompt_char_upstream_equal '★'

function fish_prompt
	set last_status $status
	set_color $fish_color_cwd
	printf '%s>' (prompt_pwd)
	set_color normal
end

function fish_right_prompt
	set -l last_status $status
	set_color normal
	printf '%s ' (__fish_git_prompt)
	if test $last_status -eq 0
		set_color green
		printf "✓"
	else
		set_color red
		printf "⨯"
	end
	if test $CMD_DURATION
		set duration (echo "$CMD_DURATION 1000" | awk '{printf "(%.3fs)", $1 / $2}')
		echo $duration
	end
end

# Functions needed for !! and !$
function __history_previous_command
	switch (commandline -t)
	case "!"
		commandline -t $history[1]; commandline -f repaint
	case "*"
		commandline -i !
	end
end

function __history_previous_command_arguments
	switch (commandline -t)
	case "!"
		commandline -t ""
		commandline -f history-token-search-backward
	case "*"
		commandline -i '$'
	end
end

# The bindings for !! and !$
if [ $fish_key_bindings = "fish_vi_key_bindings" ];
	bind -Minsert ! __history_previous_command
	bind -Minsert '$' __history_previous_command_arguments
else
	bind ! __history_previous_command
	bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end


### ----

function bass
  set -l bash_args $argv
  set -l bass_debug
  if test "$bash_args[1]_" = '-d_'
    set bass_debug true
    set -e bash_args[1]
  end

  set -l script_file (mktemp)
  if command -v python3 >/dev/null 2>&1
    command python3 -sS (dirname (status -f))/__bass.py $bash_args 3>$script_file
  else
    command python -sS (dirname (status -f))/__bass.py $bash_args 3>$script_file
  end
  set -l bass_status $status
  if test $bass_status -ne 0
    return $bass_status
  end

  if test -n "$bass_debug"
    cat $script_file
  end
  source $script_file
  command rm $script_file
end

function __bass_usage
  echo "Usage: bass [-d] <bash-command>"
end

function bsource
	bass source $argv
end
