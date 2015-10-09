[![Build Status](https://travis-ci.org/apartmentlist/enumerated_constants.svg?branch=master)](https://travis-ci.org/apartmentlist/enumerated_constants)

# EnumeratedConstants

Emulate the handy enum seen in other programming languages

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enumerated_constants'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enumerated_constants

## Usage

Include `EnumeratedConstants` in a module that defines a set of related constants, e.g.

```
require 'enumerated_constants'

class User
  attr_accessor :role

  module Role
    include EnumeratedConstants

    ADMIN   = 'admin'.freeze
    MANAGER = 'manager'.freeze
    GUEST   = 'guest'.freeze

    PRIVILEGED = [ADMIN, MANAGER].freeze
  end

  def validate_role!
    unless Role.include?(self.role)
      raise "Invalid role, expecting one of #{Role.all.join(', ')}"
    end
  end
end
```

## Available methods

### `all`
Return all constant values in the module that are not `Array`s.

```ruby
User::Role.all
# => ["admin", "manager", "guest"]
```

### `each`
Iterate through each constant value returned by `all`

```ruby
User::Role.each do |role|
  puts role
end
# "admin"
# "manager"
# "guest"
```

### `except`
Return all constants values except for the ones passed in. Note, the arguments should be
the name of the constants, not the constants' value.

```ruby
User::Role.except(:guest)
# => ["admin", "manager"]
```

### `include?`
Return true if the value passed in is a value of one of the constants in the module

```ruby
User::Role.include?('guest')
# => true
User::Role.include?('hacker')
# => false
```

### `map`
Map the values of the module to other values

```ruby
User::Role.map { |role| "#{role} user" }
# => ["admin user", "manager user", "guest user"]
```

### `sample`
Randomly select value(s) from the module

```ruby
User::Role.sample
# => "guest"
User::Role.sample
# => "admin"
User::Role.sample(2)
# => ["manager", "admin"]
```

### `sort`
Return the sorted constant values

```ruby
User::Role.sort
# => ["admin", "guest", "manager"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/enumerated_constants/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
