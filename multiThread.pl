	#!/usr/bin/perl -w

	use strict;
	use Net::Telnet;
	use warnings;

	use constant Timeout =>'5';
	use constant USER => 'XXX';
	use constant PASS => 'XXX';

	my $pid = fork();

	if (not defined $pid) {
		print "resources not avilable. ";
	} 
	elsif ($pid == 0) {
		print "This is the child process.\n";
		#Run telnet
		my $telnet=Net::Telnet->new(
			Timeout =>10,
			prompt=>'/./',
			host =>'XXX.113.XXX.XXX'
			);
		print "Perl Telnet Test on Dell.\n";

		$telnet->dump_log('log');
		$telnet->login(USER,PASS);
		$telnet->waitfor('/\>/');#Wait for cmd charater
		my @lines=$telnet->cmd("dir");
			print @lines;
		$telnet->waitfor('/\>/');#Wait for cmd charater
		my @line=$telnet->cmd("ipconfig");
			print @lines;
		$telnet->waitfor('/\>/');#Wait for cmd charater
		#end telnet
		exit(0);
	} else {
		print "IM THE Parent Process.\n";
		waitpid($pid,0);
	}
		print "END ALL Process.";
