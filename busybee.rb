require 'formula'

class Busybee < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/busybee-0.4.1.tar.gz'
  sha1 'ea88c66a121600b4d3ddd68a4d3f71d1f3465d2f'

  keg_only "dependency of HyperDex"

  depends_on 'libpo6'
  depends_on 'libe'

  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
