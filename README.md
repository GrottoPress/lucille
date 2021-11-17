# Lucille

**Lucille** is a collection of utilities for *Lucky* framework. It includes many custom validations for *Avram* operations, and several helper types and methods for use in app development and specs.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     lucille:
       github: GrottoPress/lucille
   ```

1. Run `shards update`

1. Require *Lucille* in your app:

   ```crystal
   # ...

   require "lucille"
   # <= Or you may require only the components you need:
   # <= `require "lucille/avram"`
   # <= `require "lucille/carbon"`
   # <= `require "lucille/lucky"`

   # For specs:
   #
   #   require "lucille/spec"
   #
   #   Or require only the components you need:
   #
   #     require "lucille/spec/avram"
   #     require "lucille/spec/carbon"
   #     require "lucille/spec/lucky"

   # ...
   ```

## Utilities

### Avram

- #### Macros

  - `__enum`: Creates an *Avram* adapter that saves enums to the database as `String`

- #### Validations

  - `.validate_email`
  - `.validate_domain`
  - `.validate_domain_label`
  - `.validate_foreign_key`
  - `.validate_http_url`
  - `.validate_ip`
  - `.validate_ip4`
  - `.validate_ip6`
  - `.validate_name`
  - `.validate_negative_number`
  - `.validate_not_pwned`
  - `.validate_positive_number`
  - `.validate_slug`
  - `.validate_url`
  - `.validate_username`

- #### Models (Data)

  - `Lucille::JSON`
  - `Lucille::StatusColumns`

- #### Models (Domain)

  - `RecordStatus`

- #### Operations

  - `Lucille::Activate`
  - `Lucille::Deactivate`
  - `Lucille::ValidateStatus`

- #### Queries

  - `Lucille::StatusQuery`

### Carbon

- #### Mixins

  - `MailHelpers`: Includes helpers for working with *Carbon* mails

### Lucky

- #### Annotations

  - `Memoize`: Invokes *Lucky*'s `.memoize` macro

### Spec

- #### Avram

  - `#assert_invalid`: Asserts that a given attribute is invalid
  - `#assert_valid`: Asserts that a given attribute is valid
  - `#nested_params`: Creates nested params
  - `#params`: Creates params

- #### Carbon

  - `DevDeliverLaterStrategy`: Delivers mail immediately, in the current fiber.

## Development

Create a `.env.sh` file:

```bash
#!/bin/bash

export DATABASE_URL='postgres://postgres:password@localhost:5432/lucille_spec'
```

Update the file with your own details. Then run tests with `source .env.sh && crystal spec`.

## Contributing

1. [Fork it](https://github.com/GrottoPress/lucille/fork)
1. Switch to the `master` branch: `git checkout master`
1. Create your feature branch: `git checkout -b my-new-feature`
1. Make your changes, updating changelog and documentation as appropriate.
1. Commit your changes: `git commit`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a new *Pull Request* against the `GrottoPress:master` branch.
