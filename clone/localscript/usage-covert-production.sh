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

# Script to show the usage function
usage_convert_production()
{
    cat << USAGE >&2
${blue}
Usage:
    $SCRIPT_NAME -nu your_new_url.com [-u your_site_url] 
                 [-s source_folder] [-d destination_folder]
                 [--no-start] [--wp-debug] [--debug] [--silent]
                 [--filter="string"]

    Or use long options:
    $SCRIPT_NAME --new-url=your_new_url.com [--url=your_site_url] 
                 [--source=source_folder] [--destination=destination_folder]
                 [--no-start] [--wp-debug] [--debug] [--silent]

    Recommended
    -nu | --new-url         The new URL for the clone site

    Alternatively you may inform the options below
    -u | --url              The new url for the cloning site
    -s | --source           Folder where the docker-compose.yml for the running site is located
    -d | --destination      Folder where the clone site will be located
    -h | --help             Display this help
    --no-start              Clone the site but does not start the docker-compose services
                            [WARNING!] Careful when cloning sites with the same URL.
                            It is recommended you ALWAYS USE the --new-url option.
    --filter=""             In order to filter the list of foler/URL you may inform the
                            option '--filter' to show only the ones that contains a 
                            certain string.

    There is some debug options you may use in order to hide or show more details
    --wp-debug              Turn WP_DEBUG option to true on wp-config file
    --debug                 Show script debug options
    --silent                Hide all script message

${reset}
USAGE
    exit 1
}
