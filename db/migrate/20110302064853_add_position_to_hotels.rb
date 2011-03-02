class AddPositionToHotels < ActiveRecord::Migration
  def self.up
    add_column :hotels, :position, :integer

    Hotel.order("id").all.each_with_index do |hotel, i|
      hotel.position = i + 1
      hotel.save
    end
  end

  def self.down
    remove_column :hotels, :position
  end
end
