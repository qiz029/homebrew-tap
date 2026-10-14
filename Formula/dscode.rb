class Dscode < Formula
  desc "Self-contained DSCODE coding agent"
  homepage "https://github.com/qiz029/dscode"
  version "0.7.46"
  license "MIT"
  depends_on :macos

  on_arm do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.46/dscode-0.7.46-darwin-arm64-standalone.tar.gz"
    sha256 "b2303bd311bbaa5b7e44d00a176a47d5947b39014a406e87c324f858920b5bd7"
  end
  on_intel do
    url "https://github.com/qiz029/dscode/releases/download/v0.7.46/dscode-0.7.46-darwin-x64-standalone.tar.gz"
    sha256 "f2e9927809e61200b7ee203baa763371d18d2b8e9a42ee419f0aa5f9ca4c17f3"
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
