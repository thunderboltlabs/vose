# Vose: Sample random values from a discrete probability distribution.

Vose is a Ruby implementation of the Vose Alias Method. It allows for
sampling of random values from a discrite probability distribution or in
others rolling a loaded die. This implementation is runs in O(1) time after
after a O(n) initialization.

For more information on the theory, have a look at [Darts, Dice, and Coins: Sampling from a Discrete Distribution](http://www.keithschwarz.com/darts-dice-coins/)

## Installation

To track the latest officially released gem:

    gem 'vose' # for the latest officially released gem

*OR* To track the git repo

    gem 'vose', :git => "git://github.com/thunderboltlabs/vose.git"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vose

## Usage

    probabilities = [0.4, 0.1, 0.2, 0.3]
    vose = Vose::AliasMethod.new probalities
    choice = vose.next

The choice will be an index of the probalities array.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
