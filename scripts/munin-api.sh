SCRIPT=$( basename "$0" )

VERSION="0.0.1"

TOKEN_FILE="$HOME/.munin_token"   # set path token file  
USERNAME=$EB_AUTH_USER            # set auth user (use admin account else -c flag wont work)
PASSWORD=$EB_AUTH_PASS            # set auth pass

function usage
{
    local txt=(
    "$SCRIPT A simple cli to call munin-api and retrive the status of a package"
"Usage: $SCRIPT [options] tracking-id"
""
"Options:"
"  -h     help"
"  -l     get latest (default get all)"
"  -e     set environment {dev, test, stage, prod} (default prod)"
"  -c     set customer id (default uses customer of the jwt token)"
"  -a     Authenticate and save token to disk."
""
"Example:"
    )

    printf "%s\\n" "${txt[@]}"
}

ENVIRONMENT=api #prod default
OPERATION=all
AUTH_ONLY=false

while getopts 'ahle:c:' OPTION ; do
  case "$OPTION" in
    a) AUTH_ONLY=true ;;
    c) CUSTOMER=$OPTARG ;;
    e) ENVIRONMENT=$OPTARG ;;
    l) OPERATION=latest ;;
    h) usage; exit 0 ;;
    *) exit 1;;
  esac
done
shift $(($OPTIND -1))

INPUT=$1

function authenticate {
    TOKEN=$(curl -s -X POST "https://$ENVIRONMENT.earlybird.se/auth/token" \
        -H "Content-Type: application/json" \
        -d "{\"username\": \"$USERNAME\", \"password\": \"$PASSWORD\"}" | jq -r '.token')

    if [ -z "$TOKEN" ] || [ "$TOKEN" == "null" ]; then
        echo "Error: Failed to retrieve token. Check credentials or environment."
        exit 1
    fi

    echo "$TOKEN" > "$TOKEN_FILE"
    echo "Token saved to $TOKEN_FILE."
}

if $AUTH_ONLY; then
    authenticate
    exit 0
fi

if [ ! -f "$TOKEN_FILE" ]; then
    echo "Token file not found. Authenticating..."
    authenticate
fi

TOKEN=$(cat "$TOKEN_FILE")

if [ -z "$INPUT" ]; then
    echo "Error: Tracking ID is required."
    usage
    exit 1
fi

QUERY_PARAMS="?language=en"
if [[ -n CUSTOMER ]]; then
  QUERY_PARAMS+="&customer-id=$CUSTOMER"
fi

URL="https://$ENVIRONMENT.earlybird.se/v1/status/$INPUT/$OPERATION$QUERY_PARAMS"

RESPONSE=$(curl -s -w "\n%{http_code}" -X GET "$URL" \
  -H "Authorization: Bearer $TOKEN")

BODY=$(echo "$RESPONSE" | sed '$ d')    # All lines except the last
STATUS_CODE=$(echo "$RESPONSE" | tail -n 1)  # Last line is the status code

if [ "$STATUS_CODE" -eq 200 ]; then
    echo "$BODY" | jq || echo "Error: Invalid JSON response"
else
    ERROR_MSG=$(echo "$BODY" | jq -r '.error.message // "Unknown error"')
    echo "HTTP Status Code: $STATUS_CODE - $ERROR_MSG"
fi
