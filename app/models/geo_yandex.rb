# encoding: UTF-8
require 'rest_client'

class GeoYandex
  attr_reader :position, :lower_corner, :upper_corner

  #Use the class simple
  #geo = GeoYandex.new({:city => "Москва", :address => "Тверская улица, дом 7"})
  #
  #geo.position
  # [37.611006, 55.757962]
  #
  #geo.lower_corner
  # [37.608958 55.756807]
  #
  #geo.upper_corner
  # [37.613054 55.759117]
  #
  def initialize(options={})
    #http://geocode-maps.yandex.ru/1.x/?geocode=Москва,+Тверская+улица,+дом+7
    @city = options[:city] || "Москва"
    @address = options[:address] || "Тверская улица, дом 7"
    @result = {}
    http_get
    parse
    @position = @result[:position]
    @lower_corner = @result[:lower_corner]
    @upper_corner = @result[:upper_corner]
  end

  private
  def http_get
    @resp= RestClient.get( 'http://geocode-maps.yandex.ru/1.x/', {:params => {:geocode => "#{@city}, #{@address}", :format => "json"}} )
  end

  def parse
    if @resp.code == 200
      parser_result = JSON.parse( @resp.body )
      obj = parser_result["response"]["GeoObjectCollection"]["featureMember"].first #["Point"]#["pos"]
      @result[:position] = obj["GeoObject"]["Point"]["pos"].split.map(&:to_f).reverse
      #{"GeoObject"=>{"boundedBy"=>{"Envelope"=>{"lowerCorner"=>"39.905527 43.463644", "upperCorner"=>"39.909624 43.466627"}
      @result[:lower_corner] = obj["GeoObject"]["boundedBy"]["Envelope"]["lowerCorner"].split.map(&:to_f).reverse
      @result[:upper_corner] = obj["GeoObject"]["boundedBy"]["Envelope"]["upperCorner"].split.map(&:to_f).reverse
    else
      @result[:position], @result[:lower_corner], @result[:upper_corner] = "", "", ""
    end
  end
end
