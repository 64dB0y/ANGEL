#!/system/bin/sh

# check system architecture
getprop ro.product.cpu.abi

# dirname is command to extract directory path for file
# $0 means current file's name with path
script_parent_dir=$(dirname "$0")
current_datetime=$(date +"%Y-%m-%d_%H-%M-%S")

# Check if an argument was passed
if [ "$#" -gt 0 ]; then
    target_dir="$1"
else
    target_dir="$script_parent_dir/$current_datetime/InActive_Data"
fi

mkdir -p "$target_dir" || { echo "Failed to create directory"; exit 1; }

echo -en $'\E[93m'
echo $'                         ..::::::::::::::..  .:'                               
echo $'                       .::::::::::--:.-:::::::::--==-.--:::.'                         
echo $'                 ..:---::---:::.    ..              .:--=-----:.'                     
echo $'               .-:--:---:                               ...:------.'                  
echo $'              :-.:==-.                                     .:-=-.:-:'                 
echo $'              ::.:=-.                                        .:+-..-.'                
echo $'              .-:::==-.                                      .===.:-.'                
echo $'                :--:---. ...                          .   :-=-:=::-.'                 
echo $'                  .---------:          ..          .:::=--::-=-:..'                   
echo $'                      .:::-.:===-:::---:.-:::::::::---.--::.'                         
echo $'                           :.   ..:::::::::::::::..   .' 

echo -en $'\E[32m'
echo $''
echo $'              ,***                                             ****'             
echo $'                ***                                           ***'               
echo $'                 ****                                       ****'                
echo $'                   ***        ,*******************,        ***'                  
echo $'                    *****************************************'                   
echo $'                   *******************************************'                  
echo $'               ***************************************************'              
echo $'            *********************************************************'           
echo $'          *************************************************************'         
echo $'        *****************************************************************'       
echo $'      **************    *********************************    **************'     
echo $'     **************      *******************************      **************'    
echo $'    ****************     *******************************,    ****************'   
echo $'   ***************************************************************************'  
echo $'  *****************************************************************************' 
echo $' *******************************************************************************'
echo $' *******************************************************************************'

echo -en $'\E[37m'
echo $''
echo $' █████╗ ███╗   ██╗ ██████╗ ███████╗██╗         ██╗███╗   ██╗ █████╗  ██████╗████████╗██╗██╗   ██╗███████╗'
echo $'██╔══██╗████╗  ██║██╔════╝ ██╔════╝██║         ██║████╗  ██║██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔════╝'
echo $'███████║██╔██╗ ██║██║  ███╗█████╗  ██║         ██║██╔██╗ ██║███████║██║        ██║   ██║██║   ██║█████╗  '
echo $'██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║         ██║██║╚██╗██║██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══╝  '
echo $'██║  ██║██║ ╚████║╚██████╔╝███████╗███████╗    ██║██║ ╚████║██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ███████╗'
echo $'╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝    ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝'
                                                                                                         

01_Filesystem_Metadata() {
    # Create directory for each step
    echo "**********************************************"
    echo
    echo "             01 Filesystem Metadata "
    echo
    echo "**********************************************"

    FileMetadata_Dir="$target_dir/01_Filesystem_Metadata_info"
    mkdir -p "$FileMetadata_Dir" || { echo "Failed to create 01_Filesystem_Metadata_info directory"; exit 1; }

    # Execution confirmed, but it's running indefinitely...
    #find / -exec stat '{}' \;>stat.meta
    #find / -exec stat '{}' \; > "$FileMetadata_Dir/filesystem_metadata_info.txt"

    # Receive the duration value from the user
    echo "Enter duration (in minutes): "
    read duration
    timeout "${duration}m" find / -exec stat '{}' \; > "$FileMetadata_Dir/filesystem_metadata_info.txt"
}

02_System_User_Application_setting_Info() {
    echo "******************************************************************"
    echo
    echo "             02 System,User,Application Setting Information "
    echo
    echo "******************************************************************"

    SystemUserApplicationSetting_Dir="$target_dir/02_SystemUserAppli_Setting_info"
    mkdir -p "$SystemUserApplicationSetting_Dir" || { echo "Failed to create 02_SystemUserAppli_Setting_info directory"; exit 1; }

    #adb shell dumpsys 
    # Check the system status of activity
    dumpsys activity > "$SystemUserApplicationSetting_Dir/activity.txt"

    # Check only the system status of recently used activity
    dumpsys activity recents> "$SystemUserApplicationSetting_Dir/activity_recent.txt"

    # Display information for all accounts
    dumpsys account > "$SystemUserApplicationSetting_Dir/account.txt"

    # Check CPU processor usage information
    dumpsys cpuinfo > "$SystemUserApplicationSetting_Dir/cpu_info.txt"

    # Print all installed apps
    pm list packages > "$SystemUserApplicationSetting_Dir/app_list_info.txt"

    #list info on all apps
    dumpsys package packages > "$SystemUserApplicationSetting_Dir/all_apps_info.txt"
}

