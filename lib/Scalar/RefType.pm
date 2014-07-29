package Scalar::RefType;
use strict;
use warnings;
use Carp;

our $VERSION = '0.01';

sub TIESCALAR {
    my ($class, $type) = @_;
    return bless { value => undef, type => ref $type ? ref $type : $type // '' };
}

sub FETCH { return $_[0]->{value} }

sub STORE {
    my ($self, $value) = @_;
    my $ref = ref $value // '';
    if ($ref ne $self->{type}) {
	croak 'invalid reference type';
    }
    return $self->{value} = $value;
}

__END__

=head1 NAME

 Scalar::RefType - simple scalar type checker

=head1 SYNOPSIS

 use Scalar::RefType;

 tie my $h1 => 'Scalar::RefType', {};
 tie my $h2 => 'Scalar::RefType', 'HASH';

 # dies:
 $h1 = [];

=head1 DESCRIPTION

This little module allows you to tie the type of a scalar to a specified
reference type. If the refererence type of an assignment violetes the 
tied type, the assignment throws an exception.

=head1 AUTHOR

Heiko Schlittermann <hs@schlittermann.de>

=cut
