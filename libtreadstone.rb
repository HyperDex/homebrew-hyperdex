require 'formula'

class Libtreadstone < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libtreadstone-0.1.0.tar.gz'
  sha1 '5e34d8c67a2e7c1b3c5a6ade4c5141372297fb0d'

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'pkg-config'

  depends_on 'libpo6'

  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
