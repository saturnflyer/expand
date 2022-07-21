require 'test_helper'

class Base
  class SubClass
  end

  module SubModule
  end
end

module Basis
  class SubClass
  end

  module SubModule
  end
end

extend Expand

namespace Base::SubClass do
  create_class :New do
    def test
      'New class created!'
    end
  end

  create_module :Mod do
    def test
      'Mod module created!'
    end
  end
end
namespace 'Base::SubModule' do
  create_class :New do
    def test
      'New class created!'
    end
  end

  create_module :Mod do
    def test
      'Mod module created!'
    end
  end
end
namespace 'Basis::SubClass' do
  create_class :New do
    def test
      'New class created!'
    end
  end

  create_module :Mod do
    def test
      'Mod module created!'
    end
  end
end
namespace 'Basis::SubModule' do
  create_class :New do
    def test
      'New class created!'
    end
  end

  create_module :Mod do
    def test
      'Mod module created!'
    end
  end
end

describe Expand do
  include Expand
  it 'adds a class in a class/class structure' do
    _(::Base::SubClass.const_get('New')).must_be_kind_of Class
    _(::Base::SubClass::New.new.test).must_equal('New class created!')
  end
  it 'adds a module in a class/class structure' do
    _(::Base::SubClass.const_get('Mod')).wont_be_kind_of Class
    _(::Base::SubClass.const_get('Mod')).must_be_kind_of Module
    _(::Base::SubClass::Mod.instance_method(:test).bind(self).call).must_equal('Mod module created!')
  end
  it 'adds a class in a class/module structure' do
    _(::Base::SubModule.const_get('New')).must_be_kind_of Class
    _(::Base::SubModule::New.new.test).must_equal('New class created!')
  end
  it 'adds a module in a class/module structure' do
    _(::Base::SubModule.const_get('Mod')).wont_be_kind_of Class
    _(::Base::SubModule.const_get('Mod')).must_be_kind_of Module
    _(::Base::SubModule::Mod.instance_method(:test).bind(self).call).must_equal('Mod module created!')
  end
  it 'adds a class in a module/class structure' do
    _(::Basis::SubClass.const_get('New')).must_be_kind_of Class
    _(::Basis::SubClass::New.new.test).must_equal('New class created!')
  end
  it 'adds a module in a module/class structure' do
    _(::Basis::SubClass.const_get('Mod')).wont_be_kind_of Class
    _(::Basis::SubClass.const_get('Mod')).must_be_kind_of Module
    _(::Basis::SubClass::Mod.instance_method(:test).bind(self).call).must_equal('Mod module created!')
  end
  it 'adds a class in a module/module structure' do
    _(::Basis::SubModule.const_get('New')).must_be_kind_of Class
    _(::Basis::SubModule::New.new.test).must_equal('New class created!')
  end
  it 'adds a module in a module/module structure' do
    _(::Basis::SubModule.const_get('Mod')).wont_be_kind_of Class
    _(::Basis::SubModule.const_get('Mod')).must_be_kind_of Module
    _(::Basis::SubModule::Mod.instance_method(:test).bind(self).call).must_equal('Mod module created!')
  end
  it 'creates a class via the namespace' do
    klass = namespace Base::SubClass, class: :Inline do
      def inline_method
        "inline!"
      end
    end
    _(klass).must_be_kind_of(Class)
  end
  it 'creates a class with a parent via the namespace' do
    klass = namespace Base::SubClass, class: :InlineClass, parent: Numeric do
      def inline_method
        "inline class!"
      end
    end
    _(klass.new).must_be_kind_of(Numeric)
    _(klass.new).must_respond_to(:inline_method)
  end
  it 'creates a module via the namespace' do
    mod = namespace Base::SubClass, module: :InlineModule do
      def inline_method
        "inline module!"
      end
    end
    _(mod).must_be_kind_of(Module)
    _(mod.instance_methods).must_include(:inline_method)
  end
  it 'raises an error with class and module options' do
    err = _{ namespace Base::SubClass, module: :InlineModule, class: :InlineClass }.must_raise(ArgumentError)
    _(err.message).must_match(/not both/)
  end
  it 'warns when a parent option is provided with module' do
    _out, err = capture_io do
      namespace Base::SubClass, module: :NoParent, parent: Base::SubClass::New
    end
    _(err).must_match(/An option for :parent was provided as \`Base::SubClass::New' but was ignored/)
  end
end
