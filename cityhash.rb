require 'formula'

class Cityhash < Formula
  homepage 'http://code.google.com/p/cityhash/'
  url 'http://cityhash.googlecode.com/files/cityhash-1.0.1.tar.gz'
  sha1 '850c68afb47b3743e7884809cf67b98f9a6db876'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
