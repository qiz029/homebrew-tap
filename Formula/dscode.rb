class Dscode < Formula
  desc "Terminal coding agent harness: DSH TUI, computer use, skills and telemetry"
  homepage "https://github.com/qiz029/dscode"
  url "https://registry.npmjs.org/@toddzheng024/dscode/-/dscode-0.7.25.tgz"
  sha256 "0ab32204ef3ad010624aeb6d484064ff9564d9312c5f9b6ae41cbce1dbcdba32"
  license "MIT"

  depends_on "node"

  def install
    # The published launcher, so the pinned dependency graph stays npm's rather than the
    # formula's; `std_npm_args` installs it into libexec and links its bin.
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
    # Marks the installation as Homebrew's, so `dscode update` moves only the Hub profile
    # and leaves the launcher to `brew upgrade dscode`. The package is scoped, so its
    # directory is two levels below node_modules.
    launcher = libexec.glob("lib/node_modules/*/*/cli.mjs").first
    odie "the launcher did not install where this formula expects it" if launcher.nil?
    (launcher.dirname/".dscode-brew").write "1\n"
  end

  test do
    # `--version` reads release.json and would pass with no dependencies at all, so
    # assert one resolves, and that the marker the launcher reads is in place.
    system "node", "-e", "require.resolve('@dsh-plugin-hub/cli', { paths: ['#{libexec}'] })"
    assert_path_exists libexec.glob("lib/node_modules/*/*/.dscode-brew").first
    assert_match version.to_s, shell_output("#{bin}/dscode --version")
  end
end
