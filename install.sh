#!/usr/bin/env nix-shell
#! nix-shell -i bash
#! nix-shell -p lolcat fastfetch

################
## Set colors ##
################

BOLD_RED='\e[1;31m'
BOLD_GREEN='\e[1;32m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
NC='\e[0m'  # No Color

######################
## Helper functions ##
######################

checkFmt() {
  if [[ "$1" == "y" || "$1" == "Y" ]] || [[ "$1" == "n" || "$1" == "N" ]]; then
    return 1
  else
    printf "\n${YELLOW}Tip${NC}:\n"
    printf "  Answer format is: ${GREEN}y${NC}/${GREEN}Y${NC} for ${BOLD_GREEN}YES${NC}\n"
    printf "                    ${RED}n${NC}/${RED}N${NC} for ${BOLD_RED}NO${NC}.\n\n"

    return 0
  fi
}

rollback() {
  printf "\nAll the changes have been reset. Original system state is (is what???)\n" | lolcat -as 4 -S 75
  exit 0
}

###############################
## Start installation script ##
###############################

clear
printLogoNixOS() {
  fastfetch --logo-position top --logo nixos --structure " " | lolcat -as 200 -S 32
  printf "Hello!\n" | lolcat -as 7 -S 75
}; printLogoNixOS

###########################
## Get the prerequisites ##
###########################

correct=0
while [ "$correct" -eq 0 ];
do
  # Get hostname
  printf "Type your hostname" | lolcat -as 20 -t && printf ": "
  read -r hostname

  # Get username
  printf "Type your username" | lolcat -as 20 -t && printf ": "
  read -r username

  # Get email
  printf "\n${GREEN}Note${NC}:\n"
  printf "  This step is required for git configuration.\n"
  printf "  If you don't use git, you can skip this step by pressing ${BOLD_GREEN}<Enter>${NC}.\n\n"

  printf "Enter your email" | lolcat -as 20 -t && printf ": "
  read -r email

  # Get git username (if needed)
  fmtcheck=0
  while [ "$fmtcheck" -eq 0 ];
  do
    printf "${BLUE}Do you want to specify your git username?${NC} "
    printf "[${BOLD_GREEN}y${NC}/${BOLD_RED}N${NC}]: "
    read -r specifyGitUsername
    checkFmt "$specifyGitUsername"
    fmtcheck=$?
  done
  if [[ "$specifyGitUsername" == "y" || "$specifyGitUsername" == "Y" ]]; then
    printf "Enter your git username" | lolcat -as 20 -t && printf ": "
    read -r gitUsername
  else
    gitUsername=""
  fi

  # Get the name
  printf "\n${YELLOW}Tip${NC}:\n"
  printf "  Press ${BOLD_GREEN}<Enter>${NC} to skip.\n"
  printf "Enter your name" | lolcat -as 20 -t && printf " ${BLUE}(optional)${NC}: "
  read -r name

  # Get stable version
  printf "\n${YELLOW}Tip${NC}:\n"
  printf "  Appropriate formatting looks like ${BOLD_GREEN}25.05${NC}\n"

  echo -e "${RED}Warning${NC}:"
  printf  "  Any other format will entail configuration setup to fail.\n\n"

  printf "Type your state version" | lolcat -as 20 -t && printf ": "
  read -r stateVersion

  # Get whether user is on a laptop or not
  fmtcheck=0
  while [ "$fmtcheck" -eq 0 ];
  do
    printf "Are you on a laptop?" | lolcat -as 20 -t
    printf " ${NC}[${BOLD_GREEN}y${NC}/${BOLD_RED}N${NC}]: "
    read -r laptop
    checkFmt "$laptop"
    fmtcheck=$?
  done

  # Get whether the user wants to install a virtual machine
  printf "\n${GREEN}Note${NC}:\n"
  printf "  This will compile the source code of Oracle VirtualBox, which can take some time.\n\n"

  fmtcheck=0
  while [ "$fmtcheck" -eq 0 ];
  do
    printf "Install VM (Oracle VirtualBox)?" | lolcat -as 20 -t
    printf " ${NC}[${BOLD_GREEN}y${NC}/${BOLD_RED}N${NC}]: "
    read -r vm
    checkFmt "$vm"
    fmtcheck=$?
  done

  # Print the prerequisites
  echo
  echo -e "${MAGENTA}Prerequisites${NC}: {"
  echo -e "  ${BLUE}Hostname${NC}: $hostname"
  echo -e "  ${BLUE}Username${NC}: $username"
  echo -e "  ${BLUE}Email${NC}: $email"
  if [[ "$specifyGitUsername" == "y" || "$specifyGitUsername" == "Y" ]]; then
    echo -e "  ${BLUE}Git Username${NC}: $gitUsername"
  fi
  echo -e "  ${BLUE}State version${NC}: $stateVersion"
  echo -e "  ${BLUE}Laptop${NC}: $laptop"
  echo -e "  ${BLUE}Install VM${NC}: $vm"
  echo "}"
  echo

  # Ask user if the provided information is correct
  fmtcheck=0
  while [ "$fmtcheck" -eq 0 ];
  do
    printf "Is this correct?" | lolcat -as 20 -t
    printf " ${NC}[${BOLD_GREEN}y${NC}/${BOLD_RED}N${NC}]: "
    read -r response
    checkFmt "$response"
    fmtcheck=$?
  done

  # Start again if user answered "n|N" (NO)
  if [[ "$response" == "y" || "$response" == "Y" ]]; then
    correct=1
  elif [[ "$response" == "n" || "$response" == "N" ]]; then
    correct=0
  fi
