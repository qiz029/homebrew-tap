class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.49"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.49/dscode-0.7.49-darwin-arm64-standalone.tar.gz"
    sha256 "5d94b68eec4bf38a663ae26636b1e2d91e8f6a9c182ba06e6f6341ce572166b5"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.49/dscode-0.7.49-darwin-x64-standalone.tar.gz"
    sha256 "72171e25585003237e8d99250d91e316fab169af4f24babf798152fecc123259"
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
