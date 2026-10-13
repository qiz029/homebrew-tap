class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.41"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.41/dscode-0.7.41-darwin-arm64-standalone.tar.gz"
    sha256 "483d83b2ec3e717b3cf3ec39d6b058772e8be56f34b863838407d31cd0e3f4a7"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.41/dscode-0.7.41-darwin-x64-standalone.tar.gz"
    sha256 "fff4cb9fa8e853d914c8116d2c7c0d5cdbb4b1c63e09ae70fe5e31ac01960dd0"
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
