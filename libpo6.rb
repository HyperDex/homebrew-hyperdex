require 'formula'

class Libpo6 < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libpo6-0.5.0.tar.gz'
  sha1 '782b53d60bd70b20ebe60980af9340af3dbb82b5'

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
