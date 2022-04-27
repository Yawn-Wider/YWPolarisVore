# Contributing to Yawn-Wider

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

The following is a set of guidelines for contributing to Yawn-Wider, which is hosted in the [Yawn-Wider](https://github.com/Yawn-Wider/YWPolarisVore) on GitHub.
These are just guidelines, not rules, use your best judgment and feel free to propose changes to this document in a pull request.

#### Table Of Contents

[What should I know before I get started?](#what-should-i-know-before-i-get-started)
  * [Code of Conduct](#code-of-conduct)

[How Can I Contribute?](#how-can-i-contribute)
  * [Your First Code Contribution](#your-first-code-contribution)
  * [Yawn-Wider Coding Standards](#Yawn-Wider-coding-standards)
  * [Pull Requests](#pull-requests)
  * [Git Commit Messages](#git-commit-messages)

[Licensing](#Licensing)


## What should I know before I get started?

### Code of Conduct

This project adheres to the Contributor Covenant [code of conduct](code_of_conduct.md).
By participating, you are expected to uphold this code.

## How Can I Contribute?

### Your First Code Contribution

Unsure where to begin contributing to Yawn-Wider? You can start by looking through the issues tab.

### Yawn-Wider Coding Standards

Any code submissions that do not meet our coding standards are likely to be rejected, or at the very least, have a maintainer request changes on your PR. Save time and follow these standards from the start.

* If it is something like a bugfix that VoreStation or Polaris would want (the codebases we use), you may want to consider coding it there as well. They may want any general gameplay bugfixes, and things that are obviously intended to work one way, but do not. They do not have any of our fluff species (greys, geneshadekin) so do not make PRs related to that, or any vore content to them.
* Change whitespace as little as possible. Do not randomly add/remove whitespace.
* Never edit stock Polaris or Vore .DMI files. If you are confused about which .DMI files we have added and which were there originally, refer to their repository and and see if they exist (https://github.com/PolarisSS13/Polaris) (https://github.com/VOREStation/VOREStation). All PRs with edits to stock .DMI files might be rejected.
* When changing any code in any stock Polaris .DM file, you must mark your changes:
    * For single-line changes: // YW Edit - "Explanation" (Edit can also be Add for new lines or Removal if you are commenting the line out)
    * For multi-line additions: // YW Edit - "Explanation" and then at the bottom of your changes, // YW Edit End
    * For multi-line removals: Use a block comment (/\* xxx \*/) to comment out the existing code block (do not modify whitespace more than necessary) and at the start, it should contain /\* YW Removal - "Reason"
* Change whitespace as little as possible. Do not randomly add/remove whitespace.
* Any new files should have "_yw" at the end. For example, "life_yw.dm". Just make them in the same location as the file they are related to.
* Map changes must be in tgm format. See the [Mapmerge2 Readme] for details, or use [StrongDMM] which can automatically save maps as tgm.

### Pull Requests

* Your submission must pass CI checking. The checks are important, prevent many common mistakes, and even experienced coders get caught by it sometimes. If you think there is a bug in CI, open an issue. (One known CI issue is comments in the middle of multi-line lists, just don't do it)
* Your PR should not have an excessive number of commits unless it is a large project or includes many separate remote commits (such as a pull from Polaris). If you need to keep tweaking your PR to pass CI or to satisfy a maintainer's requests and are making many commits, you should squash them in the end and update your PR accordingly so these commits don't clog up the history.
* You can create a WIP PR, and if so, please mark it with [WIP] in the title **and make it a draft pr** so it can be labeled appropriately. These can't sit forever, though.
* If your pull request has many no-conflict merge commits ('merge from master' into your PR branch), it cannot be merged. Squash and make a new PR/forcepush to your PR branch.

### Git Commit Messages

* Limit the first line to 72 characters or less, otherwise it truncates the title with '...', wrapping the rest into the description.
* Reference issues and pull requests liberally.
* Use the GitHub magic words "Fixed/Fixes/Fix, Resolved/Resolves/Resolve, Closed/Closes/Close", as in, "Closes #1928", as this will automatically close that issue when the PR is merged if it is a fix for that issue.

## Licensing
Yawn-Wider is licensed under the GNU Affero General Public License version 3, which can be found in full in LICENSE-AGPL3.txt.

Commits with a git authorship date prior to `1420675200 +0000` (2015/01/08 00:00) are licensed under the GNU General Public License version 3, which can be found in full in LICENSE-GPL3.txt.

All commits whose authorship dates are not prior to `1420675200 +0000` are assumed to be licensed under AGPL v3, if you wish to license under GPL v3 please make this clear in the commit message and any added files.

[Mapmerge2 Readme]: ../tools/mapmerge2/mapmerge tool readme.md
[StrongDMM]: ../tools/StrongDMM/README.md