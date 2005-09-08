# $Id: Drake.pm,v 1.4 2004/11/01 01:22:07 gene Exp $

package SETI::Drake;
use strict;
use warnings;
use Carp;
use vars qw( $VERSION );
$VERSION = 0.02;

sub new {
    my $class = shift;
    my $proto = ref($class) || $class;
    my $self  = {
        defaults => {
            R  => 10,
            fp => 0.5,
            ne => 2,
            fl => 1,
            fi => 0.1,
            fc => 1,
            L  => 10_000,
        },
        @_
    };
    bless $self, $class;
    $self->_init();
    return $self;
}

sub _init {
    my $self = shift;
    # Make sure each equation term has a defined value.
    for( keys %{ $self->{defaults} } ) {
        $self->{$_} = $self->{defaults}{$_}
            unless defined $self->{$_};
    }
}

sub N {
    my $self = shift;
    # Calculate the product of the object values except the defaults.
    my $N = $self->{R};
    $N *= $self->{$_} for grep { !/^R|defaults$/o } keys %$self;
    return $N;
}

1;

__END__

=head1 NAME

SETI::Drake - Estimate the number of interstellar communicating civilizations

=head1 SYNOPSIS

  use SETI::Drake;
  my $threshold = shift || 10_000;
  my $x = SETI::Drake->new(
      R  => $stars,
      fp => $planets,
      ne => $support,
      fl => $life,
      fi => $intelligence,
      fc => $communication,
      L  => $lifespan,
  );
  printf "You are %simistic: %0.2f\n",
    ($x > $threshold ? 'opt' : 'pess'), $x->N;

=head1 DESCRIPTION

A C<SETI::Drake> object answers the question, "How many detectible,
intelligent, interstellar communicating civilizations might be out
there, in the galaxy?" by providing a single method, C<N()>, which is
a prediction based on the product of seven factors.  In other words,
this module does nothing more than multiply seven numbers together.

According to the Nova Origins video, "Where Are The Aliens?", Drake's
values are:

  R  => 10      # How many stars are formed each year, in the Milky Way?
  fp => 0.5     # How many stars have planets?
  ne => 2       # How many planets can support life?
  fl => 1       # How many planets have life?
  fi => 0.1     # How often will life becme intelligent?
  fc => 1       # How many of those planets develop interstellar communication?
  L  => 10,000  # How long might a technologically advanced civilaztion last?

We get an optomistic N = 10,000.  According to the NOVA website however,
Drake's values are:

  R  => 5       # Rate of star formation per year, in the Milky Way
  fp => 0.5     # Percentage of stars that form planets
  ne => 2       # Average number of planets that could support life
  fl => 1       # Percentage of those planets where life actually occurs
  fi => 0.2     # Percentage of those planets where intelligence develops
  fc => 1       # Percentage of intelligent species that procude interstellar communications
  L  => 10,000  # Average lifetime (in years) of a communicating civilization

But again, we get N = 10,000.  Whew.  That was close.

Anyway, according to Wikipedia, Drake's values from 1961 were:

  R  => 10    # Annual rate of star formation in our galaxy.
  fp => 0.5   # Fraction of those stars which have planets.
  ne => 2     # Average number of planets which can potentially support life per star that has planets.
  fl => 1     # Fraction of the above which actually go on to develop life.
  fi => 0.01  # Fraction of the above which actually go on to develop intelligent life.
  fc => 0.01  # Fraction of the above which are willing and able to communicate.
  L  => 10    # Expected lifetime (in years) of such a civilisation.

Giving a slightly pessimistic value of 0.01 for N.

=head1 METHODS

=head2 new()

  my $d = SETI::Drake->new( %arguments );

Return a new SETI::Drake instance.  If no equation variables are
provided, Frank Drake's choices (from his 2004 chalkboard video
interview on Nova) are used.

=head2 N()

  $N = $d->N();

Return the real number value of the Drake equation:

  N = R* x fp x ne x fl x fc x L

=head1 SEE ALSO

C<http://en.wikipedia.org/wiki/Drake_equation>

C<http://www.pbs.org/wgbh/nova/origins/drake.html>

C<http://www.jb.man.ac.uk/research/seti/drake.html>

=head1 COPYRIGHT

Copyright 2004, Gene Boggs, All Rights Reserved

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=head1 AUTHOR

Gene Boggs E<lt>gene@cpan.orgE<gt>

=cut
