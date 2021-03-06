require 'rubygems'
require 'active_record'
require 'active_record/fixtures'
require 'attribute_delegator'
require 'test/unit'

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => 'test/attribute_delegator_test.db',
  :dbfile => 'test.db'
})

ActiveRecord::Schema.define do
  create_table "entries", :force => true do |t|
    t.column "title",  :string
  end

  create_table "entry_metadata", :force => true do |t|
    t.column "entry_id", :integer
    t.column "page_views",  :integer
  end

  create_table "entry_photos", :force => true do |t|
    t.column "entry_id", :integer
    t.column "photo",  :text, :null => false
    t.column "format", :string, :null => false
  end
end
