#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_REPO_URL="https://github.com/git/git.git"
SEMVER_PATTERN='^[0-9]+\.[0-9]+\.[0-9]+$'

mapfile -t local_tags < <(git tag --list | grep -E "$SEMVER_PATTERN" | sort -V || true)
mapfile -t upstream_tags < <(
  git ls-remote --tags --refs "$UPSTREAM_REPO_URL" \
    | awk '{print $2}' \
    | sed 's#refs/tags/##' \
    | sed 's/^v//' \
    | grep -E "$SEMVER_PATTERN" \
    | sort -uV
)

latest_local_tag=""
if ((${#local_tags[@]} > 0)); then
  latest_local_tag="${local_tags[-1]}"
fi

printf 'Latest local semver tag: %s\n' "${latest_local_tag:-<none>}"

declare -A local_tag_lookup=()
for tag in "${local_tags[@]}"; do
  local_tag_lookup["$tag"]=1
done

missing_tags=()
for tag in "${upstream_tags[@]}"; do
  if [[ -z "${local_tag_lookup[$tag]:-}" ]]; then
    missing_tags+=("$tag")
  fi
done

if ((${#missing_tags[@]} == 0)); then
  echo "No missing upstream semver tags found."
  exit 0
fi

printf 'Missing tags to create/push (%d): %s\n' "${#missing_tags[@]}" "${missing_tags[*]}"

for tag in "${missing_tags[@]}"; do
  echo "Creating tag: $tag"
  git tag "$tag"

  echo "Pushing tag: $tag"
  git push origin "$tag"
done

echo "Tag synchronization complete."
