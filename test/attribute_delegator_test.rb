require 'test/setup'

class Entry < ActiveRecord::Base
  include ::AttributeDelegator
  has_one :entry_metadata
  delegates_attributes_to :entry_metadata, [:page_views]
end

class EntryMetadata < ActiveRecord::Base
  belongs_to :entry
  validates_uniqueness_of :entry_id
end


class TestAttributeDelegator < Test::Unit::TestCase
  def setup
    @entry = Entry.create!(:title => "Entry Title", :body => "Body of entry")
  end

  def test_delegated_attributes_getters_and_setters
    assert_nil @entry.page_views
    page_views = 5
    @entry.page_views = page_views
    assert_equal @entry.page_views, page_views
    assert @entry.entry_metadata.changed?

    @entry.save!
    @entry = Entry.find(@entry.id)
    assert_equal @entry.page_views, @entry.entry_metadata.page_views
    assert_equal false, @entry.entry_metadata.changed?, "if the parent object is saved, the delgate should be as well"
  end

  def test_delegates_attributes_can_be_set_by_attributes=
    assert_nil @entry.page_views
    page_views = 5
    @entry.attributes = { :page_views => page_views }
    @entry.save!

    entry = Entry.find(@entry.id)
    assert_equal 5, entry.page_views
  end

  def test_repeated_assignment_doesnt_break
    @entry.page_views = 5
    assert_equal 5, @entry.page_views
    @entry.page_views = 10
    assert_equal 10, @entry.page_views
  end
end
