require 'formula'

class Libpo6 < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libpo6-0.4.1.tar.gz'
  sha1 '5e4014a37dd2d37458f3fe2596641f182a7636ca'

  depends_on 'homebrew/dupes/gcc'
  depends_on 'autoconf'
  depends_on 'autoconf-archive'
  depends_on 'automake'
  depends_on 'libtool'

  def install
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc-4.8"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++-4.8"
    system "autoreconf -if"
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
