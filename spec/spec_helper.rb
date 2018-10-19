require File.expand_path(File.dirname(__FILE__) + '/../lib/saxophone')
Saxophone.handler = ENV['HANDLER'].to_sym if ENV['HANDLER']
