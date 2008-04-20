# $Id: Drake.pm 865 2008-04-20 06:16:37Z gene $
package SETI::Drake;
$VERSION = 0.0102;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $proto = ref $class || $class;
    my $self  = {
        defaults => {
            R  => 5,
            fp => 0.5,
            ne => 2,
            fl => 1,
            fi => 0.2,
            fc => 1,
            L  => 10000,
        },
        @_
    };
    bless $self, $class;
    $self->_init();
    return $self;
}

sub _init {
    my $self = shift;
    for( keys %{$self->{defaults}} ) {
        # Make sure each equation term has a defined value.
        $self->{$_} = $self->{defaults}{$_}
            unless defined $self->{$_};
    }
}

sub N {
    my $self = shift;
    # Set N to the value of R.
    my $N = $self->{R};
    # Calculate the repeated product of every value of the object except R and the defaults.
    $N *= $self->{$_} for grep { !/^R|defaults$/o } keys %$self;
    return $N;
}

1;

__END__

=head1 NAME

SETI::Drake - Estimate the number of interstellar communicating civilizations

=head1 SYNOPSIS

  use SETI::Drake;
  $d = SETI::Drake->new(
      R  => $stars,
      fp => $planets,
      ne => $support,
      fl => $life,
      fi => $intelligence,
      fc => $communication,
      L  => $lifespan,
  );
  $n = $d->N;
  printf 'You are ' .
    ($n > $threshold ? 'opt' : 'pess') .
    "imistic: %0.2f\n", $n;

=head1 DESCRIPTION

A SETI::Drake object answers the question, "How many interstellar
communicating civilizations might be out there?"  This is of course
based on the famous speculation of Frank Drake.

=head1 METHODS

=head2 new

  my $d = SETI::Drake->new($arguments);

Return a new SETI::Drake instance.  If no equation variables are
provided, Drake's choices are used.

According to NOVA, Drake's values were:

  R  => 5,     # Number of stars formed per year.
  fp => 0.5,   # Fraction of those stars that form planets.
  ne => 2,     # Average number of those planets that can support life.
  fl => 1,     # Fraction of those planets that actually do develop life.
  fi => 0.2,   # Fraction of those planets that then evolve intelligence.
  fc => 1,     # Fraction of those planets that develop interstellar communication.
  L  => 10000, # Average lifetime (in years) of an interstellar communicating civilization.

According to Wikipedia, Drake's values were:

  R  => 10,  # Annual rate of star creation in our galaxy.
  fp => 0.5, # Fraction of those stars which have planets.
  ne => 2,   # Average number of planets which can potentially support life per star that has planets.
  fl => 1,   # Fraction of the above which actually go on to develop life.
  fi => 0.1, # Fraction of the above which actually go on to develop intelligent life.
  fc => 0.1, # Fraction of the above which are willing and able to communicate.
  L  => 10,  # Expected lifetime (in years) of such a civilisation.

On Cosmos, Carl Sagan computes it this way:

  R  => 400_000_000_000,  # Number of stars in the Milky Way.
  fp => 1/4,  # Fraction of stars that have planets.
  ne => 2,    # Worlds suitable for sustaining life per system.
  fl => 1/2,  # Fraction of suitable worlds in which life does arise
  fi => 1/10, # Fraction of worlds where intelligent life evolves.
  fc => 1/10, # Fraction of worlds that produce a technical civilization.
  L  => 1/100_000_000, # Chance that we might destroy ourselves tomorrow.

=head2 N

  $N = $d->N;

Return the real number value of the Drake equation.

=head1 SEE ALSO

L<http://www.youtube.com/watch?v=0Ztl8CG3Sys> Carl Sagan explains it.

L<http://www.setileague.org/general/drake.htm>

L<http://www.pbs.org/wgbh/nova/origins/drake.html>

L<http://en.wikipedia.org/wiki/Drake_equation>

L<http://www.hawking.org.uk/lectures/life.html>

L<http://setiathome.berkeley.edu>

=head1 COPYRIGHT

Copyright 2004, Gene Boggs, All Rights Reserved

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=head1 AUTHOR

Gene Boggs E<lt>gene@cpan.orgE<gt>

=cut
