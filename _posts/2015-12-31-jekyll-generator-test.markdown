---
layout: post
title:  "Jekyll generator test"
project: /projects/knowledge-base/
---

Following my [previous](/2015/12/20/jekyll-scalability-test/) post I build a Jekyll plugin for creating a central yml file built from front matters of pages and posts.

This way when you need this informations in a page or in a post you don't need to cycle on the entire site (which has bad performance) but just on the data file created.

The following is the plugin, my first ruby code. It is customized for my project, but you can get the point.

{% highlight ruby %}
require 'yaml'

module Jekyll

  class CommonData
    def initialize(site, base)
      @site = site
      @base = base

      dataPath = base + '/_data'
      relationsFile = File.open( dataPath + "/relations.yml" , 'w')
      relations = {}
      propertiesFile    = File.open( dataPath + "/properties.yml" , 'w')
      properties = {}

      site.pages.each do |page|
        layout = page.data['layout']
        title = page.data['title']
        if(layout == 'people' or layout == 'projects')
          values = {}
          id = page.url;
          values['title'] = title
          properties[id] = values
        end
      end
      propertiesFile.write( properties.to_yaml );

      site.posts.docs.each do |post|
        values = {}
        values['relations'] = post.data['relations']
        values['title'] = post.data['title']
        values['date'] = post.data['date']
        relations[post.url] = values;
      end
      relationsFile.write( relations.to_yaml );

    end
  end

  class CommonDataGenerator < Generator
    safe false

    def generate(site)
      CommonData.new(site, site.source)
    end
  end

end

{% endhighlight %}

I don't think this is an optimal solution. Generating data file cause the site to be regenerated... An improvement could be of checking the hash of the data agains the previous generated to write the file only if changed. Or maybe writing the Jekyll plugin using [hooks](http://jekyllrb.com/docs/plugins/#hooks) instead of [generators](http://jekyllrb.com/docs/plugins/#generators).

If you have any feedback, check this [post](https://talk.jekyllrb.com/t/jekyll-site-as-a-knowledge-base/1690) on the Jekyll talks site
