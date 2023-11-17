#!/bin/bash

GIT_REPO=https://github.com/codekow/demo-ai-gitops-catalog.git

term_init(){
# avoid making everyone mad
grep -q 'OpenShift Web Terminal' ~/.bashrc || return 1

# shellcheck disable=SC2028
echo "
echo
GIT_REPO=${GIT_REPO}
printf 'This terminal has been \e[0;32m~Enhanced~\e[0m\n'
printf 'See \033[34;1;1m'${GIT_REPO}'\e[0m\n\n'

__git_branch(){
  git name-rev --name-only @ 2>/dev/null
}

PS1='\e]\s\a\n\e[33m\w \e[36m\$(__git_branch)\e[m$ '

if [ -e gitops ]; then
  cd gitops
  . scripts/functions.sh
fi

[ -e ~/.venv/bin/activate ] && . ~/.venv/bin/activate
[ -e ~/gitops/scratch/bin/restic.bash ] && . ~/gitops/scratch/bin/restic.bash

" >> ~/.bashrc

  git clone "${GIT_REPO}" gitops
  cd gitops || return
  # shellcheck disable=SC1091
  . scripts/functions.sh

  [ -d ~/.venv ] || pyvenv-3.6 ~/.venv

  bin_check busybox

  bin_check oc-mirror
  bin_check rclone
  bin_check restic
}
