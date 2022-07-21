# Expand

Use Expand to create classes or modules under an existing namespace.

Defining new classes or modules under an existing namespace can be confusing. Using class_eval doesn't work like you think it would.

```ruby
module SomeGem
  class Thing
  end
end

SomeGem::Thing.class_eval do
  class NewThing
  end
end

# Then try to reference it...
SomeGem::Thing::NewThing #=> warning: toplevel constant NewThing referenced by SomeGem::Thing::NewThing
```

To make this simpler, you can require `expand` and extend your current context with Expand.

```ruby
require 'expand'
extend Expand

namespace SomeGem::Thing do
  create_class :NewThing do
    # define methods here
  end
end

SomeGem::Thing::NewThing #=> SomeGem::Thing::NewThing
```

And even simpler, you can do it all in one line:

```ruby
require 'expand'
extend Expand

namespace SomeGem::Thing, class: :NewThing, parent: SomeExistingOtherClass do
  # define methods here
end

namespace SomeGem::Thing, module: :NewModule do
  # define methods here
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'expand'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install expand


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/saturnflyer/expand. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

