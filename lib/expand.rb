require "expand/version"

# Extend your classes or modules to use the Expand methods
module Expand

  # The primary way to access Manager objects is to use the Expand namespace method.
  # @see Expand#namespace
  #
  class Manager
    # @see Expand#namespace
    def initialize(namespace, **class_or_module, &block)
      @managed = namespace
    end

    # Create a module under the namespace for this object
    # @example
    #   create_module 'Another' do
    #     def do_something
    #     end
    #   end
    #
    # @param name [String, Symbol] name to be used for the module
    # @yield provide a block to be used when creating the module
    #
    # @return [Module] the named module you created
    #
    def create_module(name, &block)
      mod = Module.new(&block)
      @managed.const_set(name, mod)
      mod
    end

    # Create a class under the namespace for this object
    # @example
    #   create_class 'Other' do
    #     def do_something
    #     end
    #   end
    #
    # @param name [String, Symbol] name to be used for the class
    # @param parent [Class] an optional class to be used as the direct ancestor of the class
    # @yield provide a block to be used when creating the class
    #
    # @return [Class] the named class you created
    #
    def create_class(name, parent: Object, &block)
      klass = Class.new(parent, &block)
      @managed.const_set(name, klass)
      klass
    end
  end

  # Allows you to open a module namespace to add constants
  # @example
  #   require 'expand'
  #   extend Expand
  #   namespace SomeGem::Thing do
  #     create_class 'Other' do
  #       # add your class code here
  #     end
  #     create_module 'Another' do
  #       # add your module code here
  #     end
  #   end
  #
  # @param context [Module, String, or any object responding to to_s] representing a module namespace.
  # @yield the provided block is executed against an instance of Expand::Manager using instance_eval
  #
  # @return [Expand::Manager] instance which can allow you to create classes and modules in the given context.
  #
  # @see Expand::Manager#create_class
  # @see Expand::Manager#create_module
  #
  def namespace(context, **class_or_module, &block)
    unless context.is_a?(Module)
      context = context.to_s.split('::').inject(Object) do |base, mod|
        base.const_get(mod)
      end
    end
    manager = Manager.new(context)

    creating_class, creating_module = class_or_module[:class], class_or_module[:module]
    raise ArgumentError, "You must choose either class: or module: but not both." if creating_class && creating_module

    case
    when creating_class
      parent = class_or_module[:parent] || Object
      manager.create_class(creating_class, parent: parent, &block)
    when creating_module
      if class_or_module[:parent]
        warn "An option for :parent was provided as `#{class_or_module[:parent]}' but was ignored when creating the module: #{class_or_module[:module]}"
      end
      manager.create_module(creating_module, &block)
    else
      manager.instance_eval(&block)
    end
  end
  alias expand namespace
end
