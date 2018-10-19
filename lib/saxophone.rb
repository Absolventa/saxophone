require "saxophone/version"
require "saxophone/sax_document"
require "saxophone/sax_configure"
require "saxophone/sax_config"

module Saxophone
  def self.handler
    @@handler ||= nil
  end

  def self.handler=(handler)
    if handler
      require "saxophone/handlers/sax_#{handler}_handler"
      @@handler = handler
    end
  end
end

# Try handlers
[:ox, :oga].each do |handler|
  begin
    Saxophone.handler = handler
    break
  rescue LoadError
  end
end

# Still no handler, use Nokogiri
if Saxophone.handler.nil?
  Saxophone.handler = :nokogiri
end
