# DSCODE tap

Homebrew 7 refuses to load a formula from a third-party tap until you trust it, so the
first install is three commands:

```sh
brew tap qiz029/tap
brew trust qiz029/tap
brew install dscode
```

The formula installs the self-contained application for Apple Silicon or Intel into
`libexec` and links only `dscode`. Node, Harness and native dependencies are included;
no separate Node/npm installation or Hub profile is needed. An existing `dsh`
installation is not used or replaced. User data defaults to
`~/.local/share/dscode-state`, outside the Homebrew Cellar.

Exit running DSCODE sessions and use `brew upgrade dscode` to replace the complete
application. `dscode update` points Homebrew installations to that command.
Older npm/Hub data requires explicit migration; see the
[distribution guide](https://github.com/qiz029/dscode/blob/main/docs/distribution.md).

`.github/workflows/bump.yml` runs daily and on demand. It downloads the formula from
the latest GitHub release, verifies its digest and checks that both archive URLs and
checksums match the release metadata before committing an update. A missing or
incomplete standalone release leaves the existing formula in place.
