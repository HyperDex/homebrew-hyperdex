require 'formula'

class Hyperdex < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/hyperdex-1.0.rc3.tar.gz'
  version '1.0.rc3'
  sha1 '523e496f5d563b2dcb1fbdb6fd3124c925334267'

  depends_on 'replicant'
  depends_on 'leveldb'
  depends_on 'python'
  depends_on 'ruby'

  def patches
      DATA
  end

  def install
    ENV.delete 'LD'
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc-4.7"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++-4.7"
#    leveldb = Formula.factory 'leveldb'
#    cityhash = Formula.factory 'cityhash'
#    libe = Formula.factory 'libe'
#    libpo6 = Formula.factory 'libpo6'
#    busybee = Formula.factory 'busybee'
#    replicant = Formula.factory 'replicant'

    system "mkdir osx"
    system "curl -O https://raw.github.com/rescrv/HyperDex/master/osx/ieee754.h --output osx/ieee754.h"
    system "curl -O https://raw.github.com/rescrv/HyperDex/3cb4e2a038d963ca7352ce3498e046ee32604754/client/ruby/type_conversion.h"
    system "mv type_conversion.h client/ruby/type_conversion.h"
    system "./configure", "--enable-python-bindings", "--enable-ruby-bindings", "--prefix=#{prefix}", "PO6_LIBS=-L#{HOMEBREW_PREFIX}/lib",
            "PO6_CFLAGS=-I#{HOMEBREW_PREFIX}/include", "E_LIBS=\"-L#{HOMEBREW_PREFIX}/lib -le\"",
            "E_CFLAGS=-I#{HOMEBREW_PREFIX}/include", "BUSYBEE_LIBS=\"-L#{HOMEBREW_PREFIX}/lib -lbusybee\"",
            "BUSYBEE_CFLAGS=-I#{HOMEBREW_PREFIX}/include", "REPLICANT_LIBS=\"-L#{HOMEBREW_PREFIX}/lib -lreplicant\"",
            "REPLICANT_CFLAGS=-I#{HOMEBREW_PREFIX}/include"
            #, "CC=/usr/local/bin/gcc", "CXX=/usr/local/bin/g++"
    system "make install"
  end
end
__END__
diff --git a/Makefile.am b/Makefile.am
index c4341df..d9a4855 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -41,7 +41,9 @@ EXTRA_DIST = \
 			hyperclient/nodejs/sync_test.js \
 			hyperclient/nodejs/async_test.js \
 			hyperclient/nodejs/hyperclient.cc \
-			wscript
+			wscript \
+			windows/hyperclientclr.cpp \
+			windows/marshal.cpp
 
 lib_LTLIBRARIES = libhyperclient.la
 
@@ -172,8 +174,13 @@ noinst_HEADERS = \
 			client/tool_wrapper.h \
 			client/util.h \
 			client/wrap.h \
+			osx/ieee754.h \
 			test/common.h \
-			tools/common.h
+			tools/common.h \
+			windows/hyperclientclr.h  \
+			windows/ieee754.h \
+			windows/marshal.h \
+			windows/unistd.h
 
 ################################################################################
 #################################### Daemon ####################################
diff --git a/daemon/communication.cc b/daemon/communication.cc
index 42762c4..5e9a3c2 100644
--- a/daemon/communication.cc
+++ b/daemon/communication.cc
@@ -515,6 +515,9 @@ communication :: handle_disruption(uint64_t id)
     if (m_daemon->m_config.get_address(server_id(id)) != po6::net::location())
     {
         m_daemon->m_coord.report_tcp_disconnect(server_id(id));
-        m_daemon->m_stm.retransmit(server_id(id));
+        // XXX If the above line changes, then we need to sometimes tell
+        // the transfer manager to resend all that is unacked  Right now, it
+        // will cause a deadlock.
+        // m_daemon->m_stm.retransmit(server_id(id));
     }
 }
