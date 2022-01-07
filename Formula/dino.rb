class Dino < Formula
  desc "Modern XMPP (\"Jabber\") Chat Client using GTK+/Vala"
  homepage "https://dino.im/"
  url "https://github.com/dino/dino/releases/download/v0.2.2/dino-0.2.2.tar.gz"
  sha256 "3e076f51c65967cfd51cbabf0b7249a7ea36e61afa25f93f82b9348466b2b864"
  license "GPL-3.0-or-later"

  head do
    url "https://github.com/dino/dino.git"
    depends_on "gspell"
    depends_on "gst-plugins-base"
    depends_on "libnice"
    depends_on "srtp"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "vala" => :build
  depends_on "zsh" => :build
  depends_on "adwaita-icon-theme"
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
    system "zsh", "-e", "-x", "-c",
        "for plugin in #{lib}/dino/plugins/*.dylib; do mv ${plugin} ${plugin%.dylib}.so; done"
  end

  test do
    system "true"
  end
end
