#!/usr/bin/perl
use Test::More;
use JavaScript::V8;
use strict;
use warnings;

my $context = JavaScript::V8::Context->new();
ok $context,"creating new JavaScript::V8::Context";
my $val = $context->eval("777");
is $val,777,"integers";

{
  use utf8;
  is($context->eval("'Μπορώ να φάω σπασμένα γυαλιά χωρίς να πάθω τίποτα'"), "Μπορώ να φάω σπασμένα γυαλιά χωρίς να πάθω τίποτα", 'unicode strings');
}

{
  local $TODO = "Latin-1 in eval";
  is($context->eval("'\x{a3}'"), "\x{a3}", 'latin-1 strings');
}

is($context->eval("1.34"), 1.34, 'numbers');
ok(!defined $context->eval('undefined'), 'undefined');
ok(!defined $context->eval('null'), 'null');

done_testing;
