class Dscode < Formula
  desc "Terminal coding agent harness: DSH TUI, computer use, skills and telemetry"
  homepage "https://github.com/qiz029/dscode"
  url "https://registry.npmjs.org/@toddzheng024/dscode/-/dscode-0.7.28.tgz"
  sha256 "3ac42e89479b02ab9450694510921ca69d68a04e6d0025ac437ce68d68058035"
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
    # assert one resolves the way the launcher does — from inside the package, because a
    # global npm install nests the dependencies under it — and that the marker is in place.
    system "node", "-e", "require.resolve('@dsh-plugin-hub/cli', { paths: ['#{libexec}/lib/node_modules/@toddzheng024/dscode'] })"
    assert_path_exists libexec.glob("lib/node_modules/*/*/.dscode-brew").first
    assert_match version.to_s, shell_output("#{bin}/dscode --version")
  end
end
