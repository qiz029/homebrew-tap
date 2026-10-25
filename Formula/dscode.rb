class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.51"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.51/dscode-0.7.51-darwin-arm64-standalone.tar.gz"
    sha256 "f34688a2d6b4b1f944c1fc0ee67734e7bd1b29afc43b970f69b3e8f93585c920"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.51/dscode-0.7.51-darwin-x64-standalone.tar.gz"
    sha256 "9bd29da5fd1534c71b62f3044cddc99918945bf8526646fee8d7b66295c22ca1"
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
