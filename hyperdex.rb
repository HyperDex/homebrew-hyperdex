require 'formula'

class Hyperdex < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/hyperdex-1.1.0.tar.gz'
  sha1 'ebefa890c846053ba7f2e7897b8e023bc40955be'

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'pkg-config'

  depends_on 'popt'
  depends_on 'glog'
  depends_on 'google-sparsehash'
  depends_on 'libpo6'
  depends_on 'libe'
  depends_on 'busybee'
  depends_on 'hyperleveldb'
  depends_on 'replicant'

  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
