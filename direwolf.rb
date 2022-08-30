class Direwolf < Formula
  desc "Software modem and TNC for AX.25"
  homepage "https://github.com/wb2osz/direwolf"
  url "https://github.com/wb2osz/direwolf/archive/refs/tags/1.6.tar.gz"
  sha256 "208b0563c9b339cbeb0e1feb52dc18ae38295c40c0009d6381fc4acb68fdf660"
  head "https://github.com/wb2osz/direwolf.git"

  depends_on "hamlib"
  depends_on "portaudio"

  def install
    inreplace "Makefile.macosx", "LDLIBS += -framework CoreAudio",
                                 "LDLIBS += $(EXTRA_LDLIBS) -framework CoreAudio"
    inreplace ["decode_aprs.c", "symbols.c"], "/usr/local", opt_prefix
    system "make -k all EXTRA_CFLAGS=-DUSE_HAMLIB EXTRA_LDLIBS=-lhamlib || true"
    bin.install %w[direwolf aclients decode_aprs gen_fff gen_packets
                   ll2utm log2gpx text2tt tt2text ttcalc utm2ll]
    pkgshare.install "tocalls.txt", "symbols-new.txt"
    man.install "man1"
    doc.install Dir["doc/*"]
  end

  test do
    system "#{bin}/direwolf", "-S"
  end
end
