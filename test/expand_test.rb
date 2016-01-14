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

namespace 'Base::SubClass' do
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
end
