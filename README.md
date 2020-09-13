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

### Set up Pi Lite
[https://www.raspberrypi-spy.co.uk/2013/09/how-to-setup-the-pi-lite-led-matrix-board/](https://www.raspberrypi-spy.co.uk/2013/09/how-to-setup-the-pi-lite-led-matrix-board/)

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

To make perl work, need some packages and cpanminus installer

	curl -L https://cpanmin.us | perl - --sudo App::cpanminus
	sudo cpanm install Device::SerialPort
	



Next we need to install the Python serial package :

	sudo apt-get install python-serial

Typing the following command will browse to the Python examples folder :

	cd PiLite/Python_Examples/

Some of the other scripts require a few more Python libraries to be installed.

	sudo apt-get install python-setuptools
	sudo apt-get install python-pip
	sudo apt-get install python-requests
	sudo pip install arrow
	sudo pip install functools_lru_cache
	
#### test the system

	python anytext.py hello, world


### install R
	sudo apt-get install r-base

Start a copy of R
	
	R

Add libraries

	install.packages("devtools")
	devtools::install_github("DataWookie/feedeR")

Quit R
	
	q()
	
	
