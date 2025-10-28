#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Heartbeat for CRM
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🔍
# @raycast.argument1 { "type": "text", "placeholder": "e.g., test14.lfx or stage.cfx or prod.hw" }
# @raycast.packageName Heartbeat


INPUT=$1

# Extract environment and brand shortcode
ENV=$(echo "$INPUT" | cut -d'.' -f1)
SHORTCODE=$(echo "$INPUT" | cut -d'.' -f2)

# Map shortcodes to full brand names
case $SHORTCODE in
    lfx)
        BRAND="lhfx"
        ;;
    cfx)
        BRAND="cedarfx"
        ;;
    hw)
        BRAND="hugosway"
        ;;
    *)
        echo "Unknown brand shortcode: $SHORTCODE"
        echo "Use: lfx (lhfx), cfx (cedarfx), or hw (hugosway)"
        exit 1
        ;;
esac

URL="https://${ENV}.${BRAND}.com/heartbeat"

echo "Checking: $URL"
echo ""

RESPONSE=$(curl -sL "$URL")
HTTP_CODE=$(curl -sL -o /dev/null -w "%{http_code}" "$URL")

# Handle different status codes
if [ "$HTTP_CODE" = "000" ]; then
    echo "FAILED: Cannot reach server"
    echo "Could be DNS resolution failure or server is down or network error"
elif [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
    echo "Status: $HTTP_CODE"
    echo ""
    echo "Response:"
    echo "$RESPONSE" | jq '.' 2>/dev/null || echo "$RESPONSE"
elif [ "$HTTP_CODE" -ge 400 ]; then
    echo "Status: $HTTP_CODE (Error)"
    echo ""
    echo "Response:"
    echo "$RESPONSE"
else
    echo "Status: $HTTP_CODE"
    echo ""
    echo "Response:"
    echo "$RESPONSE"
fi