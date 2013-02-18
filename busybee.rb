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
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc-4.7"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++-4.7"
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
index ede42bf..8f2f0ff 100644
--- a/busybee.cc
+++ b/busybee.cc
@@ -520,13 +520,15 @@ void
 CLASSNAME :: add_signals()
 {
 #ifdef HAVE_KQUEUE
-    struct kevent ee[3];
+    struct kevent ee[5];
     memset(&ee, 0, sizeof(ee));
     EV_SET(&ee[0], SIGTERM, EVFILT_SIGNAL, EV_ADD | EV_CLEAR, 0, 0, NULL);
-    EV_SET(&ee[1], SIGQUIT, EVFILT_SIGNAL, EV_ADD | EV_CLEAR, 0, 0, NULL);
+    EV_SET(&ee[1], SIGHUP, EVFILT_SIGNAL, EV_ADD | EV_CLEAR, 0, 0, NULL);
     EV_SET(&ee[2], SIGINT, EVFILT_SIGNAL, EV_ADD | EV_CLEAR, 0, 0, NULL);
+    EV_SET(&ee[3], SIGALRM, EVFILT_SIGNAL, EV_ADD | EV_CLEAR, 0, 0, NULL);
+    EV_SET(&ee[4], SIGUSR1, EVFILT_SIGNAL, EV_ADD | EV_CLEAR, 0, 0, NULL);
 
-    if(kevent(m_epoll.get(), ee, 3, NULL, 0, NULL) < 0)
+    if(kevent(m_epoll.get(), ee, 5, NULL, 0, NULL) < 0)
     {
         throw po6::error(errno);
     }
@@ -1712,24 +1714,42 @@ CLASSNAME :: wait_event(int* fd, uint32_t* events)
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
-        to.tv_nsec = m_timeout * 1000;
+    {
+        to.tv_sec = m_timeout / 1000;
+        to.tv_nsec = (m_timeout % 1000) * 1000000;
+        ret = kevent(m_epoll.get(), NULL, 0, &ee, 1, &to);
+    }
 
-    int ret = kevent(m_epoll.get(), NULL, 0, &ee, 1, &to);
     *fd = ee.ident;
 
-    switch(ee.filter)
+    if (ret > 0)
     {
-        case EVFILT_READ:
-            *events = EPOLLIN;
-            break;
-        case EVFILT_WRITE:
-            *events = EPOLLOUT;
-            break;
-        default:
-            *events = EPOLLERR;
+        switch(ee.filter)
+        {
+            case EVFILT_READ:
+                *events = EPOLLIN;
+                break;
+            case EVFILT_WRITE:
+                *events = EPOLLOUT;
+                break;
+            case EVFILT_SIGNAL:
+                sigset_t origmask;
+                sigprocmask(SIG_SETMASK, &m_sigmask, &origmask);
+                kill(getpid(), ee.ident); 
+                sigprocmask(SIG_SETMASK, &origmask, NULL);
+                ret = -1;
+                errno = EINTR;
+                break;
+            default:
+                *events = EPOLLERR;
+        }
     }
 
     return ret;
