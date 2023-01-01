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

To make this simpler, you can require `expand` and specify the namespace and the new class or module.

```ruby
require 'expand'

Expand.namespace SomeGem::Thing, class: :NewThing do
  # define methods for your class here
end

SomeGem::Thing::NewThing #=> SomeGem::Thing::NewThing
```

You can also extend an class or object to add the `namespace` method.

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

If you want more explicit code or to create multiple modules or classes under a sinngle namespace you can use `create_class` and `create_module`

```ruby
require 'expand'
extend Expand

namespace SomeGem::Thing do
  create_class :NewClass do
    # define methods here
  end

  create_module :NewModule do
    # define methods here
  end
end
```

## Gotchas

Unfortunately, due to the scoping of the blocks passed to the main `namespace` or `expand` methods, you are unable to directly reference classes nested in your namespace.

You can, however, pass an argument to the block to use as a reference:

```ruby
namespace SomeGem::Thing do |klass|
  puts klass #=> yields "SomeGem::Thing"
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

