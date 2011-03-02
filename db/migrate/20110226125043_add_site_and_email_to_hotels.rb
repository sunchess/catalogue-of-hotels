class AddSiteAndEmailToHotels < ActiveRecord::Migration
  def self.up
    add_column :hotels, :site, :string
    add_column :hotels, :email, :string
  end

  def self.down
    remove_column :hotels, :email
    remove_column :hotels, :site
  end
end
