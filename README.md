Homebrew tap for HyperDex.

## Installation

#Using formula from the official repository

`brew tap HyperDex/hyperdex && brew install hyperdex.`

Optional client bindings can be individually selected with
`brew install --with-java-bindings --with-python-bindings --with-ruby-bindings hyperdex`

## Using formula from this fork

`brew tap dayasakti/hyperdex && brew install hyperdex.`

## java binding hacks on macosx 10.7.5
(only when you install JDK from oracle)

Assuming that you are installing jdk1.7.0_45. Then you may need to create
a symlink below if you enable --with-java-bindings

```
sudo ln -sf /Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home/include  .
cd /Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home/include
sudo ln -sf darwin/jni_md.h .
sudo ln -sf darwin/jawt_md.h .
```

