class Dscode < Formula
  desc "Terminal coding agent harness: DSH TUI, computer use, skills and telemetry"
  homepage "https://github.com/qiz029/dscode"
  url "https://registry.npmjs.org/@toddzheng024/dscode/-/dscode-0.7.24.tgz"
  sha256 "68945a15e55f611d18edceadcded7acfa050ee10ff69d16dc4469b14945718b6"
  license "MIT"

  depends_on "node"

  def install
    # The published launcher, so the pinned dependency graph stays npm's rather than the
    # formula's; `std_npm_args` installs it into libexec and links its bin.
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
    # Marks the installation as Homebrew's: `dscode update` then moves only the Hub
    # profile and leaves the launcher to `brew upgrade dscode`.
    (libexec.glob("lib/node_modules/*/cli.mjs").first.dirname/".dscode-brew").write "1\n"
  end

  test do
    # `--version` reads release.json and would pass with no dependencies at all, so
    # assert one resolves, and that the marker the launcher reads is in place.
    system "node", "-e", "require.resolve('@dsh-plugin-hub/cli', { paths: ['#{libexec}'] })"
    assert_path_exists libexec.glob("lib/node_modules/*/.dscode-brew").first
    assert_match version.to_s, shell_output("#{bin}/dscode --version")
  end
end
