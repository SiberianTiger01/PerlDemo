#!/usr/bin/perl
use DBI;
use strict;
use warnings;
use CGI qw(:standard :html3);
use vm;
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


print header(), start_html("Main Menu"),
      h1("View All Records"),
      start_form(),
      submit({-value=>'Update the View of All Records'}),
      end_form();

my $vm1 = vm->new();
my ($id, $login);
    print  "<TABLE BORDER=1>";

    my $table = $vm1->read;  
	
	if($table){
		foreach  my $row (@$table){
	 		$id = $row->[0];
	 		$login = $row->[1]; 
        		#print Tr( td($row ) );
        		print Tr( td($id ), td($login) );
			}
	}else{    print  "No Records";  }     

    print "</TABLE>\n";
	

print end_html();
