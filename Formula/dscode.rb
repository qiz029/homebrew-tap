class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.54"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.54/dscode-0.7.54-darwin-arm64-standalone.tar.gz"
    sha256 "2e65dbf7b7ae5e8bc457f19699c6758a012d317f491e5ed37ca90cab649a1288"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.54/dscode-0.7.54-darwin-x64-standalone.tar.gz"
    sha256 "c058ec765443abd21a9acb17a4fb3b046cf5d19491a137d3159772616eb6346f"
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
