require_relative '../lib/added'
require 'minitest/autorun'

describe Added do
  let :object do
    Object.new
  end

  let :klass do
    Class.new
  end

  let :mod do
    Module.new do
      def self.added(instance)
        instance.instance_variable_set(:@my, "state")
      end
    end
  end

 describe 'Extending' do
   it 'works' do
     object.extend(mod)

     assert_equal "state", object.instance_variable_get(:@my)
   end
 end

 describe 'Including (new instances)' do
   it 'works' do
     klass.send :include, mod
     object = klass.new

     assert_equal "state", object.instance_variable_get(:@my)
   end
 end

 describe 'Including (existing instances)' do
   it 'works' do
     object = klass.new
     klass.send :include, mod

     assert_equal "state", object.instance_variable_get(:@my)
   end
 end

 describe 'Prepending (new instances)' do
   it 'works' do
     klass.send :prepend, mod
     object = klass.new

     assert_equal "state", object.instance_variable_get(:@my)
   end
 end

 describe 'Prepending (existing instances)' do
   it 'works' do
     object = klass.new
     klass.send :prepend, mod

     assert_equal "state", object.instance_variable_get(:@my)
   end
 end

 describe 'More' do
   it 'respects initializers before inclusion' do
     klass.send :define_method, :initialize do |*args|
       @my2 = args[0]
     end
     klass.include(mod)
     object = klass.new("state2")

     assert_equal "state", object.instance_variable_get(:@my)
     assert_equal "state2", object.instance_variable_get(:@my2)
   end

   it 'respects initializers after inclusion' do
     klass.include(mod)
     klass.send :define_method, :initialize do |*args|
       @my2 = args[0]
     end
     object = klass.new("state2")

     assert_equal "state", object.instance_variable_get(:@my)
     assert_equal "state2", object.instance_variable_get(:@my2)
   end

   it 'works with sub-classed classes' do
     sub_klass = Class.new(klass)
     klass.include(mod)
     object = sub_klass.new

     assert_equal "state", object.instance_variable_get(:@my)
   end
 end
end

