require "expand/version"

module Expand
  class Manager
    def initialize(namespace)
      @managed = namespace
    end

    def create_module(name, &block)
      mod = Module.new(&block)
      @managed.const_set(name, mod)
      mod
    end

    def create_class(name, parent: Object, &block)
      klass = Class.new(parent, &block)
      @managed.const_set(name, klass)
      klass
    end
  end

  def namespace(string, &block)
    namespace = string.split('::').inject(Object) do |base, mod|
      base.const_get(mod)
    end
    Manager.new(namespace).instance_eval(&block)
  end
  alias expand namespace
end
