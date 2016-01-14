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

  def namespace(context, &block)
    unless context.is_a?(Module)
      context = context.to_s.split('::').inject(Object) do |base, mod|
        base.const_get(mod)
      end
    end
    Manager.new(context).instance_eval(&block)
  end
  alias expand namespace
end
