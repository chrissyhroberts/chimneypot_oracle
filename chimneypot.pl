#!/usr/bin/perl -w
# guardian-list -- list Guardian articles matching keyword
use strict;
use warnings;
use open qw(:std :utf8);
use LWP::Simple;
#use YAML::Tiny;
use JSON;
use URI;
use utf8;
use YAML;
use XML::RSSLite;
use strict;
use Device::SerialPort;
use Net::Google::Calendar;
use Time::Stamp 'gmstamp';
use Time::HiRes qw(gettimeofday);
use Mail::IMAPClient;
use IO::Socket::SSL; 
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
$port->write("Welcome to the Chimneypot Oracle");
sleep 20;
&randomnumberfrom3;

############################
############################

sub randomnumberfrom3
{
if($count==150){
#system("gpio mode 5 out");
#system("gpio write 5 0");
#system ("sudo shutdown  now");
exit;
}
else
{
$count++;
print "\ncount : $count\n\n";
my $range = 10;
my $random_number = int(rand($range));
print $random_number . "\n";

#if ($count == 9){
#print "\n\nALl done\n\n"; exit};
if ($random_number==0){&bbc_weather};
if ($random_number =~/[4-5]/) {&bbc_news};
if ($random_number =~/[6-7]/) {&astronomy_news};
if ($random_number =~/[8]/) {&onthisday};
if ($random_number==2){&calendar};
if ($random_number==1){&clock};
#if ($random_number==3){&gmail};
if ($random_number==9){$count--};
if ($random_number==2){$count--};
}
&randomnumberfrom3;
}

####################
sub astronomy_news
{
# get the RSS
my $URL = 'http://feeds.sciencedaily.com/sciencedaily/space_time/astronomy?format=xml';

my $content = get($URL);

# parse the RSS
my %result;
parseRSS(\%result, \$content);

my $range=scalar(keys %result);;
print "News $range";
 my $random_number = int(rand($range));

  print $random_number . " random \n";
# print report of matching items
my$count=0;
foreach my $item (@{ $result{items} })
{
  $count++;
  if($count == $random_number){
  my $title = $item->{title};
  $title =~ s{\s+}{ };  $title =~ s{^\s+}{  }; $title =~ s{\s+$}{  };
  my @breakdown=split(/ /,$title);
  	foreach(@breakdown){
						  print "$_ ";
						  $port->write("$_ ");
						sleep 1;
						}
 sleep 35;}
 else{next}
   }
}

####################
sub bbc_weather
{
#####BBC WEATHER THREE DAY FORECAST LONDON ########
# get the RSS
my $URL = 'http://open.live.bbc.co.uk/weather/feeds/en/2643490/3dayforecast.rss';
my $content = get($URL);

# parse the RSS
my %result;
parseRSS(\%result, \$content);

my $range=3;
 my $random_number = int(rand($range));

  print $random_number . " weather random \n";
# print report of matching items
my$count=0;
foreach my $item (@{ $result{items} })
{
  $count++;
  if($count == $random_number){
  my $title = $item->{title};
  $title =~ s{\s+}{ };  $title =~ s{^\s+}{  }; $title =~ s{\s+$}{  };
  my @breakdown=split(/ /,$title);
  	foreach(@breakdown){
						  print "$_ ";
						  $port->write("$_ ");
						sleep 1;
						}
 sleep 35;}
 else{next}
   }
}
############################
############################

sub bbc_news
{
#####BBC news  LONDON ########
# get the RSS
my $URL = 'http://feeds.bbci.co.uk/news/rss.xml?edition=uk';

my $content = get($URL);

# parse the RSS
my %result;
parseRSS(\%result, \$content);

my $range=scalar(keys %result);;
print "News $range   ";
 my $random_number = int(rand($range));

  print $random_number . " random \n";
# print report of matching items
my$count=0;
foreach my $item (@{ $result{items} })
{
  $count++;
  if($count == $random_number){
  my $title = $item->{title};
  $title =~ s{\s+}{ };  $title =~ s{^\s+}{  }; $title =~ s{\s+$}{  };
  my @breakdown=split(/ /,$title);
  	foreach(@breakdown){
						  print "$_ ";
						  $port->write("$_ ");
						sleep 1;
						}
 sleep 35;}
 else{next}
   }
}

