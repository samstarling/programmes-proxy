require 'nokogiri'

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
