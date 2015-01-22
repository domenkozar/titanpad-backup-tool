DOMAIN=
USER=
PASSWORD=
PURGE_OLD_FILES=

COOKIE=~/titanpad/.cookie
LOCATION=~/titanpad/titanpad_backup_pads_$(date "+%Y-%m-%d").zip

usage() { echo "Usage: $0 -d <subdomain> -u <user> -p <password>" 1>&2; exit 1; }

# make sure backup directory exists
ensure_paths() {
    mkdir -p ~/titanpad
    touch $COOKIE
}

# login and set cookie
login() {
    wget --no-check-certificate \
         --keep-session-cookies \
         -O /dev/null \
         --save-cookies $COOKIE \
        "https://$DOMAIN.titanpad.com/"
    wget --no-check-certificate \
         --load-cookies $COOKIE \
         -O /dev/null \
         --post-data "email=$USER&password=$PASSWORD" \
         "https://$DOMAIN.titanpad.com/ep/account/sign-in" 
}

# remove cookie
logout() {
    rm $COOKIE
}

# download the newest pad
download_newest_pad() {
    wget --load-cookies $COOKIE \
         --no-check-certificate \
         --quiet \
         -O "$LOCATION" \
         "https://$DOMAIN.titanpad.com/ep/padlist/all-pads.zip"
}

# verify zip file
verify_download() { 
    unzip -t "$LOCATION"
}

# delete older files than a month
delete_old_files() {
    if [ "$PURGE_OLD_FILES" == 1 ];then
        find ~/titanpad/titanpad_backup_pads* -mtime +30 -exec rm {} \;
    fi
}


while getopts ":d:u:p:x" o; do
    case "${o}" in
        d)
            DOMAIN=${OPTARG}
            ;;
        u)
            USER=${OPTARG}
            ;;
        p)
            PASSWORD=${OPTARG}
            ;;
        x)
            PURGE_OLD_FILES=1
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))
if [ -z "$DOMAIN" ] || [ -z "$USER" ] || [ -z "$PASSWORD" ]; then
    usage
fi

ensure_paths
login
download_newest_pad
verify_download
logout
delete_old_files
