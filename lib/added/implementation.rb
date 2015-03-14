module Added
  def extended(instance)
    super
    added(instance) if respond_to? :added
  end

  def included(klass)
    super
    if respond_to? :added
      mod = self
      klass.prepend(Module.new do
        define_method(:initialize){ |*args, &block|
          super(*args, &block)
          mod.added(self)
        }
      end)
      ObjectSpace.each_object(klass){ |instance|
        added(instance)
      }
    end
  end

  alias prepended included
end
