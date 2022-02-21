class Dino < Formula
  desc "Modern XMPP (\"Jabber\") Chat Client using GTK+/Vala"
  homepage "https://dino.im/"
  url "https://github.com/dino/dino/releases/download/v0.3.0/dino-0.3.0.tar.gz"
  sha256 "3970cacf53ad328bb848dd19711826797fb8aed510e9fbf7ffac2ad7cb11dc1e"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://github.com/jugendhacker/homebrew-dino/releases/download/dino-0.2.2"
    rebuild 1
    sha256 catalina:     "13238f3caf069829f92629a1f4985a643b6f5eb5c26f5e688f5198b02dd399da"
    sha256 x86_64_linux: "6c55940416f528d3f7be5b9395811e0f7f16a127272a55bd899977b1bf782a20"
  end

  head do
    url "https://github.com/dino/dino.git"
    depends_on "gspell"
    depends_on "gst-plugins-base"
    depends_on "gst-plugins-good"
    depends_on "libnice"
    depends_on "srtp"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "vala" => :build
  depends_on "zsh" => :build if OS.mac?
  depends_on "adwaita-icon-theme"
  depends_on "cairo"
  depends_on "gettext"
  depends_on "glib"
  depends_on "glib-networking"
  depends_on "gpgme"
  depends_on "gtk+3"
  depends_on "icu4c"
  depends_on "libgcrypt"
  depends_on "libgee"
  depends_on "libsignal-protocol-c"
  depends_on "libsoup@2"
  depends_on "libxml2"
  depends_on "qrencode"
  depends_on "sqlite"

  def install
    ENV["VALACFLAGS"] = "--disable-warnings"
    ENV["PREFIX"] = prefix.to_s
    system "./configure", "--with-tests", "--release", "--disable-fast-vapi"
    system "make"
    system "make", "install"
    if OS.mac?
      system "zsh", "-e", "-x", "-c",
          "for plugin in #{lib}/dino/plugins/*.dylib; do mv ${plugin} ${plugin%.dylib}.so; done"
    end
  end

  test do
    system "true"
  end
end
