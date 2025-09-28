# Lefthook Templates

This repository contains templates and configurations for [Lefthook](https://github.com/evilmartians/lefthook) - a fast and powerful Git hooks manager.

## About

Lefthook is a Git hooks manager that allows you to manage Git hooks with ease. This repository provides reusable templates and configurations for common development workflows.

## Templates

### Complete Lefthook Setup

A comprehensive Lefthook configuration with installation script and validation hooks.

**Includes:**
- `lefthook.yml` - Main configuration with commit-msg and pre-push hooks
- `.lefthook/lefthook-installation.js` - Automatic installation script
- `.lefthook/commit-msg/validate-message.sh` - Commit format validation
- `.lefthook/commit-msg/no-merge-commit.sh` - Merge commit prevention

**Features:**
- Cross-platform compatible (Windows, macOS, Linux)
- Intelligent CI detection and skipping
- Custom commit message format validation
- Pre-push checks with build validation
- Colorized output

**Setup:**

1. Copy the entire `.lefthook/` directory and `lefthook.yml` to your project
2. Add to your `package.json`:
   ```json
   {
     "scripts": {
       "postinstall": "node ./.lefthook/lefthook-installation.js"
     },
     "devDependencies": {
       "lefthook": "^1.11.13"
     }
   }
   ```
3. Make scripts executable: `chmod +x .lefthook/commit-msg/*.sh`
4. Install dependencies: `yarn install`

**Customization:**
- Modify commit types in `validate-message.sh`
- Adjust build commands in `lefthook.yml` for your project
- Update CI detection in `lefthook-installation.js`

## Usage

Browse the templates above and copy the ones that fit your project needs. Each template is designed to be easily customizable and well-documented.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.