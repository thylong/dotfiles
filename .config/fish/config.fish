set -gx PATH /usr/local/sbin /opt/google-cloud-sdk/bin /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin /usr/local/go/bin /usr/local/MacGPG2/bin /usr/local/bin /Users/(whoami)/www/repositories/bin /Users/(whoami)/anaconda/bin
set -gx EDITOR /usr/bin/vim
set -gx CDPATH . /Users/(whoami) /Users/(whoami)/www/repositories $CDPATH
set -gx GOPATH /Users/(whoami)/www/repositories
set -gx HOMEBREW_CASK_OPTS '--caskroom=/opt/homebrew-cask/Caskroom'
set -gx PROJECT_ID 'chaos-squid'
set -gx ZONE 'us-east1-b'
set -gx REPOSITORIES_PATH /Users/(whoami)/www/repositories
set -gx fish_greeting ''

#NPM3 memory leak
alias npm='node -max_old_space_size=4096 /usr/local/bin/npm'

# Perso
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
alias go colorgo

# The next line updates PATH for the Google Cloud SDK.
bass source '/opt/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
bass source '/opt/google-cloud-sdk/completion.bash.inc'

tmux attach -t base ;or tmux new -s base

# Funtions
function fuck -d 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_commandd $history[1]
    thefuck $fucked_up_commandd > $eval_script
    . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_commandd
    end
end

function condalist -d 'List conda environments.'
  for dir in (ls $HOME/anaconda/envs)
    echo $dir
  end
end

function condactivate -d 'Activate a conda environment' -a cenv
  if test -z $cenv
    echo 'Usage: condactivate <env name>'
    return 1
  end

  # condabin will be the path to the bin directory
  # in the specified conda environment
  set condabin $HOME/anaconda/envs/$cenv/bin

  # check whether the condabin directory actually exists and
  # exit the function with an error status if it does not
  if not test -d $condabin
    echo 'Environment not found.'
    return 1
  end

  # deactivate an existing conda environment if there is one
  if set -q __CONDA_ENV_ACTIVE
    deactivate
  end

  # save the current path
  set -xg DEFAULT_PATH $PATH

  # put the condabin directory at the front of the PATH
  set -xg PATH $condabin $PATH

  # this is an undocumented environmental variable that influences
  # how conda behaves when you don't specify an environment for it.
  # https://github.com/conda/conda/issues/473
  set -xg CONDA_DEFAULT_ENV $cenv

  # set up the prompt so it has the env name in it
  functions -e __original_fish_prompt
  functions -c fish_prompt __original_fish_prompt
  function fish_prompt
    set_color blue
    echo -n '('$CONDA_DEFAULT_ENV') '
    set_color normal
    __original_fish_prompt
  end

  # flag for whether a conda environment has been set
  set -xg __CONDA_ENV_ACTIVE 'true'
end

function deactivate -d 'Deactivate a conda environment'
  if set -q __CONDA_ENV_ACTIVE
    # set PATH back to its default before activating the conda env
    set -xg PATH $DEFAULT_PATH
    set -e DEFAULT_PATH

    # unset this so that conda behaves according to its default behavior
    set -e CONDA_DEFAULT_ENV

    # reset to the original prompt
    functions -e fish_prompt
    functions -c __original_fish_prompt fish_prompt
    functions -e __original_fish_prompt
    set -e __CONDA_ENV_ACTIVE
  end
end


# aliases so condactivate and deactivate can have shorter names
function ca -d 'Activate a conda environment'
  condactivate $argv
end

function cda -d 'Deactivate a conda environment'
  deactivate $argv
end

function updateenvall -d 'Update ATOM and Brew packages'
    fish_update_completions &
    apm update -c false &
    brew update; brew upgrade --all

    brew cask cleanup &
    brew cleanup
    updateenvremotes

    wait
end

function updateenvremotes -d 'Update all repositories remotes'
    echo 'Updating remotes of every repositories.'
    set old_pwd $PWD
    for dir in (ls ~/www/repositories/)
        cd $dir
        if [ -d .git ]
            yes | git fetch 2>/dev/null &
        end
    end
    wait
    cd $old_pwd
    echo 'Remotes updated.'
end

# complete conda environment names when activating
complete -c condactivate -xA -a "(condalist)"
complete -c ca -xA -a "(condalist)"
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
