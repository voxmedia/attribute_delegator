# Attribute Delegator

AttributeDelegator is a gem that provides a class method to ActiveRecord
models which will generate native getter/setter methods for a the attributes of
a has_one delegate.

Sound complicated? It's not.

## How To Use

This is how to setup AttributeDelegator

    # Contains a 'title' field.
    class Entry < ActiveRecord::Base
      include ::AttributeDelegator
      has_one :entry_metadata
      delegates_attributes_to :entry_metadata, [:page_views]
    end

    # Contains 'entry_id' and 'page_views' fields.
    class EntryMetadata < ActiveRecord::Base
      belongs_to :entry
      validates_uniqueness_of :entry_id
    end

And this is how you can use it

  # You can use normal getter/setter methods
  e1 = Entry.new(:title => 'entry title')
  e1.page_views = 50
  e1.save!
  assert_equal e1.page_views, e1.entry_metadata.page_views

  # You can also set the attributes upon creation
  e2 = Entry.create!(:title => 'Another title', :page_views => 50)
  assert_equal 50, e2.page_views

  # Finally, you can use attributes=, like you would submitting a form
  e3 = Entry.new
  e3.attributes = { :title => 'a title', :page_views => 50}
  assert_equal 50, e3.page_views
