#! /usr/bin/env perl

# Copyright (C) 2016-2018 Guido Flohr <guido.flohr@cantanea.com>,
# all rights reserved.

# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU Library General Public License as published
# by the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.

# You should have received a copy of the GNU Library General Public
# License along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
# USA.

use strict;

use Test::More;

use File::Spec;
use Locale::XGettext::TT2;

BEGIN {
    my $test_dir = __FILE__;
    $test_dir =~ s/[-a-z0-9]+\.t$//i;
    chdir $test_dir or die "cannot chdir to $test_dir: $!";
    unshift @INC, '.';
}

my $relname = 'templates/no-package.tt';
my $absname = File::Spec->rel2abs('templates/no-package.tt');
my @po = eval { Locale::XGettext::TT2->new({plug_in => '',
                                            keyword => ['', 'loc'],
                                            flag => ['loc:1:perl-brace-format']
                                           }, $absname)->run->po };
ok !$@;
ok scalar @po;
is 2, scalar @po;
if (2 == @po) {
    is '"Price: {price}"', $po[1]->msgid;
    ok $po[1]->has_flag('perl-brace-format');
}
done_testing;
