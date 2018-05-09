export PATH=$PATH:/usr/local/sbin
export PATH="/usr/local/heroku/bin:$PATH"
export EDITOR=/usr/bin/vi
export CDPATH="/Users/$(whoami)/www/repositories/:/Users/$(whoami)/"
export GOPATH="/Users/$(whoami)/www/repositories/"
export REPOSITORIES_PATH=$GOPATH

# The next line updates PATH for the Google Cloud SDK.
source '/Users/$(whoami)/Downloads/google-cloud-sdk-123.0.0-darwin-x86_64/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/$(whoami)/Downloads/google-cloud-sdk-123.0.0-darwin-x86_64/google-cloud-sdk/completion.bash.inc'
