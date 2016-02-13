require 'formula'

class Libpo6 < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libpo6-0.8.0.tar.gz'
  sha1 'f3cb7009d0379ac2da9f3800991c86af584558ee'

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'autoconf-archive'
  depends_on 'libtool'

  def install
    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
