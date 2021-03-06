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

package Classifier::REST::Read;

use strict;
use warnings;
use English;
use utf8;

use Dancer2;

use FindBin;
use lib "$FindBin::Bin/../lib";
use Classifier::Constants;
use Classifier::Functions qw(err_log cur_time mk_json_struct);

my $DEBUG = 0;
if (exists $ENV{'DEBUG'} && $ENV{'DEBUG'} == 1) {
    $DEBUG = 1;
}

our $VERSION = $Classifier::Constants::version;

sub new {
    my $class = shift;

    err_log("== DEBUGGING ==: Creating Object: Classifier::REST::Read") if $DEBUG;

    my $self  = {};
    bless $self, $class;

    return $self;
}

sub get_root {
    my $self = shift;

    my $sub = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;

    my $_c = shift;
    my %config = %{$_c};
    undef $_c;

    status 200;
    my $root = mk_json_struct();
    $root->{'data'}  = undef;
    $root->{'links'} = {
        'self'             => $config{webroot} . "/api/v1/",
        'computers'        => $config{webroot} . "/api/v1/computers",
        'classes'          => $config{webroot} . "/api/v1/classes",
        'distributions'    => $config{webroot} . "/api/v1/distributions",
        'environments'     => $config{webroot} . "/api/v1/environments",
        'operatingsystems' => $config{webroot} . "/api/v1/operatingsystems",
        'parent'           => $config{webroot} . "/api/v1/",
    };
    $root->{'attributes'} = { 'created' => cur_time() };

    return $root;
}

sub get_computers {
    my $self = shift;

    my $sub = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;
    # our configuration
    my $_c  = shift;
    my %config = %{$_c};
    undef $_c;
    # the database handle
    my $dbh = shift;

    status 200;
    my $computers = mk_json_struct();
    $computers->{'data'}  = undef;
    $computers->{'links'} = {
        'self'   => $config{webroot} . "/api/v1/computers",
        'parent' => $config{webroot} . "/api/v1/",
    };
    $computers->{'attributes'} = { 'created' => cur_time() };

    return $computers;
}

sub get_classes {
    my $self = shift;

    my $sub = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;
    # our config
    my $_c  = shift;
    my %config = %{$_c};
    undef $_c;
    # the database handle
    my $dbh = shift;

    status 200;
    my $classes = mk_json_struct();
    $classes->{'data'}  = undef;
    $classes->{'links'} = {
        'self'   => $config{webroot} . "/api/v1/classes",
        'parent' => $config{webroot} . "/api/v1/",
    };
    $classes->{'attributes'} = { 'created' => cur_time() };

    return $classes;
}

sub get_distribution_by_id {
    my $self    = shift;
    my $sub     = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;
    # our config
    my $_c      = shift;
    my %config  = %{$_c};
    undef $_c;
    # DB handle
    my $dbh     = shift;

    my $dist_id = params->{dist_id};

    my $sth = $dbh->prepare("SELECT * FROM distributions WHERE `Id` = ?");

    status 200;
    my $distribution = mk_json_struct();
    $distribution->{'data'}  = undef;
    $distribution->{'links'} = {
        'self'   => $config{webroot} . "/api/v1/distributions/$dist_id",
        'parent' => $config{webroot} . "/api/v1/distributions",
    };
    $sth->execute($dist_id);
    my $ref = $sth->fetchrow_hashref();
    my $distro = {
        'type'          => 'distribution',
        'id'            => $ref->{'Id'},
        'attributes'    => {
            'name'      => "$ref->{'DistributionName'}",
            'os'        => "$ref->{'OS'}"
        },
        'links'         => $config{webroot} . "/api/v1/distrbutions/$ref->{'Id'}",
        'relationships' => {
            'operatingsystems' => {
                'links'        => {
                    'self'     => $config{webroot} . "/api/v1/distrbutions/$ref->{'Id'}/distribution",
                    'related'  => $config{webroot} . "/api/v1/operatingsystems/$ref->{'OS'}/distributions"
                },
                'data'         => { 'type' => 'operatingsystem', 'id' => "$ref->{'OS'}" }
            }
        }
    };

    return $distribution;
}

