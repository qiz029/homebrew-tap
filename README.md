# DSCODE tap

```sh
brew tap qiz029/tap
brew install dscode
```

The formula installs the launcher published to npm (`@toddzheng024/dscode`) into its
`libexec` and links `dscode`. On a Homebrew installation `dscode update` moves only the
Hub profile; `brew upgrade dscode` owns the launcher itself.

`.github/workflows/bump.yml` follows the released launcher on its own: it runs daily and
on demand, reads the npm version, recomputes the tarball's sha256 and commits the change.
