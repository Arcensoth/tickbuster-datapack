# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- Start using a new changelog format
- Scrapped SMF support in favor of IMP
### Fixed
- Fixed log spam, hopefully once and for all (see #1)

## [0.0.7] - 2019-07-11
### Added
- Add third dummy criteria to help counter log spam

## [0.0.6] - 2018-11-21
### Added
- Add config triggers and revise sync mechanism
- Implement API to enter and break the sub-tick loop
    - The sub-tick loop will run if at least one vote is present
    - The sub-tick loop will break when all votes are removed
### Changed
- Reorganize and clarify internal structure

## [0.0.5] - 2018-09-03
### Added
- Define missing hooks

## [0.0.4] - 2018-09-03
### Added
- Optimize host-selection by choosing an arbitrary player
### Changed
- Reduce default target tick time from 40 down to 20
### Removed
- Export benchmarking utilities to a separate pack

## [0.0.3] - 2018-09-03
### Added
- Implement benchmarking utilities
- Allow overclocking target tick time

## [0.0.2] - 2018-08-19
### Changed
- Update to SMF v0.10.0
- Overhaul readme

## [0.0.1] - 2018-08-09
### Added
- First release, using SMF v0.8.0

[Unreleased]: https://github.com/Arcensoth/tickbuster-datapack/compare/v0.0.7...HEAD
[0.0.7]: https://github.com/Arcensoth/tickbuster-datapack/compare/v0.0.6...v0.0.7
[0.0.6]: https://github.com/Arcensoth/tickbuster-datapack/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/Arcensoth/tickbuster-datapack/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/Arcensoth/tickbuster-datapack/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/Arcensoth/tickbuster-datapack/compare/v0.0.2...v0.0.3
[0.0.2]: https://github.com/Arcensoth/tickbuster-datapack/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/Arcensoth/tickbuster-datapack/releases/tag/v0.0.1
