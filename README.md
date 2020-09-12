# chimneypot_oracle

* Create a new image of Raspbian and burn to SD card
* Turn on RPI, with a keyboard connected

### Run Raspi-conifg
`sudo raspi-config`
Add wifi details for local network

* Select “Interfaing / Serial”. 
* Select “No” to disable the login shell over serial. 
* Select “OK” when it says the serial interface has been disabled. 
* Make sure the serial hardware is enabled

* Turn in ssh in the interfacing menu
* Reboot


After restart you should be able to access by ssh



### WIFI

Edit wpa supplicant file. 

`sudo nano /etc/wpa_supplicant/wpa_supplicant.conf`


	ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
	update_config=1
	country=GB
		
	network={
        ssid="ssid"
        psk="pw"
	}

	network={
        ssid="ssid"
        psk="pw"
	}


### Step 3 – Enable UART
Edit the config.txt file using

	sudo nano /boot/config.txt

At the bottom of this file there is a line containing “enable_uart=0”. Change this to “enable_uart=1”.


### Install minicom

	sudo apt-get install minicom
	

Once installed you can use Minicom to send data to the Pi-Lite using the following command :

	minicom -b 9600 -o -D /dev/serial0

Pressing keys on your keyboard should result in them appearing on the Pi-Lite!

To exit Minicom press “CTRL-A”, then “X” and finally press “Return” to select “Yes” from the prompt.


### Install chimneypot scripts
	sudo apt install git
	git clone https://github.com/chrissyhroberts/chimneypot_oracle.git
