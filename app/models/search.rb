class Search
  attr_accessor :month, :city, :from, :to

  def initialize(options={})
    @month = options[:month] || Time.now.month.to_i
    @city  = options[:city]  || ""
    @from  = options[:from]  || "500"
    @to    = options[:to]    || "2000"
  end
end
