# This file is part of a bigger script!
#
# Be careful when editing it

# ----------------------------------------------------------------------
#   
# Script devoloped to only Everet Ramos
#
# Developed by
#   Evert Ramos <evert.ramos@gmail.com>     
#
# Copyright Evert Ramos with usage right granted to only Everet Ramos
#
# ----------------------------------------------------------------------

# Script to check if service is running (docker-compose)

check_service_running()
{
    local LOCAL_PATH LOCAL_DOMAIN LOCAL_RESULTS LOCAL_COMPOSE_PATH
    
    if [[ ! -z $1 ]]; then
        LOCAL_PATH=$1
    else
        LOCAL_PATH=$SOURCE_FOLDER
    fi

    if [[ ! -z $2 ]]; then
        LOCAL_DOMAIN=$2
    else
        LOCAL_DOMAIN=$DOMAIN
    fi

    if [[ "$DEBUG" == true ]]; then
        echo "Checking if there is any service running for: '"$LOCAL_DOMAIN"' running at '$LOCAL_PATH'"
    fi

    # Check if SOURCE_FOLDER exists
    run_function check_folder_exists $LOCAL_PATH"/"$LOCAL_DOMAIN

    if [[ "$FOLDER_EXIST" != true ]]; then
        echoerror "We could not find the folder '"$LOCAL_PATH"/"$LOCAL_DOMAIN"'. Please update our --source option or the SITES_FOLDER in your .env file. This PATH should hold the folder where all your sites data are located."
    else
        LOCAL_COMPOSE_PATH=$LOCAL_PATH"/"$LOCAL_DOMAIN"/compose"
    fi
 
    cd $LOCAL_COMPOSE_PATH
    LOCAL_RESULTS=$(docker-compose ps | grep "Up" | wc -l)
    cd - > /dev/null 2>&1

    # Check results
    if [[ $LOCAL_RESULTS > 0 ]]; then
        SERVICE_RUNNING=true
    else 
        SERVICE_RUNNING=false
    fi
}

