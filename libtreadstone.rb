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

  def patches
    DATA
  end
  
  def install
    ENV['PKG_CONFIG_PATH']="#{HOMEBREW_PREFIX}/lib/pkgconfig"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
__END__
diff --git a/treadstone.cc b/treadstone.cc
index f4f651b..cf2b884 100644
--- a/treadstone.cc
+++ b/treadstone.cc
@@ -1805,7 +1805,7 @@ treadstone_transformer :: parse_array(const treadstone::pa
     {
         const unsigned char* const elem_start = tmp;
         const unsigned char* elem_tmp = NULL;
-        size_t elem_sz;
+        uint64_t elem_sz;

         switch (*elem_start)
         {