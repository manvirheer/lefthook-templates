#!/usr/bin/env node
/**
 * Post‑install script:
 * ─ Installs Lefthook git hooks when cloning locally.
 * ─ Skips installation in CI or when no .git directory is present.
 * Works on Windows, macOS, and Linux (Node standard library only).
 */

const { execSync } = require('child_process');
const { existsSync } = require('fs');
const path = require('path');


//--- Helper ---------------------------------------------------------------//

/** Detect whether we are running in Continuous Integration. */
function inCi() {
  return (
    process.env.CI ||                   // most CI systems
    process.env.GITHUB_ACTIONS ||       // GitHub Actions
    process.env.GITLAB_CI ||            // GitLab CI/CD
    process.env.BITBUCKET_BUILD_NUMBER || // Bitbucket Pipelines
    process.env.BUILD_NUMBER            // Jenkins / TeamCity
  );
}

//--- Main -----------------------------------------------------------------//
function getRepoRoot() {
  try {
    // Returns an absolute path with a trailing newline
    const root = execSync('git rev-parse --show-toplevel', { stdio: 'pipe' })
      .toString()
      .trim();
    return root;
  } catch {
    return null; // Not inside a Git repo
  }
}

const projectRoot = getRepoRoot();
if (!projectRoot || !existsSync(path.join(projectRoot, '.git'))) {
  console.log('ℹ️  Lefthook: no Git repository detected – skipping.');
  process.exit(0);
}

// Skip in CI unless explicitly forced _____________________________________//
if (inCi() && !process.env.LEFTHOOK_FORCE) {
  console.log('ℹ️  Lefthook: running inside CI – skipping (set LEFTHOOK_FORCE=1 to override).');
  process.exit(0);
}

// Install hooks ___________________________________________________________//
try {
  // --no silences npx version checks for a cleaner, faster run
  execSync('npx --no lefthook install', {
    stdio: 'inherit',
    cwd:   projectRoot,
  });
  console.log('✅  Lefthook hooks installed.');
} catch (err) {
  console.error('❌  Lefthook installation failed:', err.message);
  process.exit(1);
}