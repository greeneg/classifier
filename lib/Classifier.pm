#!/usr/bin/env perl
#
# Author: Gary Greene <greeneg@tolharadys.net>
# Copyright: 2016 YggdrasilSoft, LLC.
#
#########################################################################################
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
# file except in compliance with the License. You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#    
# Unless required by applicable law or agreed to in writing, software distributed under
# the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the specific language governing
# permissions and limitations under the License.
#

package Classifier;

use strict;
use warnings;
use English;
use utf8;

use Dancer2 appname => 'classifier';
use FindBin;

use lib "$FindBin::Bin/../lib";
use Classifier::Constants;

my $DEBUG = 0;
if (exists $ENV{'DEBUG'} && $ENV{'DEBUG'} == 1) {
    $DEBUG = 1;
}

our $VERSION = $Classifier::Constants::version;

sub main {
    print STDERR ">> Starting the Puppet Classifier Front-end server version ". $Classifier::Constants::version . "\n" if $DEBUG;
    print STDERR "-------------------------------------------------------------\n" if $DEBUG;

    # Dancer2 configuration
    my $appdir = config->{appdir};

    set startup_info   => 1;
    set template       => 'template_toolkit';
    set static_handler => 1;

    print STDERR "-------------------------------------------------------------\n"    if $DEBUG;

#    my %configuration = loadConfig($appdir);


    get '/' => sub {
        template 'index';
    };
}

main();

true;
