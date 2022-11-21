# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.8.0] - 2022-11-21

### Changed
- Upgrade to support *Crystal* v1.6
- Remove default remote failure message for `Avram::Validations.validate_not_pwned`

## [0.7.0] - 2022-10-15

### Added
- Add `FakeParams`

### Changed
- Upgrade to support *Lucky* v1.0.0-rc1
- Rename `#to_param_string` spec helper to `#to_param`

### Removed
- Remove `Lucille::ActionHelpers#array_param`

## [0.6.0] - 2022-09-22

### Added
- Add `Lucille::SuccessStatusColumns` model mixin
- Add `Lucille::SuccessStatusQuery` query mixin
- Add `SuccessStatus` domain model
- Add `Lucille::SetUserIdFromUser` operation mixin
- Add `RecordStatus#span?` to return the duration a record spans

### Changed
- Change `RecordStatus#at` return type from `String` to `Symbol`
- Allow setting custom inactive time in `Lucille::Deactivate`

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
