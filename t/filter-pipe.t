#! /usr/bin/env perl

# Copyright (C) 2016 Guido Flohr <guido.flohr@cantanea.com>,
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

use Test::More tests => 5;

use Template;

my $tt = Template->new or die Template->error;

my ($template, $output);

$output = '';
$template = <<'EOF';
[%- USE Gettext -%]
[%- 'Hello, world!' | gettext -%]
EOF
$tt->process(\$template, {}, \$output) or die $tt->error;
is $output, 'Hello, world!';

$output = '';
$template = <<'EOF';
[%- USE Gettext -%]
[%- 'Hello, {who}!' | xgettext(who => 'world') -%]
EOF
$tt->process(\$template, {}, \$output) or die $tt->error;
is $output, 'Hello, world!';

$output = '';
$template = <<'EOF';
[%- USE Gettext -%]
[%- 'one file' | ngettext('many files', 1) -%]
EOF
$tt->process(\$template, {}, \$output) or die $tt->error;
is $output, 'one file';

$output = '';
$template = <<'EOF';
[%- USE Gettext -%]
[%- 'one file' | ngettext('many files', 42) -%]
EOF
$tt->process(\$template, {}, \$output) or die $tt->error;
is $output, 'many files';

$output = '';
$template = <<'EOF';
[%- USE Gettext -%]
[%- 'Context' | pgettext('Hello, world!', 42) -%]
EOF
$tt->process(\$template, {}, \$output) or die $tt->error;
is $output, 'Hello, world!';
