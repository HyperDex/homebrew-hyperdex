require 'formula'

class Busybee < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/busybee-0.2.3.tar.gz'
  sha1 'b2ed06321cbbe77dbdcecbb1b77e0325d390a913'

  depends_on 'autoconf'
  depends_on 'autoconf-archive'
  depends_on 'libtool'
  depends_on 'automake'
  depends_on 'libe'

  def patches
    DATA
  end

  def install
    ENV.delete 'LD'
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++"
    libe = Formula.factory 'libe'
    libpo6 = Formula.factory 'libpo6'
    system "autoreconf -if"
    system "./configure", "--prefix=#{prefix}", "PO6_LIBS=-L#{libpo6.prefix}/lib",
            "PO6_CFLAGS=-I#{libpo6.prefix}/include", "E_LIBS=\"-L#{libe.prefix}/lib -le\"",
            "E_CFLAGS=-I#{libe.prefix}/include"
    system "make install"
  end
end
__END__
diff --git a/busybee.cc b/busybee.cc
index ede42bf..3f83337 100644
--- a/busybee.cc
+++ b/busybee.cc
@@ -1712,12 +1712,18 @@ CLASSNAME :: wait_event(int* fd, uint32_t* events)
 {
     struct kevent ee;
     struct timespec to = {0,0}; 
+    int ret;
+
     if (m_timeout < 0) 
-        to.tv_nsec = 50000;
+    {
+        ret = kevent(m_epoll.get(), NULL, 0, &ee, 1, NULL);
+    }
     else
+    {
         to.tv_nsec = m_timeout * 1000;
+        ret = kevent(m_epoll.get(), NULL, 0, &ee, 1, &to);
+    }
 
-    int ret = kevent(m_epoll.get(), NULL, 0, &ee, 1, &to);
     *fd = ee.ident;
 
     switch(ee.filter)
