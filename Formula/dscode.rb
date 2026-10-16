class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.48"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.48/dscode-0.7.48-darwin-arm64-standalone.tar.gz"
    sha256 "a0be5215c14ca85b25b3d24df5e1c430c712426a14e74f17523b995489c3b659"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.48/dscode-0.7.48-darwin-x64-standalone.tar.gz"
    sha256 "fb5864810ca54f495549041b74fdee2f0e503325adcab6a6baa7aef91cf0ead0"
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
