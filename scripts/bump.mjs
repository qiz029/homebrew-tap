import { createHash } from 'node:crypto';
import { writeFileSync } from 'node:fs';

const repository = 'qiz029/dscode';
const headers = { accept: 'application/vnd.github+json', 'user-agent': 'dscode-homebrew' };
if (process.env.GH_TOKEN) headers.authorization = `Bearer ${process.env.GH_TOKEN}`;
const response = await fetch(`https://api.github.com/repos/${repository}/releases/latest`, { headers, signal: AbortSignal.timeout(30000) });
if (!response.ok) throw Error(`Release lookup failed: ${response.status}`);
const release = await response.json();
if (release.draft || release.prerelease || !/^v\d+\.\d+\.\d+$/.test(release.tag_name)) throw Error('Expected a stable release');
const version = release.tag_name.slice(1);
const asset = name => {
  const entry = release.assets.find(item => item.name === name);
  if (!entry || !/^sha256:[a-f0-9]{64}$/.test(entry.digest ?? '')) throw Error(`Missing verified release asset: ${name}`);
  return entry;
};
const formulaAsset = asset('dscode.rb');
const downloaded = await fetch(formulaAsset.browser_download_url, { signal: AbortSignal.timeout(30000) });
if (!downloaded.ok) throw Error(`Formula download failed: ${downloaded.status}`);
const bytes = Buffer.from(await downloaded.arrayBuffer());
if (`sha256:${createHash('sha256').update(bytes).digest('hex')}` !== formulaAsset.digest) throw Error('Formula digest mismatch');
const formula = bytes.toString('utf8');
if (!formula.includes(`version "${version}"`)) throw Error('Formula version mismatch');
for (const arch of ['arm64', 'x64']) {
  const archive = asset(`dscode-${version}-darwin-${arch}-standalone.tar.gz`);
  asset(`${archive.name}.sha256`);
  const expectedUrl = `https://github.com/${repository}/releases/download/${release.tag_name}/${archive.name}`;
  if (archive.browser_download_url !== expectedUrl || !formula.includes(`url "${expectedUrl}"\n    sha256 "${archive.digest.slice(7)}"`)) {
    throw Error(`Formula does not match the ${arch} release archive`);
  }
}
writeFileSync(new URL('../Formula/dscode.rb', import.meta.url), bytes);
console.log(`Formula matches the complete DSCODE ${version} release`);
