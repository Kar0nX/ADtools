# 🛠️ ADTools Installer

A powerful Bash script that automates the download and setup of **essential tools for Active Directory penetration testing**. Built for red teamers, pentesters, and security enthusiasts.  

Created as part of my learning journey while preparing for PNPT and OSCP certifications.

<img width="1058" height="598" alt="image" src="https://github.com/user-attachments/assets/9ea1e6c1-d8c0-46ad-8f71-445fe1a36f75" />

---

## 🆕 What’s New (July 2025)

- ✅ Fully interactive **main menu**: Choose to update dependencies, install all tools, or pick them individually.
- ✅ **Automatic installation of dependencies**: Python venv, Git, Ruby, Cargo, Go, Rust, etc.
- ✅ **Smarter installations**: The script sets up Python virtual environments, installs requirements, compiles tools with `make`, installs `evil-winrm` via Ruby, and compiles Rust projects.
- ✅ **Safe re-runs**: Already cloned tools are skipped, making the script idempotent and safe to run multiple times.
- ✅ **Improved UX**: Clean, colorized output and structured logging for better visibility.

⚠️ Important: Some tools must still be compiled or configured manually. Be sure to follow each tool’s README and setup instructions after installation.

---

## 📌 Features

- ✅ Root privilege check
- ✅ Installs tools into `/opt/adtools`
- ✅ Option to install all tools or select individually via menu
- ✅ Automatic installation of dependencies (Python, Git, Ruby, Rust, etc.)
- ✅ Smart setup for supported tools (e.g., Python venv, `make`, `cargo`, etc.)
- ✅ Clean and colorized terminal output

---

## 📦 Tools Included

The script clones the following repositories:

| #  | Tool Name              | Description                            |
|----|------------------------|----------------------------------------|
| 1  | BloodHound (GUI)       | AD attack path visualization           |
| 2  | SharpHound             | Data collector for BloodHound          |
| 3  | BloodHound.py          | Python-based alternative to SharpHound |
| 4  | Impacket               | Network protocols and attack tools     |
| 5  | bloodyAD               | ACL abuse and AD object manipulation   |
| 6  | Mimikatz               | Credential dumping and manipulation    |
| 7  | Rubeus                 | Kerberos abuse toolkit                 |
| 8  | Kerbrute               | Username enumeration, bruteforce       |
| 9  | Inveigh                | LLMNR/NBNS/MDNS spoofing via PowerShell|
| 10 | Responder              | LLMNR/NBNS poisoning and credential theft |
| 11 | Ligolo-ng              | Reverse tunneling for internal access  |
| 12 | noPac                  | Exploit for CVE-2021-42287 & 42278     |
| 13 | CrackMapExec           | Swiss army knife for AD enumeration    |
| 14 | evil-winrm             | WinRM shell for red teams              |
| 15 | smbmap                 | SMB enumeration tool                   |
| 16 | enum4linux             | Basic SMB/NetBIOS enumeration          |
| 17 | enum4linux-ng          | Updated version with better support    |
| 18 | windapsearch           | LDAP search for Windows environments   |
| 19 | LAPSToolkit            | LAPS-related AD reconnaissance         |
| 20 | DomainPasswordSpray    | Password spraying against AD accounts  |
| 21 | SharpView              | PowerView rewritten in C#              |
| 22 | PEASS-ng               | Local privilege escalation checks      |
| 23 | Seatbelt               | System information collection          |
| 24 | PingCastle             | AD security audit and health check     |
| 25 | adidnsdump             | Dump AD-integrated DNS records         |
| 26 | gpp-decrypt            | Decrypt GPP passwords in SYSVOL        |
| 27 | CVE-2021-1675 PoC      | PrintNightmare exploit                 |
| 28 | PetitPotam             | NTLM relay attack vector               |
| 29 | pyWhisker              | HTTP-based covert channel              |
| 30 | ADRecon                | AD reporting tool                      |
| 31 | PowerSharpPack         | Collection of offensive PowerShell tools |
| 32 | ADACLScanner           | Enumerates AD ACLs for attack paths    |
| 33 | LDAPRelayScan          | Identifies vulnerable LDAP relays      |
| 34 | RustHound CE           | BloodHound collector in Rust           |
| 35 | Username Anarchy       | Username enumeration wordlists         |
| 36 | adPEAS                 | Active Directory enumeration tool      |
| 37 | nc.exe                 | Netcat – network utility for Windows   |
| 38 | WES-NG                 | Windows Exploit Suggester – Next Gen    |
---

## 🚀 Usage

### 🔧 Prerequisites

- Must be run as **root** (`sudo` required)

---

### 🧪 Run the Script

```
chmod +x adtools.sh
sudo ./adtools.sh
```

You will be prompted to:

- Install only dependencies (helpful for first-time setup)  
- Install all tools  
- Choose tools manually from a numbered list  

All tools will be cloned into:
```
/opt/adtools/
```

📁 Example Directory Structure:
```
/opt/adtools/
├── BloodHound
├── SharpHound
├── Impacket
├── ...
```


📍 Notes:  
The script is idempotent—you can run it again to update or add new tools.  
Some tools still require additional setup (e.g., Visual Studio for C# projects). Always check the tool's individual documentation after installation.

---

🇵🇱 Author  
Made in Poland 🇵🇱 by @Kar0n

📜 License  
This script uses public tools under their respective licenses. The script itself is provided under the MIT License.

