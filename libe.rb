require 'formula'

class Libe < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libe-0.5.0.tar.gz'
  sha1 '77c4ffc7472795c63baac12b5488b95b993f8dfe'

  depends_on 'libpo6'

  def install
    system "PKG_CONFIG_PATH=#{prefix}/lib/pkgconfig", "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
