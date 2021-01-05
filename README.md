# Added Hook for Ruby [![[version]](https://badge.fury.io/rb/added.svg)](https://badge.fury.io/rb/added)  [![[ci]](https://github.com/janlelis/added/workflows/Test/badge.svg)](https://github.com/janlelis/added/actions?query=workflow%3ATest)

Module#added: A unified module hook to run code on all instances when adding the module.


## Warning

This is experimental: You should exactly know what you do, if you want to use it in production.

Besides this, I am really curious if you like the approach this gem is taking!


## Description

Ruby allows you to run hooks, when an module is inserted into another object:

* Module#extended
* Module#included
* Module#prepended

This gem unifies all these hooks into a single `Module#added` one, which will be fired for *all* instances that the module has been added to. An example use case might be that you want to set some instance variable for all instances that include the module. There are three different occasions a hook is fired:

* An object extends itself with the module -> The added hook will run for this object
* A class has included/prepended the module -> The added hook will run on newly initialized objects of this class
* A class has included/prepended the module -> The added hook will run on all existing instances of this class


## Setup

Add to your `Gemfile`

```ruby
gem 'added'
```


## Usage

```ruby
module MyStateSetter
  def self.added(instance)
    instance.instance_variable_set(:@my, "state")
  end
end

# Extending
object = Object.new
object.extend(MyStateSetter)
object.instance_variable_get(:@my) # => "state"

# Including (new instances)
klass = Class.new
klass.include(MyStateSetter)
object = klass.new
object.instance_variable_get(:@my) # => "state"

# Including (existing instances)
klass = Class.new
object = klass.new
klass.include(MyStateSetter)
object.instance_variable_get(:@my) # => "state"

# Prepending (new instances)
klass = Class.new
klass.prepend(MyStateSetter)
object = klass.new
object.instance_variable_get(:@my) # => "state"

# Including (existing instances)
klass = Class.new
object = klass.new
klass.prepend(MyStateSetter)
object.instance_variable_get(:@my) # => "state"

```


## JRuby Notes

This gem requires a Module#prepend implementation and must have the ObjectSpace available. As JRuby user this means you will need to run JRuby with the -X+O option to use this gem.


# Also See

* [ActiveSupport::Concern](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/concern.rb)


## MIT License

Copyright (C) 2015 by [Jan Lelis](https://janlelis.com).
