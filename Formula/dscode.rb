class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.50"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.50/dscode-0.7.50-darwin-arm64-standalone.tar.gz"
    sha256 "58cbcd11a2da38fff6cc8cb392398ad35c94bac8b3415e2af898063a1afd1931"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.50/dscode-0.7.50-darwin-x64-standalone.tar.gz"
    sha256 "be371baff65553006e4bbadf30ff3a7682e08e9af067ddc3444e2f3f6f12bae1"
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
