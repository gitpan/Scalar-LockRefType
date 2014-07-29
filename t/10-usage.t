#! perl

use strict;
use warnings;
use Test::More;
use Test::Exception;

use_ok 'Scalar::RefType' or BAIL_OUT q{Can't load the module};
isa_ok tie(my $h => 'Scalar::RefType', {}) => 'Scalar::RefType';
isa_ok tie(my $a => 'Scalar::RefType', []) => 'Scalar::RefType';
isa_ok tie(my $s => 'Scalar::RefType', \(undef)) => 'Scalar::RefType';
isa_ok tie(my $p => 'Scalar::RefType', undef)    => 'Scalar::RefType';

subtest 'NAMES' => sub {
    isa_ok tie(my $h => 'Scalar::RefType', ref {}) => 'Scalar::RefType';
    isa_ok tie(my $a => 'Scalar::RefType', ref []) => 'Scalar::RefType';
    isa_ok tie(my $s => 'Scalar::RefType', ref \(undef)) => 'Scalar::RefType';
    isa_ok tie(my $p => 'Scalar::RefType', '') => 'Scalar::RefType';

    is tied($h)->{type}, 'HASH'   => 'is a hash ref';
    is tied($a)->{type}, 'ARRAY'  => 'is a array ref';
    is tied($s)->{type}, 'SCALAR' => 'is a scalar';
    is tied($p)->{type}, ''       => 'is a "plain"';

};

is tied($h)->{type}, 'HASH'   => 'is a hash ref';
is tied($a)->{type}, 'ARRAY'  => 'is a array ref';
is tied($s)->{type}, 'SCALAR' => 'is a scalar';
is tied($p)->{type}, ''       => 'is a "plain"';

is ref($h = { a => 'A' }), 'HASH' => 'hash: assignment';
is ref($a = ['a', 'b']), 'ARRAY' => 'array: assignment';
is ref($s = \6), 'SCALAR' => 'scalar: assignment';
is ref($p = 6), '' => 'plain: assignment';

is $h->{a}, 'A' => 'hash: got the value';
is $a->[1], 'b' => 'array: got the value';
is $$s, 6, => 'scalar: got the value';
is $p,  6, => 'plain: got the value';

throws_ok { $h = [] } qr/invalid/ => 'hash: dies on invalid type';
throws_ok { $h = 6 } qr/invalid/  => 'hash: dies on invalid type';

done_testing;
