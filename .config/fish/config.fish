set -gx PATH /usr/local/sbin /opt/google-cloud-sdk/bin /usr/bin /bin /usr/sbin /sbin /usr/local/go/bin /usr/local/bin /Users/(whoami)/www/repositories/bin
set -gx EDITOR /usr/bin/vim
set -gx CDPATH . /Users/(whoami)/www/repositories $CDPATH
set -gx GOPATH /Users/(whoami)/www/repositories
set -gx PROJECT_ID 'chaos-squid'
set -gx ZONE 'us-east1-b'
set -gx REPOSITORIES_PATH /Users/(whoami)/www/repositories
set -gx fish_greeting ''

# The next line updates PATH for the Google Cloud SDK.
bass source '/opt/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
bass source '/opt/google-cloud-sdk/completion.bash.inc'
