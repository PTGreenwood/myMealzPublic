# -*- encoding : utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

# this allows WEBrick to handle pipe symbols in query parameters
#URI::DEFAULT_PARSER = URI::Parser.new(:UNRESERVED => URI::REGEXP::PATTERN::UNRESERVED + '|')

#require 'pdfkit'
#config.middleware.use PDFKit::Middleware

# Initialize the rails application
MYMEALZ::Application.initialize!

