# Minislug

Please use <a href='https://github.com/bkoski/slug'>bkoski/slug</a> unless you're looking for something very bare-bones.
Minislug, like other slug implementations, generates a url-friendly id for your model object by converting or stripping
undesirable characters from a source string that you specify.

Minislug abhors uniqueness checks because it is quite possible that you are slugging objects whose uniqueness needs are context-dependent,
for example, in a multi-tenant application, you don't want globally-unique slugs. Or another example, if you manage
family data, you might expect (in a typical euro-usa-latin culture), all children in a given family have unique first names.
So when a parent logs in, he or she might understand urls like

    http://example.com/children/john
    http://example.com/children/paul
    http://example.com/children/osiris

You have cleverly coded your application to not confuse children with the popular first name "Osiris", because you lookup children by slug
*and* by family_id, where family_id is also a property of the current user. It would really suck to have urls such as

    http://example.com/children/osiris-34

As a parent, I would feel belittled by the constant reminder that 33 little Osirisses got to your site before my little Osiris did,
with his popular name casting a glow of irredeemable ordinariness about him.

Enough.

## Installation

Add this line to your application's Gemfile:

    gem 'minislug'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minislug

## Usage

    class Person < ActiveRecord::Base
      sluggable :full_name
    end

    p = Person.new :full_name => "Jàmês Jöÿcè"
    p.slug # => "james-joyce"
    p.save

    Person.by_slug("james-joyce") # => <Person "full_name":"Jàmês Jöÿcè" "slug":"james-joyce">

No options, assumes "slug" attribute exists and is writable. No validations, no uniqueness checks.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
