use blib '..';
use Config::IniFiles;
use feature ':5.10';

my $cfg = Config::IniFiles->new( -file => "simple.ini" );

say $cfg->val( 'Section', 'Parameter' );

my  @values = $cfg->val('Section', 'Parameters');
say @values;




