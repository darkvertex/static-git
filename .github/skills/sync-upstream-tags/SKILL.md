---
name: sync-upstream-tags
description: Compare local release tags with git/git tags and create+push each missing version tag in ascending order.
---

# Sync Upstream Git Release Tags

Use this skill when you need to synchronize this repository's release tags with upstream Git releases.

## Steps

1. Identify the latest local semantic version tag (`X.Y.Z`) in this repository.
2. Fetch upstream release tags from `https://github.com/git/git/tags`.
3. Compute missing semantic version tags not present locally.
4. Process missing tags in ascending version order (oldest to newest).
5. For each missing tag, run:
   - `git tag <version>`
   - `git push origin <version>`
6. Stop immediately if any command fails, and report which tag failed.

## Run

```bash
bash .github/skills/sync-upstream-tags/scripts/sync-upstream-tags.sh
```

## Verify

- [ ] Missing tags were handled from oldest to newest
- [ ] Every created tag was pushed individually
- [ ] No non-semver tags were created
