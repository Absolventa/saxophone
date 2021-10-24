<svg viewBox="0 0 413 137" width="200" xmlns="http://www.w3.org/2000/svg">
  <g fill="none" fill-rule="evenodd">
    <path d="M75.791 2.4c-3.825.632-6.46 1.188-7.901 1.669-4.115 1.372-6.616 3.229-8.361 4.467-2.703 1.917-4.657 4.773-6.09 7.315-1.79 3.175-2.723 6.155-2.786 9.609C50.283 54.076 50 93.762 50 107.5c0 1.002-.061 1.99-.18 2.96C48.36 122.32 38.251 131.5 26 131.5c-13.255 0-24-10.745-24-24V74.106l22.763-11.521.318 41.027M41.2 52.7h18.668M41.2 62.453h18.668M41.2 72.276h18.668" stroke="#0A0909" stroke-width="4"/>
    <path d="M84.096 122c8.187 0 11.806-1.958 14.908-8.173 1.206 5.363 3.62 6.981 9.996 6.981v-4.342c-5.17.085-6.721-1.958-6.721-9.025V85.22c0-13.708-4.395-18.22-18.183-18.22-10.082 0-14.132 2.895-16.803 11.834l4.567 1.107c1.982-6.556 4.825-8.514 12.236-8.514 10.255 0 13.443 3.236 13.443 13.793v5.278H84.096C70.395 90.498 66 94.245 66 106.59 66 118.254 70.395 122 84.096 122Zm.36-4C74.127 118 71 115.35 71 106.885 71 97.736 74.125 95 84.457 95H98v7.61C98 114.323 94.788 118 84.457 118Zm39.866 3L137.5 98.874 150.763 121H156l-15.797-26.5L156 68h-5.237L137.5 90.126 124.322 68H119l15.881 26.5L119 121h5.322Zm65.135 1C203.492 122 208 115.274 208 94.5S203.492 67 189.457 67C175.423 67 171 73.726 171 94.5s4.423 27.5 18.457 27.5Zm-.5-4C178.36 118 175 112.47 175 94.5S178.36 71 188.957 71C199.554 71 203 76.53 203 94.5s-3.446 23.5-14.043 23.5Zm37.71 19v-21.757c2.292 5.504 7.299 7.31 13.833 7.31 14.002 0 18.5-6.794 18.5-27.863C259 73.708 254.502 67 240.5 67c-6.365 0-11.372 1.29-13.833 5.332v-4.128H222V137h4.667ZM241 118c-8.417 0-14-3.801-14-14.428V78.344c0-5.616 6.442-7.344 14-7.344 10.564 0 14 5.53 14 23.414 0 17.97-3.436 23.586-14 23.586Zm38.737 3V85.98c0-11.56 3.014-14.365 13.177-14.365 10.076 0 13.35 5.185 13.35 22.015V121H311V93.63c0-19.975-4.392-26.35-18.086-26.35-6.46 0-11.282 1.53-13.177 6.375V53H275v68h4.737Zm63.72 1C357.492 122 362 115.274 362 94.5S357.492 67 343.457 67C329.423 67 325 73.726 325 94.5s4.423 27.5 18.457 27.5Zm-.5-4C332.36 118 329 112.47 329 94.5S332.36 71 342.957 71C353.554 71 357 76.53 357 94.5s-3.446 23.5-14.043 23.5Zm38.757 3V85.797c0-11.79 3.515-14.44 15.172-14.44 8.657 0 11.4 3.675 11.4 15.38V121H413V86.737C413 71.7 409.143 67 396.886 67c-8.315 0-12.086 1.88-15.172 6.323v-5.127H377V121h4.714Z" fill="#000" fill-rule="nonzero"/>
  </g>
</svg>

