class CreateOfferAgents < ActiveRecord::Migration
  def self.up
    create_table :offer_agents do |t|
      t.string :name
      t.text :details
      t.timestamps
    end
  end

  def self.down
    drop_table :offer_agents
  end
end
