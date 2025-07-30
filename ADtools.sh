#!/bin/bash
set -e

# === Colors ===
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# === Root Check ===
if [[ $EUID -ne 0 ]]; then
   echo -e "${CYAN}[!] Please run this script as root (sudo).${NC}"
   exit 1
fi

# === Banner ===
echo -e "${CYAN}[*]              _____  ________   __                .__          ${NC}"
echo -e "${CYAN}[*]             /  _  \\ \\______ \\_/  |_  ____   ____ |  |   ______${NC}"
echo -e "${CYAN}[*]            /  /_\\  \\ |    |  \\   __\\/  _ \\ /  _ \\|  |  /  ___/${NC}"
echo -e "${CYAN}[*]           /    |    \\|    \`   \\  | (  <_> |  <_> )  |__\\___ \\ ${NC}"
echo -e "${CYAN}[*]           \\____|__  /_______  /__|  \\____/ \\____/|____/____  >${NC}"
echo -e "${CYAN}[*]                   \\/        \\/                             \\/ ${NC}"
echo -e "${CYAN}[*]         ${WHITE}Essential toolkit for Active Directory penetration testing${CYAN}         ${NC}"
echo -e "${CYAN}[*]                          ${WHITE}Made in Poland 🇵🇱 @Kar0n${NC}"
printf "${WHITE}%-80s${NC}\n" " "

# === Tool Repositories & Names ===
TOOLS=(
  "https://github.com/SpecterOps/BloodHound.git"
  "https://github.com/SpecterOps/SharpHound.git"
  "https://github.com/dirkjanm/BloodHound.py.git"
  "https://github.com/SecureAuthCorp/impacket.git"
  "https://github.com/CravateRouge/bloodyAD.git"
  "https://github.com/ParrotSec/mimikatz.git"
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
  "https://github.com/61106960/adPEAS.git"
  "https://github.com/int0x33/nc.exe.git"
  "https://github.com/bitsadmin/wesng.git"
  "https://github.com/dievus/printspoofer.git"
  "https://github.com/sqlmapproject/sqlmap.git"
)

TOOL_FOLDERS=(
  "BloodHound"
  "SharpHound"
  "BloodHound.py"
  "Impacket toolkit"
  "bloodyAD"
  "Mimikatz"
  "Rubeus"
  "Kerbrute"
  "Inveigh"
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
  "PEASS-ng"
  "Seatbelt"
  "PingCastle"
  "adidnsdump"
  "gpp-decrypt"
  "CVE-2021-1675"
  "PetitPotam"
  "pyWhisker"
  "ADRecon"
  "PowerSharpPack"
  "ADACLScanner"
  "LDAPRelayScan"
  "RustHound CE"
  "Username Anarchy"
  "adPEAS"
  "nc.exe"
  "WES-NG"
  "PrintSpoofer"
  "SQLMap"
)

# === Create Tools Directory ===
TOOLS_DIR="/opt/ADtools"
echo -e "${CYAN}[+] Creating working directory: $TOOLS_DIR${NC}"
mkdir -p "$TOOLS_DIR"
cd "$TOOLS_DIR"

# === Functions ===

update_and_install_dependencies() {
  echo -e "${CYAN}[+] Updating package list...${NC}"
  apt update -y

  packages=(
    python3-venv
    git
    make
    gcc
    build-essential
    curl
    ruby
    gem
    golang-go
  )

  echo -e "${CYAN}[+] Installing required packages...${NC}"
  for pkg in "${packages[@]}"; do
    if ! dpkg -s "$pkg" &> /dev/null; then
      echo -e "${CYAN}[-] Installing $pkg...${NC}"
      apt install -y "$pkg"
    else
      echo -e "${CYAN}[-] $pkg is already installed.${NC}"
    fi
  done

  echo -e "${CYAN}[+] Checking for cargo...${NC}"
  if ! command -v cargo &> /dev/null; then
    echo -e "${CYAN}[-] Attempting to install cargo via apt...${NC}"
    if ! apt install -y cargo; then
      echo -e "${CYAN}[!] Apt failed. Installing Rust via rustup...${NC}"
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
      source "$HOME/.cargo/env"
    fi
  else
    echo -e "${CYAN}[-] Cargo is already installed.${NC}"
  fi

  echo -e "${CYAN}[✓] System updated and dependencies installed.${NC}"
}

