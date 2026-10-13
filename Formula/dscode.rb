class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.42"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.42/dscode-0.7.42-darwin-arm64-standalone.tar.gz"
    sha256 "1a55251397256b3fea62989b8552b88cabccddd50b956134c4ecbc67854033fe"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.42/dscode-0.7.42-darwin-x64-standalone.tar.gz"
    sha256 "f56284aca5fb6f2c8204732341480148b58c517a78586c7cc3770dde41e0edfb"
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
