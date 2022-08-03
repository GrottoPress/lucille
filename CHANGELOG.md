# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased] - 

### Added
- Add `Lucille::SuccessStatusColumns` model mixin
- Add `Lucille::SuccessStatusQuery` query mixin
- Add `Lucille::SuccessStatus` domain model

### Changed
- Change `RecordStatus#at` return type from `String` to `Symbol`

## [0.5.0] - 2022-06-28

### Added
- Add support for *Lucky* v0.30
- Add `String::Lucky::Criteria#search`

## [0.4.0] - 2022-03-17

### Added
- Ensure support for *Crystal* v1.3
- Add `#have_error` spec expectation that asserts the validity of an attribute
- Add methods to retrieve record status as string

### Removed
- Remove `#assert_valid` and `#assert_invalid` spec helpers
- Remove `Lucille::Serializer.for_collection` method

## [0.3.0] - 2022-01-03

### Added
- Add support for *Lucky* v0.29
- Set up i18n with [*Rex*](https://github.com/GrottoPress/rex)
- Add `Lucille::Serializer` module
- Add `Lucille::JSON#merge` methods

### Fixed
- Fix wrong regular expression for domain labels

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
