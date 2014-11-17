require 'sax-machine/handlers/sax_abstract_handler'
require 'oga'

module SAXMachine
  class SAXOgaHandler
    include SAXAbstractHandler

    def initialize(*args)
      _initialize(*args)
    end

    def sax_parse(xml_text)
      Oga.sax_parse_xml(self, xml_text)
    end

    def on_element(namespace, name, attrs)
      _start_element(node_name(namespace, name), attrs.map { |a| [a.name, a.value] })
    end

    def after_element(namespace, name)
      _end_element(node_name(namespace, name))
    end

    def on_error(*args)
      _error(args.join(" "))
    end

    alias_method :on_text, :_characters
    alias_method :on_cdata, :_characters

    private

    def node_name(namespace, name)
      namespace ? [namespace, name].join(":") : name
    end
  end
end
