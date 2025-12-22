# Automatic Randomised MAC for Linux

Project created to enhance privacy of desktop linux by randomising the MAC address everytime the system is booted.

### Requirements
1. [macchanger](http://www.gnu.org/software/macchanger)

   ```sh
   sudo apt install macchanger
   ```
2. `systemd` (included in most of the popular distros)

   This automation tool was written with systemd as target. If you do not have systemd, you can use crontab.

### Installation
1. Clone this repo and cd into it

   ```sh
   git clone https://github.com/ShobanChiddarth/randomised_mac_linux.git
   cd randomised_mac_linux
   ```

2. Make the script as executable

   ```sh
   chmod +x ./randomise_MACs.sh
   ```

3. Copy the script into `/usr/bin`

   ```sh
   sudo cp randomise_MACs.sh /usr/bin/
   ```

4. Copy the systemd service file into `/etc/systemd/system`

   ```sh
   sudo cp randomise_MACs.service /etc/systemd/system/
   ```

5. Reload systemd

   ```sh
   sudo systemctl daemon-reload
   ```

6. Enable the service to run on boot

   ```sh
   sudo systemctl enable randomise_MACs
   ```

7. Note down the MAC addresses of alive network interfaces

   ```sh
   sudo ifconfig
   ```

8. Start the systemd service right now to check if the MAC addresses are actually being changed
   
   ```sh
   sudo systemctl start randomise_MAC
   ```

9. Run `ifconfig` again and compare the output with the previous run

   ```sh
   sudo ifconfig
   ```

10. If it is different, it means the script is working and your MAC addresses will change on each boot.
