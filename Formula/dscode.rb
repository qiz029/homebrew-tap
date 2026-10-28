class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.52"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.52/dscode-0.7.52-darwin-arm64-standalone.tar.gz"
    sha256 "b79a0a158fe0fdf03da75ec611a7e37375da216c1cf53fa2ade1db0f5fec7079"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.52/dscode-0.7.52-darwin-x64-standalone.tar.gz"
    sha256 "e9aae9af7d91586641f7e74916bfb53058e90a21f620ccbae9d1f6fa34455062"
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