done

echo

#######################################################################
## Continue installation process: Modify necessary files accordingly ##
#######################################################################

fmtcheck=0
while [ "$fmtcheck" -eq 0 ];
do
  echo -e "${RED}Warning${NC}:"
  printf  "  Next steps require ${YELLOW}sudo${NC} access.\n\n"
  printf  "${BLUE}Are you enlightened of that?${NC} [${BOLD_GREEN}y${NC}/${BOLD_RED}N${NC}]: "
  read -r awareness
  checkFmt "$awareness"
  fmtcheck=$?
done

echo

if [ "$awareness" == "n" ] || [ "$awareness" == "N" ]; then
  fmtcheck=0
  while [ "$fmtcheck" -eq 0 ];
  do
    echo -e "${RED}Warning${NC}:"
    printf  "  Do you want to continue installation process? [${BOLD_GREEN}y${NC}/${BOLD_RED}N${NC}]: "
    read -r awareness
    checkFmt "$awareness"
    fmtcheck=$?
  done

  if [ "$awareness" == "n" ] || [ "$awareness" == "N" ]; then
    rollback
  fi
fi

echo

# CD to the directory `install.sh` script and the entire config is
absolute_config_path="$(dirname "$(realpath "$0")")"
cd "$absolute_config_path" || exit

# Assign the username
sed -i "s/user = \"rat\"/user = \"${username}\"/g" ./flake.nix

# Assign the name (if present)
if [[ -n "$name" ]]; then
  sed -i "s/lynette/${name}/g" ./flake.nix
else
  sed -i "s/lynette/${username}/g" ./flake.nix
fi

# Change stable version
sed -i "s/25.05/${stateVersion}/g" ./flake.nix

# Remove `power-management.nix` if required
if [[ "$laptop" == "n" || "$laptop" == "N" ]]; then
  sed -i "s|./power|# ./power|" ./nixos/modules/default.nix
fi

# Remove virtual machine if required
if [[ "$vm" == "n" || "$laptop" == "N" ]]; then
  sed -i "13,20 s/  /  # /"
fi

# Adjust git configuration
sed -i "s/necodrre/${gitUsername}/" ./home-manager/modules/git.nix
sed -i "s/necodrre@proton.me/${email}/" ./home-manager/modules/git.nix

# Assign the NH_FLAKE global variable for the installation
sed -i "s|\${config.home.homeDirectory}/.config/nix-config|${absolute_config_path}/g" "./home-manager/home.nix"
NH_FLAKE="$absolute_config_path"

# Create a new host
mkdir -p ./hosts/"$hostname"
cp -r ./hosts/T460 ./hosts/"$hostname"
sed "9,32d" ./hosts/"$hostname"
sudo mv /etc/nixos/hardware-configuration.nix ./hosts/"$hostname"/hardware-configuration.nix
sudo rm -rf /etc/nixos/*
sudo ln -s ./hosts/"$hostname"/configuration.nix /etc/nixos/configuration.nix
sed -i "/stateVersion = \"25.05\"; }/s/.*/&\\n      { hostname = \"${hostname}\"; stateVersion = \"${stateVersion}\" }/" ./flake.nix

# Link home-manager
mkdir -p /home/"$username"/.config/nixpkgs/
rm -rf /home/"$username"/.config/nixpkgs/*
sudo ln -s ./home-manager/home.nix /home/"$username"/.config/nixpkgs/home.nix

###################################
## Start a system rebuild (full) ##
###################################

sudo nixos-rebuild switch --flake .#"$hostname"
home-manager switch --flake .#"$username"
sudo /run/current-system/bin/switch-to-configuration boot

###############
## Afterword ##
###############

echo -e "${YELLOW}Tip${NC}:"
echo -e "  You can run full upgrade with \`${GREEN}nix-full-upgrade${NC}\` alias"
echo
echo -e "${YELLOW}Tip${NC}:"
echo -e "  To check system stats, run \`${GREEN}fastfetch${NC}\` or simply \`${GREEN}fetch${NC}\` (an alias)"
echo
echo -e "${YELLOW}Tip${NC}:"
echo -e "  Take a look at \`${GREEN}./nixos/modules/nh.nix${NC}\` and \`${GREEN}./home-manager/modules/zsh.nix${NC}\` files!"
echo -e "  You'll might find the first one very handy, and the second - fascinating!"
echo

fmtcheck=0
while [ "$fmtcheck" -eq 0 ];
do
  printf "${BLUE}Reboot now?${NC} [${BOLD_GREEN}y${NC}/${BOLD_RED}N${NC}]: "
  read -r toReboot
  checkFmt "$toReboot"
  fmtcheck=$?
done

if [[ "$toReboot" == "y" || "$toReboot" == "Y" ]]; then
  clear
  echo "Good luck!" | lolcat -as 4 -S 75
  sudo reboot
else
  cd /home/"${username}" || exit
  source .zshrc
  clear
  echo "Good luck!" | lolcat -as 4 -S 75
fi
