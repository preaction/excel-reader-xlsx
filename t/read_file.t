###############################################################################
#
# Tests for Excel::Reader::XLSX read_file() method
#
# reverse('(c)'), December 2013, Doug Bell, preaction@cpan.org
#

use lib 't/lib';
use strict;
use warnings;
use Excel::Reader::XLSX;
use FindBin qw( $Bin );
use File::Spec::Functions qw( catfile );

use Test::More;

###############################################################################
#
# Test that the temp dir gets cleaned up automatically
#
subtest 'temp directory cleanup' => sub {
    my $tmpdir;
    {
        my $xl = Excel::Reader::XLSX->new;
        my $wb = $xl->read_file( catfile( $Bin, 'regression', 'xlsx_files', 'data01.xlsx' ) );
        $tmpdir = $xl->{_package_dir};
        $xl = undef;
        ok -e $tmpdir, '_package_dir is maintained by Excel::Reader::XLSX::Workbook object';
    }
    ok !-e $tmpdir, '_package_dir is cleaned up after all objects are destroyed';
};

done_testing;
