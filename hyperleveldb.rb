require 'formula'

class Hyperleveldb < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/hyperleveldb-1.0.2.tar.gz'
  sha1 'f62f67f8084ed832d0e42b1e7bd2b3c2c851daf5'

  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