03_Log_Files() {
    echo "**********************************************"
    echo
    echo "             03 Log Files "
    echo
    echo "**********************************************"

    LogFile_Dir="$target_dir/03_Log_Files"
    mkdir -p "$LogFile_Dir" || { echo "Failed to create 03_Log_Files directory"; exit 1; }

    #adb shell dumpsys jobsechduler
    dumpsys jobscheduler > "$LogFile_Dir/jobscheduler_info.txt"
    #if [!"dumpsys_jobscheduler.txt"];
    #then echo "jobscheduler is not in this device!"

    #event log
    # Receive the duration value from the user
    echo "Enter duration (in minutes): "
    read duration
    timeout "${duration}m" logcat -b events > "$LogFile_Dir/event_log_info.txt"
    #logcat -b events > "$LogFile_Dir/event_log_info.txt"
}

04_Recycle_Bin() {
    echo
    echo "**********************************************"
    echo
    echo "             04 Recycle Bin "
    echo
    echo "**********************************************"
    echo

    # Create a main directory for Recycle Bin
    RecycleBin_Dir="$target_dir/04_Recycle_Bin"
    mkdir -p "$RecycleBin_Dir" || { echo "Failed to create 04_Recycle_Bin directory"; exit 1; }

    # Paths for recycle bin sub-directories
    trash_dump_path="$RecycleBin_Dir/trash_dump"
    dot_trash_dump_path="$RecycleBin_Dir/dot_trash_dump"
    lf_dump_path="$RecycleBin_Dir/lf_dump"

    # Create sub-directories for 'trash' and 'lost+found'
    mkdir -p "$trash_dump_path" || { echo "Failed to create trash_dump directory"; exit 1; }
    mkdir -p "$dot_trash_dump_path" || { echo "Failed to create dot_trash_dump directory"; exit 1; }
    mkdir -p "$lf_dump_path" || { echo "Failed to create lf_dump directory"; exit 1; }

    # Find and copy 'trash' and 'lost+found' to the corresponding sub-directories
    find / -type d -name '*trash*' -exec cp -Rn {} "$trash_dump_path" \; 2>/dev/null
    find / -type d -name '.Trash' -exec cp -Rn {} "$dot_trash_dump_path" \; 2>/dev/null
    find / -type d -name '*lost+found*' -exec cp -Rn {} "$lf_dump_path" \; 2>/dev/null

    echo "Recycle Bin Data Dump Success"
}