[![Build Status](https://github.com/Absolventa/saxophone/actions/workflows/build.yml/badge.svg)](https://github.com/Absolventa/saxophone/actions/workflows/build.yml)

A declarative SAX parsing library backed by Nokogiri, Ox or Oga.

## Origins

This repository is a fork of [pauldix/sax-machine](https://github.com/pauldix/sax-machine). We'd like to
thank all original authors and contributers for their work on the original repository. However, we have
the feeling that the original repository is not being actively maintained anymore - that's why we decided to
fork it and continue the work of the original authors in our façon. To make the distinction clear, we
renamed the project from that point to `Saxophone`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'saxophone'
```

And then execute:

```bash
$ bundle
```

## Usage

Saxophone can use either `nokogiri`, `ox` or `oga` as XML SAX handler.

To use **Nokogiri** add this line to your Gemfile:

```ruby
gem 'nokogiri', '~> 1.6'
```

To use **Ox** add this line to your Gemfile:

```ruby
gem 'ox', '>= 2.10.0'
```

To use **Oga** add this line to your Gemfile:

```ruby
gem 'oga', '>= 2.15'
```

You can also specify which handler to use manually, like this:

```ruby
Saxophone.handler = :nokogiri
```

## Examples

Include `Saxophone` in any class and define properties to parse:

```ruby
class AtomContent
  include Saxophone
  attribute :type
  value :text
end

class AtomEntry
  include Saxophone
  element :title

  # The :as argument makes this available through entry.author instead of .name
  element :name, as: :author
  element "feedburner:origLink", as: :url

  # The :default argument specifies default value for element when it's missing
  element :summary, class: String, default: "No summary available"

  element :content, class: AtomContent
  element :published

  ancestor :ancestor
end

class Atom
  include Saxophone

  # Use block to modify the returned value
  # Blocks are working with pretty much everything,
  # except for `elements` with `class` attribute
  element :title do |title|
    title.strip
  end

  # The :with argument means that you only match a link tag
  # that has an attribute of type: "text/html"
  element :link, value: :href, as: :url, with: {
    type: "text/html"
  }

  # The :value argument means that instead of setting the value
  # to the text between the tag, it sets it to the attribute value of :href
  element :link, value: :href, as: :feed_url, with: {
    type: "application/atom+xml"
  }

  elements :entry, as: :entries, class: AtomEntry
end
```

Then parse any XML with your class:

```ruby
feed = Atom.parse(xml)

feed.title # Whatever the title of the blog is
feed.url # The main URL of the blog
feed.feed_url # The URL of the blog feed

feed.entries.first.title # Title of the first entry
feed.entries.first.author # The author of the first entry
feed.entries.first.url # Permalink on the blog for this entry
feed.entries.first.summary # Returns "No summary available" if summary is missing
feed.entries.first.ancestor # The Atom ancestor
feed.entries.first.content # Instance of AtomContent
feed.entries.first.content.text # Entry content text
```

You can also use the elements method without specifying a class:

```ruby
class ServiceResponse
  include Saxophone
  elements :message, as: :messages
end

response = ServiceResponse.parse("
  <response>
    <message>hi</message>
    <message>world</message>
  </response>
")
response.messages.first # hi
response.messages.last  # world
```

To limit conflicts in the class used for mappping, you can use the alternate
`Saxophone.configure` syntax:

```ruby
class X < ActiveRecord::Base
  # This way no element, elements or ancestor method will be added to X
  Saxophone.configure(X) do |c|
    c.element :title
  end
end
```

Multiple elements can be mapped to the same alias:

```ruby
class RSSEntry
  include Saxophone

  element :pubDate,           as: :published
  element :pubdate,           as: :published
  element :"dc:date",         as: :published
  element :"dc:Date",         as: :published
  element :"dcterms:created", as: :published
end
```

If more than one of these elements exists in the source, the value from the *last one* is used. The order of
the `element` declarations in the code is unimportant. The order they are encountered while parsing the
document determines the value assigned to the alias.

If an element is defined in the source but is blank (e.g., `<pubDate></pubDate>`), it is ignored, and non-empty one is picked.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## LICENSE

The MIT License

Copyright (c) 2009-2020:

* [Paul Dix](http://www.pauldix.net)
* [Julien Kirch](http://www.archiloque.net)
* [Ezekiel Templin](http://zeke.templ.in)
* [Dmitry Krasnoukhov](http://krasnoukhov.com)
* [Robin Neumann](https://github.com/neumanrq)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
