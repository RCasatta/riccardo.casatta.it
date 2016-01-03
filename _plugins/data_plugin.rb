require 'yaml'

module Jekyll

  class CommonData
    def initialize(site, base)
      @site = site
      @base = base

      # p "initialize"

      dataPath = base + "/_data"
      projectsFile = File.open( dataPath + "/projects.yml" , 'w')
      projects = {}

      site.pages.each do |page|
        layout = page.data['layout']
        title = page.data['title']
        if( layout == 'project')
          values = {}
          id = page.url;
          values['title']  = title
          values['url']    = page.data['url']
          values['source'] = page.data['source']
          values['description'] = page.data['description']

          projects[id] = values
        end
      end
      projectsFile.write( projects.to_yaml );

    end
  end

  class CommonDataGenerator < Generator
    safe false

    def generate(site)
      CommonData.new(site, site.source)
    end
  end

end
