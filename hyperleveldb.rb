require 'formula'

class Hyperleveldb < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/hyperleveldb-1.0.2.tar.gz'
  sha1 'f62f67f8084ed832d0e42b1e7bd2b3c2c851daf5'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make check"
    system "make install"
  end
end
