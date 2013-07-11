use 5.008005;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Opus10',
    VERSION_FROM      => 'lib/Opus10.pm', # finds $VERSION
    PREREQ_PM         => { Tie::SecureHash => 1.03 },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (AUTHOR         => 'Bruno R. Preiss <brpreiss@brpreiss.com>') : ()),
);
