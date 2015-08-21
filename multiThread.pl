#!/usr/bin/perl -w
# Verified on Windows 8
# Need to install Net::Telnet module
#
use strict;
use Net::Telnet;

use constant Timeout =>'5';
use constant USER => 'XXXXXXX';
use constant PASS => 'XXXXXXX';

my $pid = fork();

if (not defined $pid) {
	print "resources not avilable. ";
} 
elsif ($pid == 0) {
	print "This is the child process.\n";
	sleep 1;
	#Run telnet
	my $telnet=Net::Telnet->new(
        Timeout =>10,
        Prompt =>'/./',
        host =>'XXX.XXX.XXX.XXX'
        );
	print "Perl Telnet Test on W530.\n";

	$telnet->dump_log('log');
	$telnet->login(USER,PASS);
	$telnet->waitfor('/\>/');#Wait for cmd charater
	my @lines=$telnet->cmd("ipconfig");
	print @lines;

	#end telnet
	exit(0);
} else {
	print "IM THE Parent Process.\n";
	waitpid($pid,1);
}
	print "END ALL Process.";
