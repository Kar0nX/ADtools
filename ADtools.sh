#!/bin/bash
set -e

CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

if [[ $EUID -ne 0 ]]; then
   echo -e "${CYAN}[!] Please run this script as root (sudo).${NC}" 
   exit 1
fi

echo -e "${CYAN}[*]              _____  ________   __                .__          ${NC}" 
echo -e "${CYAN}[*]             /  _  \\ \\______ \\_/  |_  ____   ____ |  |   ______${NC}"
echo -e "${CYAN}[*]            /  /_\\  \\ |    |  \\   __\\/  _ \\ /  _ \\|  |  /  ___/${NC}"
echo -e "${CYAN}[*]           /    |    \\|    \`   \\  | (  <_> |  <_> )  |__\\___ \\ ${NC}"
echo -e "${CYAN}[*]           \\____|__  /_______  /__|  \\____/ \\____/|____/____  >${NC}"
echo -e "${CYAN}[*]                   \\/        \\/                             \\/ ${NC}"
echo -e "${CYAN}[*]         ${WHITE}Essential toolkit for Active Directory penetration testing${CYAN}         ${NC}"
echo -e "${CYAN}[*]                          ${WHITE}Made in Poland 🇵🇱 @Kar0n${NC}"

printf "${WHITE}%-80s${NC}\n" " "
echo -e "${CYAN}[+] Creating working directory: /opt/adtools${NC}"
mkdir -p /opt/adtools
cd /opt/adtools

# === TOOL LIST ===
TOOLS=(
  "https://github.com/SpecterOps/BloodHound.git"
  "https://github.com/SpecterOps/SharpHound.git"
  "https://github.com/dirkjanm/BloodHound.py.git"
  "https://github.com/SecureAuthCorp/impacket.git"
  "https://github.com/CravateRouge/bloodyAD.git"
  "https://github.com/gentilkiwi/mimikatz.git"
  "https://github.com/GhostPack/Rubeus.git"
  "https://github.com/ropnop/kerbrute.git"
  "https://github.com/Kevin-Robertson/Inveigh.git"
  "https://github.com/lgandx/Responder.git"
  "https://github.com/nicocha30/ligolo-ng.git"
  "https://github.com/Ridter/noPac.git"
  "https://github.com/byt3bl33d3r/CrackMapExec.git"
  "https://github.com/Hackplayers/evil-winrm.git"
  "https://github.com/ShawnDEvans/smbmap.git"
  "https://github.com/CiscoCXSecurity/enum4linux.git"
  "https://github.com/cddmp/enum4linux-ng.git"
  "https://github.com/ropnop/windapsearch.git"
  "https://github.com/leoloobeek/LAPSToolkit.git"
  "https://github.com/dafthack/DomainPasswordSpray.git"
  "https://github.com/dmchell/SharpView.git"
  "https://github.com/carlospolop/PEASS-ng.git"
  "https://github.com/GhostPack/Seatbelt.git"
  "https://github.com/vletoux/pingcastle.git"
  "https://github.com/dirkjanm/adidnsdump.git"
  "https://github.com/t0thkr1s/gpp-decrypt.git"
  "https://github.com/cube0x0/CVE-2021-1675.git"
  "https://github.com/topotam/PetitPotam.git"
  "https://github.com/ShutdownRepo/pyWhisker.git"
  "https://github.com/sense-of-security/ADRecon.git"
  "https://github.com/S3cur3Th1sSh1t/PowerSharpPack.git"
  "https://github.com/canix1/ADACLScanner.git"
  "https://github.com/zyn3rgy/LDAPRelayScan.git"
  "https://github.com/g0h4n/RustHound-CE.git"
  "https://github.com/urbanadventurer/username-anarchy.git"
)

TOOL_NAMES=(
  "BloodHound (GUI)"
  "SharpHound"
  "BloodHound.py"
  "Impacket toolkit"
  "bloodyAD"
  "Mimikatz"
  "Rubeus"
  "Kerbrute"
  "Inveigh (PowerShell)"
  "Responder"
  "Ligolo-ng"
  "noPac"
  "CrackMapExec"
  "evil-winrm"
  "smbmap"
  "enum4linux"
  "enum4linux-ng"
  "windapsearch"
  "LAPSToolkit"
  "DomainPasswordSpray"
  "SharpView"
  "PEASS-ng (winPEAS)"
  "Seatbelt"
  "PingCastle"
  "adidnsdump"
  "gpp-decrypt"
  "CVE-2021-1675 PoC"
  "PetitPotam"
  "pyWhisker"
  "ADRecon"
  "PowerSharpPack"
  "ADACLScanner"
  "LDAPRelayScan"
  "RustHound CE"
  "Username Anarchy"
)

# === INSTALL FUNCTION ===
install_tool() {
    index=$1
    url="${TOOLS[$index]}"
    echo -e "${CYAN}[+] Cloning: ${TOOL_NAMES[$index]}${NC}"
    git clone "$url"
}

# === ASK USER ===
printf "${WHITE}%-80s${NC}\n" " "
read -p "$(echo -e "${CYAN}[?] Do you want to install ALL tools? (y/n): ${NC}")" install_all
printf "${WHITE}%-80s${NC}\n" " "
if [[ "$install_all" =~ ^[Yy]$ ]]; then
    for i in "${!TOOLS[@]}"; do
        install_tool $i
    done
else
    echo -e "${CYAN}[?] Select tools to install by number (e.g. 1 5 9):${NC}"
    printf "${WHITE}%-80s${NC}\n" " "
    for i in "${!TOOLS[@]}"; do
        printf "${CYAN}%2d) %s${NC}\n" $((i+1)) "${TOOL_NAMES[$i]}"
    done
    read -p "Your choice: " -a choices

    for choice in "${choices[@]}"; do
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#TOOLS[@]} )); then
            install_tool $((choice-1))
        else
            echo -e "${CYAN}[!] Invalid option: $choice${NC}"
        fi
    done
fi

echo -e "${CYAN}[✓] Installation complete. Tools saved to: /opt/adtools/${NC}"
