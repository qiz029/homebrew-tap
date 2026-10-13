class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.44"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.44/dscode-0.7.44-darwin-arm64-standalone.tar.gz"
    sha256 "5f3dbee82994126bce6706a971dc22bbc86b3114d73f60f26c862a8185a8453f"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.44/dscode-0.7.44-darwin-x64-standalone.tar.gz"
    sha256 "c504e38d065d8285f159f9d434f9198ee85f2ce00005316836d6c493ecf8311b"
  end

  def install
    libexec.install Dir["*", ".dscode-standalone.json"]
    (libexec/".dscode-brew").write "Homebrew owns this application package.\n"
    bin.install_symlink libexec/"dscode"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dscode --version")
    assert_match "native modules OK", shell_output("#{bin}/dscode --check")
  end
end
