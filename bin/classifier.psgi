#!/usr/bin/env perl -T
#
# Author: Gary Greene <greeneg@tolharadys.net>
# Copyright: 2017 YggdrasilSoft, LLC.
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

use strict;
use warnings;
use English;
use utf8;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Classifier;
use Classifier::REST;
use Plack::Builder;
use Classifier::Constants;

my $DEBUG = 1;
my $VERSION = "$Classifier::Constants::version";

sub err_log {
    return print STDERR "@_\n";
}

sub main {
    print STDERR ">> Starting the Puppet Classifier Web Application, version $VERSION\n";
    print STDERR ">> ". $Classifier::Constants::license . "\n";
    print STDERR "----------------------------------------------------------------------\n";
    err_log("== DEBUGGING ==: PERL INCLUDE PATH:") if $DEBUG;
    if ($DEBUG) {
        foreach my $p (@INC) {
            print STDERR "== DEBUGGING ==:    $p\n";
        }
    }
    err_log("== DEBUGGING ==: MOUNTING PLACK::BUILDER ENDPOINTS") if $DEBUG;

    builder {
        mount '/'        => Classifier->to_app;
        mount '/api/v1/' => Classifier::REST->to_app;
    };
}

main();
