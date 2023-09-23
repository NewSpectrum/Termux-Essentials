#!/data/data/com.termux/files/usr/bin/env bash

#⋆====================================
#⋆ Variable Declarations
#⋆====================================

#- Formatting
rst="\e[0m"
br="\n"
nl="\n"
tab="\t"
brtab="\n\t"
nt="\n\t"
rbt="\e[0m \n\t"

#- Colors
ylw="\e[93m"
bYlw="\e[1;93m"
orng="\e[38;5;211m"
bOrng="\e[1;38;5;211m"
grn="\e[38;5;46m"
bGrn="\e[1;38;5;46m"

#- Types
error="${rbt}${bOrng}"
pass="${rbt}${bGrn}"
msg="${rbt}${ylw}"
bMsg="${rbt}${ylw}"


# Message Outputs
declare AlreadyEnabled="${pass}Setup Already Completed${msg}Permissions for 'External Apps' are already enabled."
declare mkdirFail="${error}ERROR:${msg}Unable to create the required directories.${rbt}"
declare copyFail="${error}ERROR:${msg}Unable to copy the required items.${rbt}"
declare usingDef="String"


# Termux Properties Source-File
declare TmxProperties="$HOME/.termux/termux.properties"


# Destination Variables
declare mainStorage="/storage/emulated/0"
declare defaultDest="${mainStorage}/STORAGE/.dev/_devtools/terminals/termux/config"


# GREP Search Variables
declare grepSearch="'#?\s?allow-external-apps = true'"
	# String includes single-quotes ('')
	# So quoting in-script/command isn't necessary
declare EnabledStr="allow-external-apps = true"
declare DisabledStr="# allow-external-apps = true"



#⋆====================================
#⋆ Main Process
#⋆====================================


grepTest=$(
	grep -x -E ${grepSearch} "${TmxProperties}"
)


function copy_tmxprops_d() {
	destPath="${defaultDest}"
	
	if ![[ -d $defaultDest ]]; then
		mkdir -p "${defaultDest}"
		mkdirCode=$( echo $? )
		
		if [[ $mkdirCode == 0 ]]; then
			declare -g -x TmxConfig="${defaultDest}"
			cp -fvu "${TmxProperties}" "${destPath}"
			copyCode=$( echo $? )
			
			if [[ $copyCode == 0 ]]; then
				echo -e "${SuccessReport}"
			else
				echo -e "${copyFail}"
			fi
			
			
		elif [[ $mkdirCode >= 1 ]]; then
			echo -e "${mkdirFail}"
		fi
	fi
}

function copy_tmxprops_c() {
	destPath="${defaultDest}"
	
	if ![[ -d $defaultDest ]]; then
		mkdir -p "${defaultDest}"
		mkdirCode=$( echo $? )
		
		if [[ $mkdirCode == 0 ]]; then
			declare -g -x TmxConfig="${defaultDest}"
			cp -fvu "${TmxProperties}" "${destPath}"
			copyCode=$( echo $? )
			
			if [[ $copyCode == 0 ]]; then
				echo -e "${SuccessReport}"
			else
				echo -e "${copyFail}"
				exit 1
			fi
			
			
		elif [[ $mkdirCode >= 1 ]]; then
			echo -e "${mkdirFail}"
			exit 1
		fi
	fi
}

function copy_tmxprops_h() {
	echo -e "${bMsg}The 'default' Destination:${rst}"
	
	
	echo -e "${bMsg}The 'default' Destination:${rst}"
	cat <<- EOT
	/storage/emulated/0/STORAGE/.dev/_devtools/terminals/termux/config
	
	Why is this recommended?
		If you don't already have much of (or any) organized file structure regarding your Code & Development files, this will get you started with a dedicated '.dev' parent directory.
		
	Why '.dev' and not 'dev'?
		Believe it or not, it's to save your 'Photo Gallery' app from the ensuing developer chaos.
		
		Most Android phones have a very simple logic to their 'Photo Gallery' apps. So it doesn't matter *where* media files are saved, as long as they're in a subdirectory of ".../0" (aka, your device's Primary Storage volume), they will almost always appear in your gallery.
		
		Also, if the chaos of icons and miscellaneous development assets being imported to your gallery wasn't bad enough, for some reason Typescript files '.ts' are interpreted as videos on many (if not all) Android devices. And obviously, Typescript "videos" will not actually play in your gallery.
		
		So in the end, it's just easier to place all Coding and Development files in a 'hidden' (.dir) folder where the rest of your apps won't try to pull information from.
	
	Why 'STORAGE'?
		I find it helpful to have a 'centralized' storage Directory separate from the other automatically generated ones. Use it however you see fit (or don't).
	EOT
	
	echo -e "${bMsg}Custom Paths:${rst}"
	cat <<- EOT
		About 'Custom Paths'
			Be sure to include the Full Literal path when Declaring a custom path to your Android's storage.
			
			The default path for your 'Internal Storage' is usually:
				
				/storage/emulated/0
				
			If you're using an external MicroSD/MicroSDXC card, the path for that is usually just:
			
				/sdcard
		
		Declaring a 'Custom Path' for the script
			If you execute the 'external-apps.sh' script without any arguments (recommended if you aren't sure how to proceed), you will receive a prompt to use the Default settings (recommended), enter a 'Custom Path', or 'Get Help'.
			
			Enter 'c' or 'custom'
				When you enter [c|custom] (case insensitive) you will receive a prompt to enter a custom path. Below are acceptable examples which includes the "Path: " prompt you will see in-terminal.
				
				Custom Path Example 01:
				Path: /storage/emulated/0/MyStuff/.dev
				
				Custom Path Example 02:
				Path: /sdcard/MyStuff/.dev
	EOT
	
	echo -e "${bMsg}How would you like to proceed?"
	cat <<- EOT
		Quit:				q | Quit
		Restart Script:		{ any other input }
	EOT
	
	read -p "Option: " option
	
	case option in
		q|Q|quit|Quit)
			exit 0
			;;
			
		\?)
			copy_tmxprops
			;;
	esac
}




function copy_tmxprops() {
	1=path
	
	if [[ $path == $null ]]; then
		echo -e "${bMsg}Choose a Destination"
		cat <<- EOT
		
			Enter one of the following options.
			
			To use the default path:	d | default
				(recommended)
			To enter a custom path:		c | custom
				Example: /dev/termux
			To display detailed help:	h | help
			
		EOT
		
		read -p "How would you like to proceed? " option
		case option in
			d|D|default|Default)
				copy_tmxprops_d
				;;
			
			c|C|custom|Custom)
				copy_tmxprops_c
				;;
				
			h|H|help|Help)
				copy_tmxprops_h
				;;
			
			\?)
				echo -e "${error}ERROR:${msg}Invalid Option."
				cat <<- EOT
				
					Enter one of the following options.
					
					To use the default path:	d | default
						(recommended)
					To enter a custom path:		c | custom
						Example: /dev/termux
					To display detailed help:	h | help
				EOT
		esac
	fi
}

if [[ $grepTest == "$EnabledStr" ]]; then
	status=1
	echo -e "${bMsg}${AlreadyEnabled}${rbt}"
	exit 1
elif [[ "$grepTest" == "$DisabledStr" ]]; then
	status=0
	copy_tmxprops
fi




# Default Path:
# 	[main storage]/STORAGE/.dev/_devtools/terminals/termux/config
