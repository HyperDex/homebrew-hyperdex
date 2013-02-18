require 'formula'

class Busybee < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/busybee-0.2.3.tar.gz'
  sha1 'b2ed06321cbbe77dbdcecbb1b77e0325d390a913'

  depends_on 'autoconf'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'automake'
  depends_on 'seanogden/libe'

  def install
    ENV.delete 'LD'
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++"
    libe = Formula.factory 'libe'
    libpo6 = Formula.factory 'libpo6'
    system "autoreconf -if"
    system "./configure", "--prefix=#{prefix}", "PO6_LIBS=-L#{libpo6.prefix}/lib",
            "PO6_CFLAGS=-I#{libpo6.prefix}/include", "E_LIBS=\"-L#{libe.prefix}/lib -le\"",
            "E_CFLAGS=-I#{libe.prefix}/include"
    system "make install"
  end
end
