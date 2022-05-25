use strict;
use Test::More 0.98;
use Test::MockModule; 
use JSON::XS;

use_ok $_ for qw(
    Cart::Kata
);

my $test_shop = Cart::Kata; #?

{
    my $test_checkout = Test::MockModule->new('Cart::Kata');
    
    for ($prices) {
        $test_checkout->scan; 
    }
}

done_testing;

sub get_prices {
    my $pricefile = path('../data/pricelist.json');
    my $prices = decode_json($pricefile->slurp_utf8);
    return $prices; 
}
