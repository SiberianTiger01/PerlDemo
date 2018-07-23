#!/usr/bin/perl 
use vm;
use warnings;
#use strict;
use CGI;
use lib "perl-lib";
use errorhandler;

BEGIN{
	use CGI::Carp qw(fatalsToBrowser carpout set_message);
	open(LOG, ">>/var/www/cgi-bin/errors.log") || die "couldn't append to errors.log: $!\n";
	carpout(*LOG);
	sub handle_errors {
		my $msg = shift;
		print "<h1> Software Error Alert </h1>";
		print "<h2> Your program sent this error:<br><I>$msg</h2></I>";
	}
	set_message(\&handle_errors); 
}

my $query = new CGI;
#my $handler = new errorhandler;

print  $query->header;
print  $query->start_html(
			-title =>'Search',
			
		    );

&print_form($query);
&do_work($query) if ($query->param);

print $query->end_html;

sub print_form{
	my ($cgi) = @_;

	print 		$cgi->h1("Select Records:");
	print		$cgi->start_form;
	print           $cgi->h2("Please Enter User Name");
	print 		$cgi->textfield('name');
	print		$cgi->br();
	print		$cgi->br();
	print		$cgi->submit('action', 'Enter ');
	print		$cgi->reset('Clear');
	print		$cgi->end_form;
	print		$cgi->hr();
}


sub print_table{
	my ($table) = @_;
	my $row;

print "<table border=1><tr><td valign=bottom>UserID<td>User Name<td>Age<td>Address<td>Position<td>Salary\n\n";
	foreach   $row (@$table){
	
print "<tr><td>",$row->[0], "<td>",$row->[1], "<td>",$row->[2],"<td>",$row->[3],"<td>",$row->[4],"<td>",$row->[5];

	}	
	print "</table>";
}
	
sub do_work{
	my ($cgi) = @_;
	my ($name) = $cgi->param('name');
	print  $cgi->h2("This is the infomation you queried:");
	print  $cgi->h2("Query for record:", $name, "\n");
	my $vm = vm->new;
	my $res = $vm->checkbyname($name);
	my $table;
	if($res){
		$table = $vm->readbyname($name);
		&print_table($table);
	}
	else{
		print $cgi->h2("Record:", $name, " may NOT  exists");	
	}	
} 

