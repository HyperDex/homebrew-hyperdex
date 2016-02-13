require 'formula'

class Hyperleveldb < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/hyperleveldb-1.2.2.tar.gz'
  sha1 '5cc2694f5f13388a28e17cd65a6b650ebc3d39a4'

  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
