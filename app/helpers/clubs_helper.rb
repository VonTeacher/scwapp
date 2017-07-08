module ClubsHelper

  def join_tees_with_commas club
    tee_array = []
    color_order = ['Blue', 'White', 'Gold', 'Green', 'Red']
    club.tees.each { |t| tee_array << t.color }
    sorted = tee_array.sort_by do |e|
      color_order.index(e)
    end
    sorted.join(', ')
  end

end
