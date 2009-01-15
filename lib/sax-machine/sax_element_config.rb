module SAXMachine
  class SAXConfig
    
    class ElementConfig
      attr_reader :name
      
      def initialize(name, options)
        @name = name
        
        if options.has_key?(:with)
          # for faster comparisons later
          @with = options[:with].to_a.flatten.collect {|o| o.to_s}
        else
          @with = nil
        end
        
        if options.has_key?(:value)
          @value = options[:value].to_s
        else
          @value = nil
        end
        
        @as = options[:as]
      end

      def value_from_attrs(attrs)
        attrs[attrs.index(@value) + 1]
      end
      
      def setter
        "#{@as}="
      end
      
      def attrs_match?(attrs)
        if @with
          @with == (@with & attrs)
        else
          true
        end
      end
      
      def has_value_and_attrs_match?(attrs)
        !@value.nil? && attrs_match?(attrs)
      end
    end
    
  end
end