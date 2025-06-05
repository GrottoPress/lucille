# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.4.1] - 2025-06-05

### Added
- Add support for Lucky v1.4

### Fixed
- Fix compile error calling `.compare_versions` with `Lucille::VERSION`

## [1.4.0] - 2025-04-19

### Added
- Add support for *Pawn* v2.0

## [1.3.1] - 2024-12-16

### Fixed
- Fix country-prefixed Ghanaian phone numbers failing validation

## [1.3.0] - 2024-12-16

### Added
- Add `Avram::Validations.validate_phone_number`

## [1.2.2] - 2024-12-06

### Fixed
- Fix wrong return type for `FakeNestedParams#many_nested?(String)`

## [1.2.1] - 2024-11-23

### Fixed
- Avoid multiple pattern matching in search criteria

## [1.2.0] - 2024-10-23

### Changed
- Make the raw enum private in `.__enum` macro

### Fixed
- Add support for Lucky v1.3
- Add support for Crystal v1.13
- Add support for Crystal v1.14
- Fix wrong parameter type restriction for `Lucille::HaveErrorExpectation#match`

## [1.1.3] - 2024-07-25

### Fixed
- Fix CI issues with Lucky v1.2
- Check email and domain lengths with `String#bytesize` instead of `String#size`
- Limit length of search queries to mitigate potential DoS

## [1.1.2] - 2024-03-01

### Changed
- Revert failed concurrency bug fix

## [1.1.1] - 2024-02-29

### Fixed
- Fix concurrency bug in `.validate_uniqueness_of` checks

## [1.1.0] - 2023-12-18

### Added
- Add support for Lucky v1.1
- Add support for regex to `#have_error` spec expectations
- Add support for Cockroach DB

### Changed
- Add `luckyframework/avram` shard as an explicit dependency
- Add `luckyframework/lucky` shard as an explicit dependency

## [1.0.1] - 2023-10-27

### Fixed
- Avoid possible bugs with truthiness checks for `Bool` operation attributes

## [1.0.0] - 2023-05-29

### Changed
- Upgrade `GrottoPress/pawn` to v1.0
- Upgrade `GrottoPress/rex` to v1.0

## [0.11.1] - 2023-05-03

### Fixed
- Fix `Lucille::JSON#merge(**)` not overwriting previous values

## [0.11.0] - 2023-05-02

### Removed
- Remove `GrottoPress/hapi` shard

## [0.10.0] - 2023-03-13

### Changed
- Upgrade to support *Lucky* v1.0

## [0.9.0] - 2023-01-06

### Add
- Add `Lucille::UserFromUserId` operation mixin
- Add `Lucille::ValidateUserExists` operation mixin

### Fixed
- Add parameter type restriction to `Lucille::Status#to_s`
- Add parameter type restriction to `Lucille::Status#to_json`

### Removed
- Remove `Lucille::SetUserIdFromUser#user!` method

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
