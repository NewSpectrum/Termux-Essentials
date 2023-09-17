#!/data/data/com.termux/files/usr/bin/bash/env bash

function testcolor() {
	if [[ "${1}" =~ ^[0-9]{1,3}$ ]]; then
		echo -ne "\n\e[38;5;226mNumber:\e[38;5;015m"
		echo -e "\t\t${1}\e[0m"
		echo -ne "\e[38;5;226mSequence:\e[0m"
		echo -ne "\e[38;5;250m\t"
		echo -n '\e[38;5;'
		echo -e "\e[38;5;015m${1}\e[0m\e[38;5;250mm\e[0m"
		echo -ne "\e[38;5;226mOutput:\e[0m"
		echo -e "\t\t\e[38;5;${1}mColor\e[0m"
	elif [[ "$1" == $null ]]; then
		echo -e "\n"
		cat <<- EOT
		Simple function for testing a color in the 256-Color ANSI Escape Color Sequences (001-256).
		
		Usage:
			testcolor NUM
			
			The value for NUM is only valid between 001 and 256 (leading 0s are optional).
			
			If no argument (number) is added, this help message will be displayed.
		EOT
	else
		echo -e "\n\e[38;5;208mERROR: Invalid Input\e[0m"
		echo -e "Input a number between \e[38;5;46m001\e[0m and \e[38;5;46m256\e[0m"
	fi
}