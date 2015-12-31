---
layout: post
title:  "Jekyll scalability test"
permalink: /2015/12/20/jekyll-scalability-test/
tags: git open-source jekyll scalability
---

At work, we were questioning about building a collaborative knowledge base with git and jekyll. For this purpose we need entities with properties and relations among them.

I was wondering if Jekyll is an appropriate instruments and how many pages could you handle Jekyll with reasonable building time of the site.

I wrote some code to randomly create mock up data for **700 people** and **100 companies**. Every person work for a company and companies have zero, one or more employees. We need to show this informations on company and people pages plus some properties.

## First attempt
In my [first attempt](https://github.com/RCasatta/jekyll-scalability-test/tree/95d34ff328fc622400604728553b52dd9b2a8d75) I created one page for every person and every company, I stored every data in in the [Front Matter](http://jekyllrb.com/docs/frontmatter/) of the pages, for example:

{% highlight html %}
---
layout: company
id: able
title: Able
founded: 2000
country: Italy
permalink: /companies/able
people: [virus.gallery, apple.auction, clown.grape]
---
{% endhighlight %}

With this data structure, the liquid code showing the employees of a company is something like that:

{% highlight html %}
{% raw %}
{% for person in page.people %}
  {% for apage in site.pages %}
    {% if apage.id == person %}
     <li><a href="/people/{{ person }}">{{ apage.title }}</a></li>
    {% endif %}
  {% endfor %}
{% endfor %}
{% endraw %}
{% endhighlight %}

We are cycling on the people array of the page, then cycling on every page of the site in search of the name relative to the employee.
With this non-optimized solution, the building process took about **60 seconds**. Launching Jekyll with `jekyll serve --incremental` helps a lot, but the build does recognize the changes in the current page but doesn't rebuild the referenced page (eg. updating the name of a person change the person page but not the company where the person is working).

## Second attempt
I initially thought that every Front Matter data was kept in memory in the build process, but seeing the results I don't think it anymore. I needed a more fast approach so I decidet to keep a single yml file storing data accessible by key from any page. Thus reducing the number of document that the build process need to read.

In the front matter of pages I am now storing just the id and required parameter

{% highlight html %}
---
layout: company
id: ability
title: Ability
permalink: /companies/ability.html
---
{% endhighlight %}

I am also keeping a companies.yml file containing:

{% highlight html %}
ability:
  name: Ability
  founded: 2004
  country: Spain
  people: [jose.navarro, ricardo.fereira]
megacorp:
  name: Mega corp
  founded: 2001
  country: USA
  people: [john.brown, alice.steven, bob.mckenzie]

...
{% endhighlight %}

Now the liquid code showing employees of a company becomes:

{% highlight html %}
{% raw %}
{% assign company = site.data.companies[page.id] %}
{% for personid in company.people %}
  {% assign person = site.data.people[personid] %}
  <li><a href="{{ site.baseurl }}/people/{{ personid }}.html">{{ person.fullname }}</a></li>
{% endfor %}
{% endraw %}
{% endhighlight %}

With this changes the site complete regenaration takes just <strong>3 secs</strong> on a Mac Book Pro.

## Demo
You can have a look at the [test web site](http://riccardo.casatta.it/jekyll-scalability-test/) and his [open source code](https://github.com/RCasatta/jekyll-scalability-test)
