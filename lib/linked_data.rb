require 'erubis'

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
