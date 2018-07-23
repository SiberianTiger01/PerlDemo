package vm;

use warnings;
use strict;
use Carp;
use DBI;
use CGI qw(:standard :html3);


sub new {
	my ($class) = shift;
	my $self = {"name"=>undef, "id"=>undef };
	bless($self, $class);
	return $self;
}

sub connect {
	my $self = shift;
	my $dbh = DBI->connect("dbi:Pg:dbname=testdb;host=127.0.0.1;port=5432","postgres","", { RaiseError=>1, PrintError=>0, ShowErrorStatement=>1, AutoCommit=>1 });
	#print "\nopen database successfully\n";
	return  $dbh;
}

sub checkbyname{
	my $self = shift;
	my $stmt = "select * from company where name like '";
	$self->{"name"}=shift;
	my @result;

	$stmt = $stmt.$self->{"name"}.'%\'';
	
 	 if($self->connect){
 	 	@result=$self->connect->selectrow_array($stmt);
		#print "Query result: @result\n";
		if(@result)  {  return 1;  } else { return 0; }
	}elsif ($self->connect->err){
		print "Error querying data: ", $self->connect->errstr, "\n";
	}else{
		print "No data available for this query.\n";
	}
}

sub  readbyname{
	my $self = shift;
	my $stmt = "select * from company where name like '";
	$self->{"name"}=shift;
	my $sth;

	$stmt = $stmt.$self->{"name"}."%\'";

	if($self->connect){
		$sth=$self->connect->prepare($stmt);
		$sth->execute();

	my $results= $sth->fetchall_arrayref();

		return $results;
	}
}

sub insert {
	my $self = shift;
        $self->{"name"}=shift;
	$self->{"age"}=shift;
        $self->{"address"}=shift;
	$self->{"position"}=shift;
	$self->{"salary"}=shift;

	my $stmt = "insert into company(name, age, address, position, salary)values('";
     	   $stmt = $stmt.$self->{"name"}."\',".$self->{"age"}.",\'".$self->{"address"}."\',\'".$self->{"position"}."\',".$self->{"salary"}.");";
        #print  $stmt,"\n";

  	if($self->connect){	

  		$self->connect->do($stmt)or die $DBI::errstr;
	#	print "insert successfully\n";
	
#			eval{   
#		 		$self->connect->do("insert into china(uid, login)values(2,'jet');");
#			};
	
# 			if($@){
 #				print "Failed: $_\n";
 #			}else{
 #				print "\ninsert successfully\n";
 #			}

  	}else	{     print "\n cannot connect to database\n";}	
	$self->connect->disconnect();
	return 1;
}

sub read {
  	my $self = shift;
  	my $stmt = qq(SELECT * FROM company;);
	
 	my $sth = $self->connect->prepare($stmt);
	my $rv = $sth->execute();
	if($rv<0){
		print $DBI::errstr;
	}
	my $row = $sth->fetchall_arrayref();
		
 	$self->connect->disconnect();
	return  $row;
}

sub deletebyname {
	my $self = shift;
	$self->{"name"}=shift;

	#print   "query name:", $self->{"name"}, "\n";

	my $stmt = "delete from company where name like '";
 	
	$stmt = $stmt.$self->{"name"}.'%\'';
	# print "query:", $stmt, "\n";

  	if($self->connect){	
  		$self->connect->do($stmt)or die $DBI::errstr;
		
 	#	print "delete record successfully\n";
 	}else{
 		print "Some Error occurred during deletion\n";	
 	}
	$self->connect->disconnect();
}
1;
