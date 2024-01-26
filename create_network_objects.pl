#!/usr/bin/env perl

=pod

=head1 Using the script for create network objects for Check Point dbedit
#===============================================================================
#
#       FILE: create_network_objects.pl
#
#       USAGE: $ touch ./in_net.txt
#		 10.1.1.0/24
#		 10.2.2.0/25
#		 10.3.3.0/26
#		 10.4.4.0/27
#		 etc
#
#		$ ./create_network_objects.pl in_net.txt
#
#		$ cat ./net_network_objects.txt
#		  create network ln_10.1.1.0_24_usr
#		  modify network_objects ln_10.1.1.0_24_usr ipaddr 10.32.153.128
#	          modify network_objects ln_10.1.1.0_24_usr netmask 255.255.255.240
#	          modify network_objects ln_10.32.153.128_28_usr color 'forest green'
#  DESCRIPTION: Create network objects for Check Point dbedit
#
#      OPTIONS: ---
# REQUIREMENTS: Perl v5.14+ 
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Vladislav Sapunov 
# ORGANIZATION:
#      VERSION: 1.0.0
#      CREATED: 23.01.2024 22:48:36
#     REVISION: ---
#===============================================================================
=cut

use strict;
use warnings;
use v5.14;
use utf8;

# Result outFile for dbedit
my $outFile = 'net_network_objects.txt';

my %netmasks = (
    32 => '255.255.255.255',
    31 => '255.255.255.254',
    30 => '255.255.255.252',
    29 => '255.255.255.248',
    28 => '255.255.255.240',
    27 => '255.255.255.224',
    26 => '255.255.255.192',
    25 => '255.255.255.128',
    24 => '255.255.255.0',
    23 => '255.255.254.0',
    22 => '255.255.252.0',
    21 => '255.255.248.0',
    20 => '255.255.240.0',
    19 => '255.255.224.0',
    18 => '255.255.192.0',
    17 => '255.255.128.0',
    16 => '255.255.0.0',
    15 => '255.254.0.0',
    14 => '255.252.0.0',
    13 => '255.248.0.0',
    12 => '255.240.0.0',
    11 => '255.224.0.0',
    10 => '255.192.0.0',
    9  => '255.128.0.0',
    8  => '255.0.0.0',
    7  => '254.0.0.0',
    6  => '252.0.0.0',
    5  => '248.0.0.0',
    4  => '240.0.0.0',
    3  => '224.0.0.0',
    2  => '192.0.0.0',
    1  => '128.0.0.0',
    0  => '0.0.0.0',
);

my $createNetwork        = "create network ";
my $modifyNetworkObjects = "modify network_objects ";
my $netPrefix            = "ln_";
my $netName              = "_usr";
my $ipaddr               = "ipaddr ";
my $netmask              = "netmask";
my $color                = "color \'forest green\'";

# Open result outFile for writing
open( FHW, '>', $outFile ) or die "Couldn't Open file $outFile" . "$!\n";

while ( defined( my $line = <> ) ) {
    chomp($line);
    $line =~ /^((\d+)\.(\d+)\.(\d+)\.(\d+))\/(\d+)$/;
    my $net     = $1;
    my $bit     = $6;
    my $netmask = $netmasks{$bit};
    say FHW "$createNetwork" . "$netPrefix" . "$net" . "$netName";
    say FHW "$modifyNetworkObjects" . "$netPrefix" . "$net" . "_" . "$bit" . "$netName" . " " . "$ipaddr" . "$net";
    say FHW "$modifyNetworkObjects" . "$netPrefix" . "$net" . "_" . "$bit" . "$netName" . " " . "$netmask";
    say FHW "$modifyNetworkObjects" . "$netPrefix" . "$net" . "_" . "$bit" . "$netName" . " " . "$color";
}

# Close the filehandles
close(FHW) or die "$!\n";

say "**********************************************************************************\n";
say "Network objects TXT file: $outFile created successfully!";

my $cpUsage = <<__USAGE__;

***************************************************************************************
* # Create the object (of type network)
* create network ln_10.1.1.0_24_usr
*
* # Configure the network IP address
* modify network_objects net-internal ipaddr 192.0.2.0
*
* # Configure the netmask (in dotted decimal notation) of the network
* modify network_objects ln_10.1.1.0_24_usr netmask 255.255.255.240
*
* # Add a comment to describe what the object is for (optional)
* modify network_objects ln_10.1.1.0_24_usr comments ""Created by fwadmin with dbedit""
*
* modify network_objects ln_10.1.1.0_24_usr color 'forest green'
*
* # Color [aquamarine 1, black, blue, blue 1, burly wood 4, cyan, dark green, dark khaki,
* dark orchid, dark orange 3, dark sea green 3, deep pink, deep sky blue 1, dodger blue 3,
* firebrick, foreground, forest green, gold, gold 3, gray 83, * gray 90, green, lemon chiffon,
* light coral, light sea green, light sky blue 4, magenta, medium orchid, medium slate blue,
* medium violet red, navy blue, olive drab, orange, red, sienna, yellow, none]			
*
* #dbedit
* update_all
* savedb					
***************************************************************************************

__USAGE__

say $cpUsage;

