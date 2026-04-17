module FormAttributeMethods
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    # Add the ability to read/write attributes without calling their accessor methods.
    # Needed to behave more like an ActiveRecord model, where you can manipulate the
    # database attributes making use of `self[:attribute]`
    def [](attr_name)
      instance_variable_get("@#{attr_name}".to_sym)
    end

    def []=(attr_name, value)
      instance_variable_set("@#{attr_name}".to_sym, value)
    end

    def attributes_map
      self.class.attributes_map(self)
    end
  end

  module ClassMethods
    def attribute(name, type = nil, **_opts)
      @attributes ||= []
      @attribute_types ||= {}

      name = name.to_sym
      @attributes << name unless @attributes.include?(name)
      @attribute_types[name] = type

      define_method(name) do
        val = instance_variable_get("@#{name}")
        case type
        when :yes_no
          val.is_a?(GenericYesNo) ? val : GenericYesNo.new(val)
        when :boolean
          case val
          when true, "true", "1", 1 then true
          when false, "false", "0", 0 then false
          end
        when :string_array
          Array(val).reject(&:blank?)
        else
          val
        end
      end

      define_method("#{name}=") do |val|
        instance_variable_set("@#{name}", val)
      end

      define_method("#{name}?") { send(name) } if [:boolean, :yes_no].include?(type)
    end

    # A shortcut to declaring multiple attributes of the same type
    def attributes(collection, type, opts = {})
      collection.each { |name| attribute(name, type, **opts) }
    end

    def attribute_types
      if superclass.respond_to?(:attribute_types)
        superclass.attribute_types.merge(@attribute_types || {})
      else
        @attribute_types || {}
      end
    end

    def attribute_names
      if superclass.respond_to?(:attribute_names)
        superclass.attribute_names + (@attributes || [])
      else
        @attributes || []
      end
    end

    # Iterates through all declared attributes in the form object, mapping its values
    def attributes_map(origin)
      attribute_names.map { |name| [name, origin.try(name)] }.to_h
    end
  end
end
