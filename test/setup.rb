require 'rubygems'
require 'active_record'
require 'active_record/fixtures'
require 'attribute_delegator'
require 'test/unit'

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => 'attribute_delegator_test',
  :dbfile => 'test.db'
})

ActiveRecord::Schema.define do
  create_table "entries", :force => true do |t|
    t.column "title",  :string
    t.column "body",  :text
  end

  create_table "entry_metadata", :force => true do |t|
    t.column "entry_id", :integer
    t.column "page_views",  :integer
  end

  create_table "entry_photos", :force => true do |t|
    t.column "entry_id", :integer
    t.column "photo",  :text
  end
end
