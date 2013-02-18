require 'formula'

class Libpo6 < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libpo6-0.3.1.tar.gz'
  sha1 'd546506a07715473ce0ff9094a3976f54f1d946f'

  depends_on 'homebrew/dupes/gcc'
  depends_on 'autoconf'
  depends_on 'autoconf-archive'
  depends_on 'automake'
  depends_on 'libtool'

  def install
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc-4.7"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++-4.7"
    system "autoreconf -if"
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
