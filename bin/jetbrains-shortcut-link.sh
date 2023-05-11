#!/usr/bin/env bash
set -eux

LOCAL_JB_SHORTCUT_PATH="$HOME/.local/share/applications"
GLOBAL_SHORTCUT_PATH="/usr/share/applications"

LIST_LOCAL_DESKTOP=$(find "$LOCAL_JB_SHORTCUT_PATH" -maxdepth 1 -type f -regex '.*jetbrains\-[a-z]+\.desktop$')

for dot_desktop in ${LIST_LOCAL_DESKTOP}; do
  FILE_NAME=$(basename "${dot_desktop}")
  if [[ -f "${GLOBAL_SHORTCUT_PATH}/${FILE_NAME}" ]]; then
    sudo rm -f "${GLOBAL_SHORTCUT_PATH}/${FILE_NAME}"
  fi
  sudo ln -s "${dot_desktop}" "${GLOBAL_SHORTCUT_PATH}/${FILE_NAME}"
done;

exit 0
