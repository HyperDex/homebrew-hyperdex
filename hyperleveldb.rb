require 'formula'

class HyperLevelDB < Formula
  homepage 'http://github.com/rescrv/HyperLevelDB'
  url 'http://hyperdex.org/src/hyperleveldb-1.0.1.tar.gz'
  sha1 '12ba2b093a4a67f04edaaeaf3f1db7943d0a3147'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
