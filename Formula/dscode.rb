class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.47"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.47/dscode-0.7.47-darwin-arm64-standalone.tar.gz"
    sha256 "0e24fcf6d557ef5dee1cdcfe6d27490a2fa5480ac40a8577a625c8ae1799d301"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.47/dscode-0.7.47-darwin-x64-standalone.tar.gz"
    sha256 "c23ab80feb9947c27f460d4dac0586ee6749832778670816fc94af4a49f3a4cc"
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
