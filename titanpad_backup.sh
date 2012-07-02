DOMAIN="ie"
COOKIES=~/.titanpad_cookies
LOCATION=~/titanpad/titanpad_backup_pads_$(date "+%Y-%m-%d").zip

touch $COOKIES
mkdir -p ~/titanpad
wget    --no-check-certificate \
	--keep-session-cookies \
	--quiet \
	-O /dev/null \
	--save-cookies ~/.titanpad_cookies \
	"https://$DOMAIN.titanpad.com/"
wget    --no-check-certificate \
	--load-cookies ~/.titanpad_cookies \
	--quiet \
	-O /dev/null \
	--post-data "email=$1&password=$2" \
	"https://$DOMAIN.titanpad.com/ep/account/sign-in" 
wget    --load-cookies ~/.titanpad_cookies \
	--no-check-certificate \
	--quiet \
	-O "$LOCATION" \
	https://$DOMAIN.titanpad.com/ep/padlist/all-pads.zip
rm $COOKIES

# verify zip file
unzip -t "$LOCATION"

# delete older files than a month
find ~/titanpad/titanpad_backup_pads* -mtime +30 -exec rm {} \;
