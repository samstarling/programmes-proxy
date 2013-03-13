require 'rubygems'
require 'sinatra'
require 'rest_client'

require_relative 'lib/linked_data'
require_relative 'lib/programmes_page'

# RestClient.proxy = "http://www-cache.reith.bbc.co.uk"

get '/programmes/:pid' do |pid|
  response = RestClient.get "http://www.bbc.co.uk/programmes/#{pid}", :accept => "text/html"
  page = ProgrammesPage.new(response.body)
  page.add_element('#content .col-b', LinkedDataPanel.render)
  page.to_s
end
