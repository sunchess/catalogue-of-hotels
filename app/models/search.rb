class Search
  attr_accessor :month, :city, :from, :to

  def initialize(options={})
    @month = options[:month] || Time.now.month.to_i
    @city  = options[:city]  || ""
    @from  = options[:from]  || "500"
    @to    = options[:to]    || "2000"
  end

  def rooms(page = 1)
    place = Place.find @city
    places_ids = [place.id]
    if place.children.any?
      places_ids += place.children.map(&:id)
    end
    rooms = Room.joins([ :hotel, :prices ]).where("hotels.draft"=>false, "hotels.place_id" => places_ids, "prices.month" => @month.to_i, "prices.cost" => ( @from..@to )).paginate(:page=>page, :per_page=>15)
    rooms
  end
end
