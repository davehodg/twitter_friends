use ExtUtils::MakeMaker;
WriteMakefile(
              NAME            => 'TwitterFriends',
              VERSION_FROM    => 'lib/TwitterFriends.pm'
 	      PREREQ_PM => {
		"Net::Twitter::Lite::WithAPIv1_1" => 0
 	      }
        );
