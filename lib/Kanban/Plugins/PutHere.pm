package Kanban::Plugins::PutHere;
use     Mojo::Base 'Mojolicious::Plugin';
use     Path::Tiny;

our $VERSION    =   'v1.0.0';

=pod Name, Version, Synopsis

=encoding utf8

=head1 NAME

Put Here - Simple template helper.

=head1 VERSION

v1.0.0

=head1 SYNOPSIS

 #In your template:
    blah blah blah
    PUT-PLACE-HOLDER-1-HERE
    blah blah blah
    PUT-PLACE-HOLDER-2-HERE
    blah blah blah
    PUT-SOMETHING-HERE
    blah blah blah
    PUT-SOMETHING-ELSE-HERE


 #In your code:
    my  $populated_template =   put_here(

                                    #Template to populate...
                                    $template_with_placeholders,

                                    #What to populate it with...
                                    'PLACE-HOLDER-1'    =>  $value1,
                                    'PLACE-HOLDER-2'    =>  $value2,
                                    SOMETHING           =>  $value3,
                                    'SOMETHING-ELSE'    =>  $value4,

                                );

=cut

=pod Description - Register

=head1 DESCRIPTION

Registers C<< put_here >> as a Mojolicious Helper.

=cut

sub register {
    my ($self, $app, $config) =   @_;

    my  $helpers={
        put_here        =>  \&put_here,
        set_dir         =>  \&set_dir,
        group_set_slurp =>  \&group_set_slurp,
    };
    
    for my $current (keys $helpers->%*) {
        $app->helper($current    =>  $helpers->{$current});
    };
    return;

#    my ($self, $app, $config) =   @_;

#    $app->helper(
#      put_here        =>  \&put_here,
#        set_dir         =>  \&set_dir,
#        group_set_slurp =>  \&group_set_slurp,
#    );
#    return;
}



sub put_here {

=pod Description - Initial Values

Takes a text template with C<< PUT-SOMETHING-HERE >> placemarkers,
followed by C<< SOMETHING => VALUE >> key value pairs.

=cut

	#Initial values:
    my  $self               =   shift;
    my	$text				=	shift @_;
	my	@values_in_order	=	@_;
	my	%values				=	@values_in_order;

=pod Description - Processing

Finds placeholders and replaces them with values.

=cut

	#For each value in order of array...
	foreach my $currentvalue (@values_in_order) {
	
		#If current value is a hash key...
		if (exists $values{$currentvalue}) {

			my	$placeholder=	$currentvalue;
			
			my	$find		=	qr/PUT-$placeholder-HERE/;

			my 	$replace	=	$values{$placeholder};

			#Find and Replace within Text:
			$text			=~	s/$find/$replace/g;
		
		}
		
	};

=pod Description - Result.

Returns a copy of the text template, with the values put in place.

=cut

	#Return the final result:
	return $text;
}

sub set_dir {
    my  $self   =   shift;
	#Add Directory as second argument
	splice	@_,	1,	0,	"Directory";
	
	#Pass all arguments to Setandcheck, and return the result.
	return	&set_and_check(@_); #returns path object we can use.
}

#Called by:	setdir						setfilepath					setemail	setslurp
sub set_and_check {

	#Initial Values:
    #my  $self                       =   shift;
	my	(
			$name,
			$what,
			$where_or_email,
			$fallback
		)							=	@_;
	my	(
			$callerpackage,
			$callerfilename,
			$callerline,
			$callersubroutine,
		) 							=	caller(2);

	my ($where,$email)				=	($where_or_email) x2; #two names, one value/
	my	$checked					=	undef;	
	my	$errorfooter				=	"See package $callerpackage, ".
										"file $callerfilename, ".
										"line $callerline, ".
										"subroutine $callersubroutine. ".
										"Stopped ";

	#Initial values check:	
	die 								qq(Please specify what to check for ).
										qq(in subroutine "setandcheck".\n).
										qq(Valid options are anything starting with ).
										qq("dir", "file" or "email".\n).
										qq($errorfooter)
										unless $what; #exists
	
	die									"Path not true. $errorfooter"
										unless $where; #is a true value
	
	#Check Email:
	if ($what =~ /^email/i)	{

		#Use fallback, if email not valid:
		$email						=	$fallback 
										unless Email::Valid->address($email);

		#Die if email still not valid:
		die								"Invalid $name Email Address. $errorfooter"
										unless Email::Valid->address($email);

		#Save what we checked:
		$checked					=	$email;

	}
	
	#Check Dir & File:
	else {

		#Initial Values:	
		my 	$path					=	path($where);
	
		#Check Dir:
		if ($what =~ /^dir/i	)	{

			die							"No valid $name folder. $errorfooter"
										unless $path->is_dir;

			$checked				=	$path;
		};

		#Check File:
		if ($what =~ /^file/i	)	{
		
			unless ($path->is_file) {

				die						"No valid $name file from path $path. $errorfooter"
										unless $fallback;
		
				$path				=	path($fallback);

				die						"No valid $name fallback file. $errorfooter"
										unless $path->is_file;

			};

			$checked				=	$path;
		};

		#The ^ (start of string) in the regex is important as it ensures
		#$checked won't accidentally be set twice. 
		#This is because $what can never begin with e, d, or f simultaneously.
		
	};
	
	die									"The check on $name $what".
										"in subroutine setandcheck failed.".
										"$errorfooter"
										unless $checked; #is a true value.
	return $checked;
	
}
#Calls:		Nothing.

#Called by: Website modules that need it.
sub group_set_slurp {
    my  $self                   =   shift;

	#Grab submitted Hash Ref:
	my	($hashref)				=	@_;

	#Make it a normal hash:
	my	%hash					=	%$hashref; #de-reference

	#Make a new empty hash:
	my	%newhash				=	();

	#What are gonna deal with via set_and_check?
	my	$what					=	"File";

	#Grab any basepath value from our hash...
	#(i.e. common starting point of paths declared via the basepath key):
	my	$basepath				=	$hash{basepath};

	#Avoid the basepath key in our foreach loop coming up...
	my	$avoid					=	'basepath';

	#For each submitted hash key:
	foreach my $currentkey (keys %hash) {

		unless (fc $currentkey eq fc $avoid) {

			#Get the anon array ref:
			my	$arrayref			=	$hash{$currentkey};

			#Turn it into a normal array:
			my	@array				=	@$arrayref;

			#Grab the name:
			my	$name				=	shift @array;

			#Assume the rest of the array are path parts:
			my	$where				=	$basepath?
											path($basepath,@array):
										path(@array);

			#Slurp in the Set And Check result for our message and path:
			$newhash{$currentkey}	=	path(
											&set_and_check(
												$name,
												$what,
												$where,
											)
										)->slurp_utf8;
		}; #end unless
	}; #end foreach

	return	\%newhash; #return the finished newhash as a hashref.
	#returns slurped contents in hashref, not an object we can use.
}
#Calls:		set_and_check


1;

=pod See Also, Author and License sections.

=head1 SEE ALSO

L<MojoTest>

=head1 AUTHOR

Andrew Mehta

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut