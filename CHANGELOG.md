# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased] - 

## Added
- Add support for *Lucky* v0.29
- Set up i18n with [*Rex*](https://github.com/GrottoPress/rex)
- Add `Lucille::Serializer` module
- Add `Lucille::JSON#merge` methods

### Removed
- Drop support for *Lucky* v0.28

## [0.2.0] - 2021-11-22

### Added
- Add support for *Crystal* v1.2
- Add status columns (`active_at`, `inactive_at`)
- Add `Lucille::JSON`
- Add `Lucille::ActionHelpers`

### Changed
- Rename `Avram::Validations.validate_primary_key` to `.validate_foreign_key`

## [0.1.0] - 2021-08-27

### Added
- Initial public release
