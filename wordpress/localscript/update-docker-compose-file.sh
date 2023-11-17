#-----------------------------------------------------------------------
#
# Server Automation - https://github.com/evertramos/server-automation
#
# Developed by
#   Evert Ramos <evert.ramos@gmail.com>
#
# Copyright Evert Ramos
#
#-----------------------------------------------------------------------
#
# Be careful when editing this file, it is part of a bigger script!
#
#-----------------------------------------------------------------------

# ----------------------------------------------------------------------
# This function has one main objective:
# 1. Update all variables in docker-compose file for the new site
#
# You must/might inform the parameters below:
# 1. Full path to the docker-compose file
# 2. [optional] (default: )
#
# ----------------------------------------------------------------------

local_update_docker_compose_file()
{
    local LOCAL_FULL_PATH 

    LOCAL_FULL_PATH=${1}
	
	echo "-----------------LOCAL_FULL_PATH--------------------------"
	echo $LOCAL_FULL_PATH

    [[ $LOCAL_FULL_PATH == "" || $LOCAL_FULL_PATH == null ]] && echoerror "You must inform the required argument(s) to the function: '${FUNCNAME[0]}'"

    [[ "$DEBUG" == true ]] && echo "[local_update_docker_compose_file] Updating all variables in .env file for a new site (file: ${LOCAL_FULL_PATH})"

    if [[ ! -f "${LOCAL_FULL_PATH%/}/.env" ]]; then
        RESPONSE_LOCAL_UPDATE_DOCKER_COMPOSE_FILE="You must have set '.env' file, which was not found at '${LOCAL_FULL_PATH%/}'"
        return 0
    else
        source ${LOCAL_FULL_PATH%/}"/.env"
    fi

    run_function docker_compose_replace_string $LOCAL_FULL_PATH "$REPLACE_DB_SERVICE_NAME" "$LOCAL_CONTAINER_DB_NAME"
    run_function docker_compose_replace_string $LOCAL_FULL_PATH "$REPLACE_SITE_SERVICE_NAME" "$LOCAL_CONTAINER_SITE_NAME"
    # Update proxy network
    run_function docker_compose_replace_string $LOCAL_FULL_PATH "$REPLACE_PROXY_NETWORK_NAME" "$NETWORK"

    # Comment or uncomment LETSENCRYPT in docker-compose.yml file
    [[ "$DISABLE_LETSENCRYPT" == true ]] && run_function file_comment_line_with_string "${LOCAL_FULL_PATH%/}/docker-compose.yml" "LETSENCRYPT_HOST" && run_function file_comment_line_with_string ${LOCAL_FULL_PATH%/}"/docker-compose.yml" "LETSENCRYPT_EMAIL"

    return 0
}
