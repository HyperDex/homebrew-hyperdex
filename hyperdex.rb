require 'formula'

class Hyperdex < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/hyperdex-1.3.0.tar.gz'
  sha1 'f400a7369b024f2932d810ef78c86bf8b3b383e6'

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'pkg-config'

  depends_on 'popt'
  depends_on 'glog'
  depends_on 'google-sparsehash'
  depends_on 'json-c'
  depends_on 'libpo6'
  depends_on 'libe'
  depends_on 'busybee'
  depends_on 'hyperleveldb'
  depends_on 'replicant'

  option 'with-python-bindings', "Builds and installs Python client bindings"
  option 'with-java-bindings', "Builds and installs Java client bindings"
  option 'with-ruby-bindings', "Builds and installs Ruby client bindings"

  def patches
    DATA
  end

  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    args = []
    args << "--enable-java-bindings" if build.with? "java-bindings"
    args << "--enable-python-bindings" if build.with? "python-bindings"
    args << "--enable-ruby-bindings" if build.with? "ruby-bindings"
    
    system "./configure", "--prefix=#{prefix}", *args
    system "make"
    system "make install"
  end
end
__END__
diff --git a/cityhash/city.cc b/cityhash/city.cc
index 49f299b..e09b659 100644
--- a/cityhash/city.cc
+++ b/cityhash/city.cc
@@ -499,7 +499,7 @@ uint128 CityHash128(const char *s, size_t len) {
       CityHash128WithSeed(s, len, uint128(k0, k1));
 }
 
-#ifdef __SSE4_2__
+#if 0
 #include <citycrc.h>
 #include <nmmintrin.h>
 
