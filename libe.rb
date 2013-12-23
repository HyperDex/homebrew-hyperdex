require 'formula'

class Libe < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libe-0.4.1.tar.gz'
  sha1 'e30607fbc4f028c1c9952c677eea72e83b31da96'

  depends_on 'libpo6'

  def install
    cxxstdlib_check :skip
    ENV.delete 'LD'
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc-4.9"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++-4.9"
    libpo6 = Formula.factory 'libpo6'
    system "autoreconf -if"
    system "./configure", "--prefix=#{prefix}","PO6_CFLAGS=-I#{HOMEBREW_PREFIX}/include",
           "PO6_LIBS=\"\""
    system "make install"
  end
end
