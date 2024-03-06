#!/bin/bash
#source activate pymaap
# Ensure $HOME exists when starting
if [ ! -d "${HOME}" ]; then
  mkdir -p "${HOME}"
fi

# Add current (arbitrary) user to /etc/passwd and /etc/group
if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
    echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi

jupyter lab --ip=0.0.0.0 --port=3100 --allow-root --ContentsManager.allow_hidden=True --ServerApp.token='' --no-browser --debug --ServerApp.disable_check_xsrf=True  --ResourceUseDisplay.mem_warning_threshold=0.2

whoami
which python
echo $PATH
echo $@
exec "$@"
