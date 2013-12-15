require 'formula'

class Busybee < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/busybee-0.4.0.tar.gz'
  sha1 '5574a2cdfc196395604633fed584d99b892b53ea'

  depends_on 'autoconf'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'automake'
  depends_on 'libe'

  def patches
    DATA
  end

  def install
    ENV.delete 'LD'
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc-4.7"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++-4.7"
    libe = Formula.factory 'libe'
    libpo6 = Formula.factory 'libpo6'
    system "autoreconf -if"
    system "./configure", "--prefix=#{prefix}", "PO6_LIBS=-L#{libpo6.prefix}/lib",
            "PO6_CFLAGS=-I#{libpo6.prefix}/include", "E_LIBS=\"-L#{libe.prefix}/lib -le\"",
            "E_CFLAGS=-I#{libe.prefix}/include"
    system "make install"
  end
end
