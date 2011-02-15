class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :articleable_id
      t.string :articleable_type
      t.timestamps
    end
    add_index :articles, :articleable_id
    add_index :articles, :articleable_type
  end

  def self.down
    drop_table :articles
  end
end
