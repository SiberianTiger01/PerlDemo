#!/usr/bin/perl

use strict;
use warnings;
use vm;
use CGI;

BEGIN{
	use CGI::Carp qw(fatalsToBrowser carpout set_message);
	open(LOG, ">>/var/www/cgi-bin/errors.log") || die "couldn't append to erros.log: $!\n";
	carpout(*LOG);
	sub handle_errors {
		my $msg = shift;
		print "<h1> Software Error Alert</h1>";
		print "<h2> Your program sent this error:<br><I>$msg</h2></I>";
	}
	set_message(\&handle_errors);
}

my $cgi = new CGI;
my $vm = vm->new();
my $name = $cgi->param('name');
my $age  = $cgi->param('age');
my $address = $cgi->param('address');
my $position = $cgi->param('position');
my $salary = $cgi->param('salary');

my $res=$vm->insert($name,$age,$address,$position,$salary);


print "Content-type: text/html\n\n";

print<<Done;
	<html>
 	<head><title> page Test1 </title>
  	<script type="text/javascript">
    		function delyLoad(){
        		setTimeout(function(){
        		window.location.href="http://127.0.0.1/center.html";
        		},3000)
    		}
  	</script>
 	</head>
 	<body onload="delyLoad()">
 	<h1>New Record of $name is created successfully</h1>
 	</body>
	</html>
Done
