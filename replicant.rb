require 'formula'

class Replicant < Formula
  homepage 'http://hyperdex.org/'
  url 'http://hyperdex.org/src/replicant-0.1.2.tar.gz'
  sha1 '9de930aa87321b5537f66745206ffc4e153c20fa'

  depends_on 'autoconf'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'automake'
  depends_on 'seanogden/hyperdex/leveldb'
  depends_on 'seanogden/hyperdex/cityhash'
  depends_on 'popt'
  depends_on 'glog'
  depends_on 'seanogden/hyperdex/busybee'

  def install
    ENV.delete 'LD'
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++"
    leveldb = Formula.factory 'leveldb'
    libe = Formula.factory 'libe'
    libpo6 = Formula.factory 'libpo6'
    busybee = Formula.factory 'busybee'
    system "curl -O https://raw.github.com/rescrv/Replicant/master/memstream.h"
    system "autoreconf -if"
    system "./configure", "--prefix=#{prefix}", "PO6_LIBS=-L#{HOMEBREW_PREFIX}/lib",
            "PO6_CFLAGS=-I#{HOMEBREW_PREFIX}/include", "E_LIBS=\"-L#{HOMEBREW_PREFIX}/lib -le\"",
            "E_CFLAGS=-I#{HOMEBREW_PREFIX}/include", "BUSYBEE_LIBS=\"-L#{HOMEBREW_PREFIX}/lib -lbusybee\"",
            "BUSYBEE_CFLAGS=-I#{HOMEBREW_PREFIX}/include"
    system "make install"
  end
end