sub get_distributions {
    my $self = shift;

    my $sub = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;
    # our config
    my $_c  = shift;
    my %config = %{$_c};
    undef $_c;
    # the database handle
    my $dbh = shift;

    # prepared statement
    my $sth = $dbh->prepare("SELECT * FROM distributions");

    status 200;
    my $distributions = mk_json_struct();
    $distributions->{'data'}  = undef;
    $distributions->{'links'} = {
        'self'   => $config{webroot} . "/api/v1/distributions",
        'parent' => $config{webroot} . "/api/v1/",
    };
    $sth->execute();
    my @distro_list;
    while (my $ref = $sth->fetchrow_hashref()) {
        push(@distro_list,
            {
                'type'          => 'distributions',
                'id'            => $ref->{'Id'},
                'attributes'    => {
                    'name'      => "$ref->{'DistributionName'}",
                    'os'        => "$ref->{'OS'}"
                },
                'links'         => $config{webroot} . "/api/v1/distributions/$ref->{'Id'}",
                'relationships' => {
                    'operatingsystems' => {
                        'links'        => {
                            'self'     => $config{webroot} . "/api/v1/distributions/$ref->{'Id'}/distribution",
                            'related'  => $config{webroot} . "/api/v1/operatingsystems/$ref->{'OS'}/distributions"
                        },
                        'data'         => { 'type' => 'operatingsystem', 'id' => "$ref->{'OS'}" }
                    }
                }
            }
        );
        $distributions->{'links'}->{$ref->{'Id'}} = $config{webroot} . "/api/v1/distributions/$ref->{'Id'}";
    }
    $sth->finish();
    $distributions->{'data'} = \@distro_list;
    $distributions->{'attributes'} = { 'created' => cur_time() };

    return $distributions;
}

sub get_environments {
    my $self = shift;

    my $sub = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;
    # our config
    my $_c  = shift;
    my %config = %{$_c};
    undef $_c;
    # the database handle
    my $dbh = shift;

    # prepared statement
    my $sth = $dbh->prepare("SELECT * FROM environments");

    status 200;
    my $environments = mk_json_struct();
    $environments->{'data'}  = undef;
    $environments->{'links'} = {
        'self'   => $config{webroot} . "/api/v1/environments",
        'parent' => $config{webroot} . "/api/v1/",
    };
    $sth->execute();
    my @env_list;
    while (my $ref = $sth->fetchrow_hashref()) {
        push(@env_list,
            {
                'type'       => 'environments',
                'id'         => $ref->{'Id'},
                'attributes' => {
                    'name'   => "$ref->{'Name'}"
                },
                'links'      => $config{webroot} . "/api/v1/environments/$ref->{'Id'}"
            }
        );
        $environments->{'links'}->{$ref->{'Id'}} = $config{webroot} . "/api/v1/environments/$ref->{'Id'}";
    }
    $sth->finish();
    $environments->{'data'} = \@env_list;
    $environments->{'attributes'} = { 'created' => cur_time() };

    return $environments;
}

sub get_operatingsystems {
    my $self = shift;

    my $sub = (caller(0))[3];
    err_log("== DEBUGGING ==: In function: $sub") if $DEBUG;
    # our config
    my $_c  = shift;
    my %config = %{$_c};
    undef $_c;
    # the database handle
    my $dbh = shift;

    # prepare statement
    my $sth = $dbh->prepare("SELECT * FROM operatingsystems");

    status 200;
    my $operatingsystems = mk_json_struct();
    $operatingsystems->{'data'}  = undef;
    $operatingsystems->{'links'} = {
        'self'   => $config{webroot} . "/api/v1/operatingsystems",
        'parent' => $config{webroot} . "/api/v1/",
    };
    $sth->execute();
    my @os_list;
    while (my $ref = $sth->fetchrow_hashref()) {
        push(@os_list,
            {
                'type'       => 'operatingsystem',
                'id'         => $ref->{'Id'},
                'attributes' => {
                    'name'   => $ref->{'Name'}
                },
                'links'      => $config{webroot} . "/api/v1/operatingsystems/$ref->{'Id'}"
            }
        );
        $operatingsystems->{'links'}->{$ref->{'Id'}} = $config{webroot} . "/api/v1/operatingsystems/$ref->{'Id'}";
    }
    $sth->finish();
    $operatingsystems->{'data'} = \@os_list;
    $operatingsystems->{'attributes'} = { 'created' => cur_time() };

    return $operatingsystems;
}

true;
