require 'simplecov'
SimpleCov.start do
  #add_filter '/spec/' # for rspec
  #add_filter '/test/' # for minitest

end

logger = Logger.new("/dev/null")
logger.level = Logger::INFO
Braintree::Configuration.logger = logger
