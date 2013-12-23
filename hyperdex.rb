require 'formula'

class Hyperdex < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/hyperdex-1.0.1.tar.gz'
  version '1.0.1'
  sha1 'c8233c0de6b7b41d79f7c3d9a2633a5f754ec989'

  depends_on 'replicant'
  depends_on 'hyperleveldb'
  depends_on 'python'
  depends_on 'ruby'

  def install
    ENV.delete 'LD'
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc-4.9"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++-4.9"
#    hyperleveldb = Formula.factory 'hyperleveldb'
#    cityhash = Formula.factory 'cityhash'
#    libe = Formula.factory 'libe'
#    libpo6 = Formula.factory 'libpo6'
#    busybee = Formula.factory 'busybee'
#    replicant = Formula.factory 'replicant'

    system "./configure", "--enable-python-bindings", "--enable-ruby-bindings", "--prefix=#{prefix}", "PO6_LIBS=-L#{HOMEBREW_PREFIX}/lib",
            "PO6_CFLAGS=-I#{HOMEBREW_PREFIX}/include", "E_LIBS=\"-L#{HOMEBREW_PREFIX}/lib -le\"",
            "E_CFLAGS=-I#{HOMEBREW_PREFIX}/include", "BUSYBEE_LIBS=\"-L#{HOMEBREW_PREFIX}/lib -lbusybee\"",
            "BUSYBEE_CFLAGS=-I#{HOMEBREW_PREFIX}/include", "REPLICANT_LIBS=\"-L#{HOMEBREW_PREFIX}/lib -lreplicant\"",
            "REPLICANT_CFLAGS=-I#{HOMEBREW_PREFIX}/include"
            #, "CC=/usr/local/bin/gcc", "CXX=/usr/local/bin/g++"
    system "make install"
  end
end
