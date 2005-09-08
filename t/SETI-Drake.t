#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 5;

use_ok 'SETI::Drake';

my $x = eval { SETI::Drake->new() };
warn $@ if $@;
isa_ok $x, 'SETI::Drake';
is $x->N, 10_000, 'Frank Drake is an optimist';

my %args = (
    R  => 0,
    fp => 0,
    ne => 0,
    fl => 0,
    fi => 0,
    fc => 0,
    L  => 0,
);
$x = SETI::Drake->new(%args);
is $x->N, 0, 'all zero values equal zero';

%args = (
    R  => 5,
    fp => 0.5,
    ne => 2,
    fl => 0.5,
    fi => 0.01,
    fc => 0.1,
    L  => 500,
);
$x = SETI::Drake->new(%args);
is $x->N, 1.25, 'Gene Boggs is a pessimist';
