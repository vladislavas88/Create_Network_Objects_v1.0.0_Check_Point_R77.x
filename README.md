 
Using the script for create network objects for Check Point dbedit
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
