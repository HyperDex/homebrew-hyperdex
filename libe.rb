require 'formula'

class Libe < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libe-0.9.0.tar.gz'
  sha1 '30b6273a1f374035dfbe770bdee36ac0b30a24c4'

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'pkg-config'

  depends_on 'libpo6'

  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
