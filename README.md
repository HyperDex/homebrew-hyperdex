Homebrew tap for HyperDex.

## Installation

`brew tap HyperDex/hyperdex && brew install hyperdex.`

Optional client bindings can be individually selected with
`brew install --with-java-bindings --with-python-bindings --with-ruby-bindings hyperdex`


Enabling bindings for ycsb:

`CLASSPATH=<ycsb folder>/core/lib/core-<ycsb-version>.jar brew install --with-java-bindings --with-enable-ycsb hyperdex`
