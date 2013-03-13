require 'rubygems'
require 'sinatra'
require 'rest_client'
require 'nokogiri'
require 'erubis'

# RestClient.proxy = "http://www-cache.reith.bbc.co.uk"

class ProgrammesPage
  def initialize html
    @document = Nokogiri::HTML html
    add_base_attribute
    add_stylesheet
  end

  def to_s
    @document.to_s.gsub('"/programmes/', '"http://www.bbc.co.uk/programmes/')
  end

  def add_element selector, content
    @document.css(selector).children.first.add_previous_sibling(content)
  end

  private

  def add_base_attribute
    @document.xpath('//body').first['base'] = "http://www.bbc.co.uk/"
  end

  def add_stylesheet
    @document.css('head').first.add_child('<style>#bbccookies { display: none !important; }</style>')
  end
end

class LinkedDataPanel
  def self.render
    src = File.read('templates/panel.erb')
    template = Erubis::Eruby.new(src)
    template.result(:title => "Hello")
  end
end

class LinkedDataClient
  def self.get_creative_work pid
    "abc"
  end
end

get '/programmes/:pid' do |pid|
  response = RestClient.get "http://www.bbc.co.uk/programmes/#{pid}", :accept => "text/html"
  page = ProgrammesPage.new(response.body)
  page.add_element('#content .col-b', LinkedDataPanel.render)
  page.to_s
end


