require 'test/setup'

class Entry < ActiveRecord::Base
  include ::AttributeDelegator
  has_one :entry_metadata
  delegates_attributes_to :entry_metadata, [:page_views]

  has_one :entry_photo
  delegates_attributes_to :entry_photo, [:format, :photo]
end

class EntryMetadata < ActiveRecord::Base
  belongs_to :entry
  validates_uniqueness_of :entry_id
end

class EntryPhoto < ActiveRecord::Base
  belongs_to :entry
  validates_uniqueness_of :entry_id
end


class TestMultipleAttributeDelegators < Test::Unit::TestCase
  def test_working_with_multiple_delegates
    page_views = 10
    photo = "ok pretend this string is a photo"
    e = Entry.create!({
      :page_views => page_views,
      :photo => photo,
      :format => 'jpeg'
    })
    assert_equal photo, e.photo
    assert_equal photo, e.entry_photo.photo
    assert_equal page_views, e.page_views
    assert_equal page_views, e.entry_metadata.page_views
  end
end
