#!/usr/bin/env perl
#
# Author: Gary Greene <greeneg@tolharadys.net>
# Copyright: 2016 YggdrasilSoft, LLC. All Rights Reserved
#
##########################################################################
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#    
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License. 
#

package Classifier::Functions;

use strict;
use warnings;
use English;
use utf8;

use Date::Format;
use Dancer2;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Classifier::Constants;

use Exporter qw(import);

# module related boilerplate
our @ISA = qw(Exporter);
our @EXPORT = qw(err_log);
our @EXPORT_OK = qw(cur_time mk_json_struct);

my $DEBUG = 0;
if (exists $ENV{'DEBUG'} && $ENV{'DEBUG'} == 1) {
    $DEBUG = 1;
}

our $VERSION = $Classifier::Constants::version;

sub err_log {
    return print STDERR "@_\n";
}

sub cur_time {
    my @lt = localtime(time);
    return strftime( '%Y-%m-%dT%H:%M:%S.000Z', @lt );
}

sub mk_json_struct {
    my $json_struct = {
        'jsonapi'  => { 'version' => '1.0' },
    };

    return $json_struct;
}

true;
