require 'formula'

class Hyperdex < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/hyperdex-1.4.2.tar.gz'
  sha1 'b0b663910ecee71cb28aba762b092463d97faab9'

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

diff --git a/Makefile.am b/Makefile.am
index ccc79bf..ff0fedf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -289,7 +289,7 @@ hyperdex_daemon_LDADD += $(HYPERLEVELDB_LIBS)
 hyperdex_daemon_LDADD += $(BUSYBEE_LIBS)
 hyperdex_daemon_LDADD += $(E_LIBS)
 hyperdex_daemon_LDADD += $(JSON_LIBS)
-hyperdex_daemon_LDADD += -lpopt -lglog -lrt -lpthread
+hyperdex_daemon_LDADD += -lpopt -lglog -lpthread
 man/hyperdex-daemon.1: man/hyperdex-daemon.1.h2m daemon/main.cc
 	@$(MAKE) --silent $(AM_MAKEFLAGS) hyperdex-daemon$(EXEEXT)
 	$(help2man_verbose)help2man $(HELP2MAN_FLAGS) --section 1 --output $@ --include $< ${abs_top_builddir}/hyperdex-daemon$(EXEEXT)
