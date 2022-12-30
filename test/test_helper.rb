require "simplecov"
require "minitest/autorun"

SimpleCov.start do
  add_filter "test"
  add_filter "expand/version"
end

require "expand"
