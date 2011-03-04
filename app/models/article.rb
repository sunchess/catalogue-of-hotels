class Article < ActiveRecord::Base
  attr_accessible :title, :body

  belongs_to :articleable, :polymorphic => true, :counter_cache => true
  has_many :images, :as => :imageable

  validates_presence_of :title, :body
  validates :title, :length => { :minimum => 15 }
  validates :body, :length => { :minimum => 150 }
end
