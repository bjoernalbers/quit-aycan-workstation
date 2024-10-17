#!/bin/bash
# Try to quit aycan workstation gently, or kick it hard in the balls.

set -u

# quit kindly asks the app to quit and waits for it to exit.
# If quitting fails or the app is still running after some grace period
# an error is returned.
quit() {
	local app="$1"
	local app_pids
	local app_users
	local max_wait_seconds=5
	
	app_pids=$(pgrep -d, -x "${app}")
	[[ -z "${app_pids}" ]] && return 0
	app_users=$(ps -p "${app_pids}" -o user= | sort -u)
	for user in $app_users; do
		sudo --non-interactive --user "${user}" osascript -e "quit app \"${app}\"" &>/dev/null || return 1
	done
	for ((i = 0 ; i < max_wait_seconds ; i++ )); do
		pgrep -qx "${app}" || return 0
		sleep 1
	done
	return 1
}

if [[ "${EUID}" -ne 0 ]]; then
	echo "Please run as root!" >&2
	exit 1
fi

# aycan workstation has to be stopped first because aycan workstation Manager
# refuses to quit if aycan workstation is still running.
for app in "aycan workstation" "aycan workstation Manager"; do
	# If quitting fails, maybe a TERM signal will do.
	quit "${app}" || pkill -x "${app}"
done

# Ensure that really no matching process is left alive.
sleep 1
pkill -9 -f "aycan workstation Manager.app"

exit 0
