require 'formula'

class Busybee < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/busybee-0.5.1.tar.gz'
  sha1 '4a33839aa1b1cca50ab1ad9edfd54745ced07e3f'

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'pkg-config'

  depends_on 'libpo6'
  depends_on 'libe'

  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
