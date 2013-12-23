require 'formula'

class Hyperleveldb < Formula
  homepage 'http://github.com/rescrv/HyperLevelDB'
  url 'http://hyperdex.org/src/hyperleveldb-1.0.1.tar.gz'
  sha1 '12ba2b093a4a67f04edaaeaf3f1db7943d0a3147'

  depends_on 'autoconf'
  depends_on 'homebrew/versions/gcc49' => :build

  def install
    system "./configure"
    system "make"
    system "make install"
  end
end
