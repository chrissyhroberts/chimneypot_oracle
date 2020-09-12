#!/usr/bin/perl -w

use warnings;
use open qw(:std :utf8);
use strict;
use Device::SerialPort;


our $first_name=$ARGV[0];

#activate serial port for pi-lite function
#system ("./poo &");
#open OUTPUT, ">output.txt" or die $!;
#select OUTPUT;
my $port = Device::SerialPort->new("/dev/ttyAMA0");
$port->baudrate(9600);
#system ("/home/pi/lights_off.pl");
#system("gpio mode 5 out");
#system("gpio write 5 1");
#system("/home/pi/lights_on");
my $count=0;

#system ('sudo shutdown 3 &');
$port->write("$first_name");
