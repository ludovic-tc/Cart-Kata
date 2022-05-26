# NAME

Cart::Kata - Shopping Cart Exercise

# SYNOPSIS

    use Cart::Kata;

# DESCRIPTION

Cart::Kata provides a working solution for the SpareRoom shopping cart recruitment challenge.

# PUBLIC METHODS

## scan

**Not fully implemented:**

Polling a scanning device for a barcode is not yet implemented.

Instead, the item code can be accepted from STDIN.

## sell\_item

Accepts input via @\_ if available.

Otherwise, calls **scan()** to acquire the next barcode.

# LICENSE

Copyright © Ludovic Tolhurst-Cleaver.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Ludovic Tolhurst-Cleaver <camel@ltcdev.com>
