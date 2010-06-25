package Config::IniFiles;
$VERSION = "RDB";
use Moose;
use MooseX::NonMoose;
use Scalar::Util;
use Data::Dumper;
extends 'Config::IniFiles_ORIG';

override val => sub {
    my $self = shift;
    #super();
    return new_V1_val($self, @_);
};


#Taken from IniFiles.pm original.
#Adding a few things like reftype

sub new_V1_val {
  my ($self, $sect, $parm, $def) = @_;

  # Always return undef on bad parameters
  return if not defined $sect;
  return if not defined $parm;
  
  if ($self->{nocase}) {
    $sect = lc($sect);
    $parm = lc($parm);
  }
  
  my $val = defined($self->{v}{$sect}{$parm}) ?
    $self->{v}{$sect}{$parm} :
    $self->{v}{$self->{default}}{$parm};
  
  # If the value is undef, make it $def instead (which could just be undef)
  $val = $def unless defined $val;
  
  # Return the value in the desired context
  if (wantarray) {
    if (ref($val) eq "ARRAY") {
      return @$val;
    } elsif (defined($val)) {
      return $val;
    } else {
      return;
    }
  } elsif (ref($val) eq "ARRAY") {
  	if (defined ($/)) {
	    return join "$/", @$val;
	} else {
		return join "\n", @$val;
	}
  } else {
    return $val;
  }
}





no Moose;
# no need to fiddle with inline_constructor here
__PACKAGE__->meta->make_immutable;

