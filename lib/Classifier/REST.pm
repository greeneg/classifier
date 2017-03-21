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
# $Rev: $
# $Author: $
# $Date: $
#

package Classifier::REST;

use strict;
use warnings;
use English;
use utf8;

use Config::IniFiles;
use Dancer2;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Classifier::Constants;

my $DEBUG = 0;
if (exists $ENV{'DEBUG'} && $ENV{'DEBUG'} == 1) {
    $DEBUG = 1;
}

our $VERSION = $Classifier::Constants::version;

sub err_log {
    return print STDERR "@_\n";
}

sub load_config {
    my $appdir = shift;

    my $sub = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;

    my $config = Config::IniFiles->new(-file => "$appdir/conf.d/config.ini",
                                       -allowcontinue => 1) or
                    croak("== ERROR ==: $sub: Could not read configuration: $OS_ERROR\n");

    my %configuration = ();

    $configuration{'webroot'}           = $config->val('Web', 'webpath');

    return %configuration;
}

sub get_root {
    my $sub = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;

    my $_c = shift;
    my %config = %{$_c};
    undef $_c;

    use Data::Dumper;

    print STDERR Dumper(%config), "\n";
    
    status 200;
    my $root = {
        'data'  => undef,
        'links' => {
            'self' => $config{webroot} . "/"
        }
    };
    return $root;
}

sub main {
    err_log(">> Starting the Puppet Classifier API server version ". $Classifier::Constants::version);
    err_log("\n-------------------------------------------------------------");

    # Dancer2 configuration
    my $appdir = config->{appdir};

    my %config = load_config($appdir);

    set serializer     => 'JSON';
    set startup_info   => 1;

    # our get URLs
    get '/'                              => sub { get_root( \%config ) };
}

main();

true;