05_Browser_Info_File() {
    echo
    echo "**********************************************"
    echo
    echo "             05 Browser Info "
    echo
    echo "**********************************************"
    echo

    echo "This script collects data only for the mobile browsers Chrome, Firefox, Tor, Naver Whale, Opera, and Vivaldi."
    echo
    echo
    Browser_Info_File_Dir="$target_dir/05_Browser_Info"
    mkdir -p "$Browser_Info_File_Dir" || { echo "Failed to create main directory"; exit 1; }

    # List of browsers
    BROWSERS=("com.android.chrome" "org.mozilla.firefox" "com.opera.browser" "com.naver.whale" "org.torproject.torbrowser" "com.vivaldi.browser")

    # Counter for skipped browsers
    skipped_browsers=0

    # Loop through each browser and dump data
    for BROWSER_PACKAGE in "${BROWSERS[@]}"
    do
        # First, check if the main directory of the browser exists.
        if [ ! -d "/data/data/$BROWSER_PACKAGE" ]; then
            echo "Directory for $BROWSER_PACKAGE not found. Skipping..."
            ((skipped_browsers++))
            continue
        fi

        # Firefox and Tor profile path
        if [ "$BROWSER_PACKAGE" == "org.mozilla.firefox" ] || [ "$BROWSER_PACKAGE" == "org.torproject.torbrowser" ]; then 
            if [ ! -d "/data/data/$BROWSER_PACKAGE/files/mozilla" ]; then
                echo "Mozilla directory for $BROWSER_PACKAGE not found. Skipping..."
                continue
            fi
            PROFILE_NAME=$(ls /data/data/$BROWSER_PACKAGE/files/mozilla | grep .default)
            PROFILE_PATH="/data/data/$BROWSER_PACKAGE/files/mozilla/$PROFILE_NAME"
            HISTORY_DB_PATH="/data/data/$BROWSER_PACKAGE/files/places.sqlite"
            COOKIES_DB_PATH="$PROFILE_PATH/cookies.sqlite"
            CACHE_DIR_PATH="/data/data/$BROWSER_PACKAGE/cache"
        fi

       #chrome
        if [ "$BROWSER_PACKAGE" == "com.android.chrome" ]; then 
            HISTORY_DB_PATH="/data/data/com.android.chrome/app_chrome/Default/History"
            COOKIES_DB_PATH="/data/data/com.android.chrome/app_chrome/Default/Cookies"
            CACHE_DIR_PATH="/data/data/com.android.chrome/cache"
        fi

        #opera
        if [ "$BROWSER_PACKAGE" == "com.opera.browser" ]; then 
            HISTORY_DB_PATH="/data/data/com.opera.browser/app_opera/History"
            COOKIES_DB_PATH="/data/data/com.opera.browser/app_opera/cookies"
            CACHE_DIR_PATH="/data/data/com.opera.browser/cache"
        fi

        #whale
        if [ "$BROWSER_PACKAGE" == "com.naver.whale" ]; then 
            HISTORY_DB_PATH="/data/data/com.naver.whale/app_whale/Default/History"
            COOKIES_DB_PATH="/data/data/com.naver.whale/app_whale/Default/Cookies"
            CACHE_DIR_PATH="/data/data/com.naver.whale/cache"
        fi

        #vivaldi
        if [ "$BROWSER_PACKAGE" == "com.vivaldi.browser" ]; then 
            HISTORY_DB_PATH="/data/data/com.vivaldi.browser/app_chrome/Default/History"
            COOKIES_DB_PATH="/data/data/com.vivaldi.browser/app_chrome/Default/Cookies"
            CACHE_DIR_PATH="/data/data/com.vivaldi.browser/cache"
        fi

        DEST_HISTORY_PATH="$Browser_Info_File_Dir/${BROWSER_PACKAGE}_HistoryDB"
        DEST_COOKIES_PATH="$Browser_Info_File_Dir/${BROWSER_PACKAGE}_CookiesDB"
        DEST_CACHE_DIR_PATH="$Browser_Info_File_Dir/${BROWSER_PACKAGE}_CacheDir"

        mkdir -p "$DEST_HISTORY_PATH" || { echo "Failed to create history directory"; exit 1; }
        mkdir -p "$DEST_COOKIES_PATH" || { echo "Failed to create cookies directory"; exit 1; }
        mkdir -p "$DEST_CACHE_DIR_PATH" || { echo "Failed to create cache directory"; exit 1; }



        if [ -f "$HISTORY_DB_PATH" ]; then
            cp  "$HISTORY_DB_PATH" "$DEST_HISTORY_PATH/"
        fi

        if [ -f "$COOKIES_DB_PATH" ]; then
            cp  "$COOKIES_DB_PATH" "$DEST_COOKIES_PATH/"
        fi

        if [ -d "$CACHE_DIR_PATH" ]; then
            cp -r "$CACHE_DIR_PATH" "$DEST_CACHE_DIR_PATH/"
        fi
   
    done

    # Calculate actual number of browsers collected
    actual_browsers_count=$(( ${#BROWSERS[@]} - $skipped_browsers ))
    echo
    echo
    echo "Total browsers collected: $actual_browsers_count out of ${#BROWSERS[@]}"
    echo "Browser Data dump completed."
}

06_Temp_File() {
    echo
    echo "**********************************************"
    echo
    echo "             06 Temp File "
    echo
    echo "**********************************************"
    echo

    # Create a main directory for Temp File
    Temp_File_Dir="$target_dir/06_Temp_File"
    mkdir -p "$Temp_File_Dir" || { echo "Failed to create main directory"; exit 1; }

    # Paths for temp file sub-directories
    cache_dump_path="$Temp_File_Dir/Cache"
    localtmp_dump_path="$Temp_File_Dir/LocalTmp"

    # Create sub-directories for 'cache' and '/data/local/tmp'
    mkdir -p "$cache_dump_path"
    mkdir -p "$localtmp_dump_path"

    # Find 'cache' directories and copy to cache_dump_path
    find / -type d -name '*cache*' 2>/dev/null | while read dir; do
        cp -Rn "$dir" "$cache_dump_path" 2>/dev/null
    done

    # Display '/data/local/tmp' and get user input for exclusion
    echo "Current contents of /data/local/tmp:"
    ls -al /data/local/tmp
    echo "Enter directories to exclude (comma followed by space-separated):"
    read exclude_dirs_input

    # Parsing the `, ` (comma and space) separated list
    OLD_IFS=$IFS
    IFS=',' 
    set -- $exclude_dirs_input
    EXCLUDE_DIRS=()
    for dir in "$@"; do
        EXCLUDE_DIRS+=("$(echo $dir | xargs)")  # xargs trims the leading/trailing spaces
    done
    IFS=$OLD_IFS

    # Copy '/data/local/tmp' to localtmp_dump_path excluding specific directories and files
    for item in /data/local/tmp/*; do
        # Check if the item is one of the predefined items to skip
        case "$item" in
            "/data/local/tmp/Android_main.sh" | "/data/local/tmp/Android_Active.sh" | "/data/local/tmp/Android_Inactive.sh")
                continue
                ;;
        esac

        # Check and skip copying if the item is one of the excluded directories
        skip_copy=false
        for exclude_dir in "${EXCLUDE_DIRS[@]}"; do
            if [[ "$item" == "/data/local/tmp/$exclude_dir" ]]; then
                skip_copy=true
                break
            fi
        done

        if $skip_copy; then
            continue
        fi

        cp -Rn "$item" "$localtmp_dump_path/" 2>/dev/null
    done

    echo "Temp File Data Dump Success"
}

07_External_Storage() {
    echo
    echo
    echo "**********************************************"
    echo
    echo "              07 External Storage "
    echo
    echo "**********************************************"
    echo
    echo


    External_Storage_Dir="$target_dir/07_External_Storage"
    mkdir -p "$External_Storage_Dir" || { echo "Failed to create 07_External_Storage directory"; exit 1; }

    # lsusb > "$External_Storage_Dir/lsusb.txt"
    # echo "System USB device information has been successfully collected.\n"

    blkid -o list > "$External_Storage_Dir/blkid.txt"
    echo "Block device information has been successfully collected.\n"

    echo "Enter duration (in minutes): "
    read duration
    timeout "${duration}m" logcat | grep -i “mount” > "$External_Storage_Dir/logcat_mount.txt"
    echo "Logs were successfully collected to check for traces of external storage devices.\n"

    echo "External storage data has been successfully collected.\n\n"
}

selected_options=""

while true; do
    echo "Choose options:"
    echo "1: Filesystem Metadata"
    echo "2: System, User, Application Setting Information"
    echo "3: Log Files"
    echo "4: Recycle Bin"
    echo "5: Browser Info"
    echo "6: Temp Files"
    echo "7: External Storage"
    echo "a: All options"
    echo "e: Exit"
    echo -n "Enter your choice (e.g. 1, 2, 3, 4 or a or e): "
    read main_choice

    if [ "$main_choice" == "e" ]; then
        echo "Exiting."
        exit 0
    elif [ "$main_choice" == "a" ]; then
        main_choice="1,2,3,4,5,6,7"
    fi

    old_ifs=$IFS
    IFS=','
    set -- $main_choice
    choices=("$@")
    IFS=$old_ifs

    for choice in "${choices[@]}"; do
        choice=$(echo $choice | tr -d ' ')  # remove blank space
        case $choice in
            1) 01_Filesystem_Metadata; selected_options="${selected_options}1," ;;
            2) 02_System_User_Application_setting_Info; selected_options="${selected_options}2," ;;
            3) 03_Log_Files; selected_options="${selected_options}3," ;;
            4) 04_Recycle_Bin; selected_options="${selected_options}4," ;;
            5) 05_Browser_Info_File; selected_options="${selected_options}5," ;;
            6) 06_Temp_File; selected_options="${selected_options}6," ;;
            7) 07_External_Storage; selected_options="${selected_options}7," ;;
            *) echo "Invalid option: $choice" ;;
        esac
    done

    displayed_options=""
    for option in 1 2 3 4 5 6 7; do
        if echo "$selected_options" | grep -q "$option,"; then
            displayed_options="${displayed_options}${option},"
        fi
    done

    echo ""
    echo -n "You have executed the following options: "
    echo $displayed_options
    echo "----------------------"
done