############################
############################

sub onthisday
{
#####BBC news  LONDON ########
# get the RSS
my $URL = 'http://news.bbc.co.uk/rss/on_this_day/front_page/rss.xml';

my $content = get($URL);

# parse the RSS
my %result;
parseRSS(\%result, \$content);

my $range=scalar(keys %result);;
print "News $range";
 my $random_number = int(rand($range));

  print $random_number . " random \n";
# print report of matching items
my$count=0;
foreach my $item (@{ $result{items} })
{
  $count++;
  if($count == $random_number){
  my $title = $item->{title};
  $title =~ s{\s+}{ };  $title =~ s{^\s+}{  }; $title =~ s{\s+$}{  };
  my @breakdown=split(/ /,$title);
  	foreach(@breakdown){
						  print "$_ ";
						  $port->write("$_ ");
						sleep 1;
						}
 sleep 35;}
 else{next}
   }
}


############################
############################

sub calendar
{
#####GOOGLE CALENDAR FOR BIRTHDAYS ETC ########
# get the RSS
#https://www.google.com/calendar/feeds/projectfish2013%40gmail.com/private-85abfb09fd5cb1169c21a6d53fb7aac9/basic
 my $cal = Net::Google::Calendar->new( url => 'https://www.google.com/calendar/feeds/er8qgkg82pc6kd34bgn89t5f2g%40group.calendar.google.com/private-4f55997e705bede8e799fdd972afd2fd/basic' );

print"calendar\n";
my $limitlow = substr(&currenttimestamp,0,11).'00:00:01z';
#print "\nlow $limitlow  low\n";

my $limithigh = substr(&currenttimestamp,0,11).'23:59:59z';
#print "\nhigh $limithigh high \n";
for ($cal->get_events('start-min'=>$limitlow,'start-max' => $limithigh)) {
print"limitlow\n";
print"limithigh\n";
       print $_->title."   :   ";
$port->write("Today : ". $_->title." " );

my@tootoo =  $_->content->body."\n*****\n\n";
foreach(@tootoo){
if (/When/) {
my$current=$';
if ($current =~	/to/){$current = $`};
								
print " $current";
#$port->write("$current" );
}
    }
    sleep 20}
}



########################
########################


sub clock
{
my $sec        = gettimeofday();   # scalar context
my ( $s, $ms ) = gettimeofday();   # list context
my $float_t = "$s.$ms";
my $time =  scalar(localtime($sec));
print $time;
 $port->write("$time ");
sleep 15;
}


sub gmail
{
my $socket = IO::Socket::SSL->new(
   PeerAddr => 'imap.mail.yahoo.com',
   PeerPort => 993,
  )
  or die "socket(): $@";

my $client = Mail::IMAPClient->new(
   Socket   => $socket,
   User     => 'missbissuk@yahoo.co.uk',
   Password => 'marjoryrevill1',
  )
  or die "new(): $@";

my $cont = 1;
$client->select('INBOX');
my @mails = ($client->unseen);
@mails =  $mails[rand @mails];

foreach my $id (@mails) {

    my $from = $client->get_header($id, 'From');
    my $subject = $client->get_header($id, 'subject');
        print "$subject\n";
if($subject=~/\=/){
print"skipping\n";
sleep 5;
}else{
 $port->write("$subject ");}
sleep 20;
    };


$client->logout();
}




sub currenttimestamp
{

 my $now = gmstamp();

#  my $mtime = gmstamp( (stat($file))[9] );
print $now;
$now;

}


