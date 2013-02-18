require 'formula'

class Libe < Formula
  homepage 'http://hyperdex.org'
  url 'http://hyperdex.org/src/libe-0.3.1.tar.gz'
  sha1 '40754b1a9acdbd8154b5e4e348a74ff2550022bb'

  depends_on 'libpo6'

  def patches
    # fix up build error.
    DATA
  end

  def install
    ENV.delete 'LD'
    ENV['CC']="#{HOMEBREW_PREFIX}/bin/gcc"
    ENV['CXX']="#{HOMEBREW_PREFIX}/bin/g++"
    libpo6 = Formula.factory 'libpo6'
    system "autoreconf -if"
    system "./configure", "--prefix=#{prefix}","PO6_CFLAGS=-I#{HOMEBREW_PREFIX}/include",
           "PO6_LIBS=\"\""
    system "make install"
  end
end
__END__
diff -Naur libe-0.3.1/time.cc libe-0.3.1-fix/time.cc
--- libe-0.3.1/time.cc	2013-02-12 11:06:47.000000000 -0500
+++ libe-0.3.1-fix/time.cc	2013-02-16 21:52:32.000000000 -0500
@@ -69,7 +69,7 @@
     QueryPerformanceFrequency((LARGE_INTEGER*)&tickfreq);
     QueryPerformanceCounter((LARGE_INTEGER*)&timestamp);
     return timestamp.QuadPart / (tickfreq.QuadPart/1000000000.0);
-#elif defined HAVE_MACH_TIMEBASE_INFO
+#elif defined HAVE_MACH_ABSOLUTE_TIME
     mach_timebase_info_data_t info;
     mach_timebase_info(&info);
     return mach_absolute_time()*info.numer/info.denom;

