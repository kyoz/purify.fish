# name: purify

# base on: https://github.com/oh-my-fish/theme-clearance
# ---------------
# Just a minimalism theme:
# Support:
# - Current directory name
# - Git branch & states (when inside a git repo)

function _git_branch
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l last_status $status

  set -l normal (set_color normal)
  set -l black (set_color 282C34)
  set -l white (set_color FAFAFA)
  set -l cyan (set_color 5FAFFF)
  set -l hotpink (set_color ff5fd7)
  set -l red (set_color FF6059)
  set -l green (set_color 5FFF87)
  set -l yellow (set_color FFFF87)
  set -l blue (set_color 5FAFFF)
  set -l magenta (set_color AF87FF)

  set -l cwd $blue(pwd | sed "s:^$HOME:~:")

  # Output the prompt, left to right

  # Add a newline before new prompts
  echo -e ''

  # Print pwd or full path
  echo -n -s $cwd $normal

  # Show git branch and status
  if [ (_git_branch) ]
    set -l git_branch (_git_branch)

    if [ (_git_is_dirty) ]
      set git_info $red $git_branch " !" $normal
    else
      set git_info $green $git_branch " √" $normal
    end
    echo -n -s ' ⇢ ' $git_info $normal
  end

  set -l prompt_color $red
  if test $last_status = 0
    set prompt_color $normal
  end

  # Terminate with a nice prompt char
  echo -e ''
  echo -e -n -s $hotpink'❯ ' $normal
end

function fish_right_prompt
  #intentionally left blank
end