install_tool_full() {
  local index=$1
  local url="${TOOLS[$index]}"
  local name="${TOOL_FOLDERS[$index]}"
  local folder="${TOOL_FOLDERS[$index]}"

  echo -e "${CYAN}[+] Installing: $name${NC}"
  if [[ -d "$folder" ]]; then
    echo -e "${CYAN}[-] $folder already exists. Pulling latest...${NC}"
    cd "$folder" && git pull --rebase && cd ..
  else
    if ! git clone --depth 1 "$url" "$folder"; then
      echo -e "${CYAN}[!] Failed to clone $url ($name). Skipping.${NC}"
      return
    fi
  fi
  cd "$folder" || return

  case "$name" in
    "Impacket toolkit"|"BloodHound.py"|"enum4linux-ng"|"Responder"|"smbmap")
      echo -e "${CYAN}[-] Setting up Python virtual environment...${NC}"
      python3 -m venv venv
      source venv/bin/activate
      if [[ -f requirements.txt ]]; then
        pip install --upgrade pip
        pip install -r requirements.txt
      else
        pip install .
      fi
      deactivate
      ;;
    "evil-winrm")
      gem install evil-winrm
      ;;
    "Ligolo-ng"|"ligolo-ng")
      make
      ;;
    "windapsearch")
      python3 -m venv venv
      source venv/bin/activate
      pip install ldap3
      deactivate
      ;;
    "PEASS-ng")
      cd winPEAS && make || echo "winPEAS not compiled"
      ;;
    "RustHound CE")
      cargo build --release
      ;;
    "Username Anarchy")
      chmod +x username-anarchy
      ;;
    "WES-NG")
      python3 -m venv venv
      source venv/bin/activate
      pip install --upgrade pip
      pip install wesng
      python3 wes.py --update || echo -e "${CYAN}[!] Failed to update WES-NG database${NC}"
      deactivate
      ;;
    *)
      echo -e "${CYAN}[-] No special install steps required for $name${NC}"
      ;;
  esac

  cd ..
}

# === Main Menu Loop ===
while true; do
  printf "${WHITE}%-80s${NC}\n" " "
  echo -e "${WHITE}What do you want to do?${NC}"
  echo -e "${CYAN}1) Update system & install requirements (Python, Cargo, Git, etc.)${NC}"
  echo -e "${CYAN}2) Install ALL tools${NC}"
  echo -e "${CYAN}3) Select tools manually${NC}"
  echo -e "${CYAN}4) Exit${NC}"
  printf "${WHITE}%-80s${NC}\n" " "
  read -p "$(echo -e "${CYAN}Select an option [1-4]: ${NC}")" menu_choice
  printf "${WHITE}%-80s${NC}\n" " "

  case "$menu_choice" in
    1)
      update_and_install_dependencies
      ;;
    2)
      for i in "${!TOOLS[@]}"; do
        install_tool_full "$i"
      done
      echo -e "${CYAN}[✓] All tools installed.${NC}"
      ;;
    3)
      echo -e "${CYAN}[?] Select tools to install by number (e.g. 1 5 9):${NC}"
      for i in "${!TOOLS[@]}"; do
        printf "${CYAN}%2d) %s${NC}\n" $((i+1)) "${TOOL_FOLDERS[$i]}"
      done
      read -p "Your choice: " -a choices

      for choice in "${choices[@]}"; do
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#TOOLS[@]} )); then
          install_tool_full $((choice-1))
        else
          echo -e "${CYAN}[!] Invalid option: $choice${NC}"
        fi
      done
      echo -e "${CYAN}[✓] Selected tools installed.${NC}"
      ;;
    4)
      echo -e "${CYAN}[!] Exiting...${NC}"
      exit 0
      ;;
    *)
      echo -e "${CYAN}[!] Invalid option. Please try again.${NC}"
      ;;
  esac
done
