#!/usr/bin/perl
use strict;
use warnings;
BEGIN {
    use Test::More tests => 6;
    use_ok 'SETI::Drake';
}

my $d = eval { SETI::Drake->new() };
warn $@ if $@;
isa_ok $d, 'SETI::Drake';
is $d->N, 10_000, 'Frank Drake is an optimist';

my %args = (
    R  => 0,
    fp => 0,
    ne => 0,
    fl => 0,
    fi => 0,
    fc => 0,
    L  => 0,
);
$d = SETI::Drake->new(%args);
is $d->N, 0, 'all zero values equal zero';

%args = (
    R  => 5,
    fp => 0.5,
    ne => 2,
    fl => 0.5,
    fi => 0.01,
    fc => 0.1,
    L  => 500,
);
$d = SETI::Drake->new(%args);
is $d->N, 1.25, 'Gene is a pessimist';

%args = (
    R  => 1_000_000_000,
    fp => 0.00001,
    ne => 0.33,
    fl => 0.00001,
    fi => 0.00001,
    fc => 0.00001,
    L  => 0.000000001,
);
$d = SETI::Drake->new(%args);

%args = (
    R  => 10,
    fp => 0.5,
    ne => 2,
    fl => 1,
    fi => 1,
    fc => 0.01,
    L  => 10,
);
$d = SETI::Drake->new(%args);
is $d->N, 1, 'Drake according to wikipedia'
