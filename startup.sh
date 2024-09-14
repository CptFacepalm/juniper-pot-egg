#! /bin/bash
echo "Checking for updates"
DOTNET_BUNDLE_EXTRACT_BASE_DIR="/home/container/lib" ./AlderonGamesCmd --game path-of-titans --server true --auth-token $AG_AUTH_TOKEN --beta-branch $BETA_BRANCH --install-dir .
echo "Updating server roles"
wget -O /home/container/PathOfTitans/Saved/Config/LinuxServer/Commands.ini https://raw.githubusercontent.com/CptFacepalm/juniper-pot-egg/main/Commands.ini
echo "Waiting for 5 seconds to ensure update completes..."
sleep 5
echo "Starting server"
UE_TRUE_SCRIPT_NAME=$(echo \"$0\" | xargs readlink -f)
UE_PROJECT_ROOT=$(dirname "$UE_TRUE_SCRIPT_NAME")
chmod +x "$UE_PROJECT_ROOT/PathOfTitans/Binaries/Linux/PathOfTitansServer-Linux-Shipping"
"$UE_PROJECT_ROOT/PathOfTitans/Binaries/Linux/PathOfTitansServer-Linux-Shipping" PathOfTitans -log -Port=$SERVER_PORT -BranchKey=$BETA_BRANCH -AuthToken=$AG_AUTH_TOKEN -ServerGUID=$SERVER_GUID -Database=$DATABASE -ServerListIP=$SERVER_LIST_IP
