module ClubsHelper

  def join_tees_with_commas club
    tee_array = []
    color_order = ['blue', 'white', 'gold', 'green', 'red']
    club.tees.each { |t| tee_array << t.color }
    sorted = tee_array.sort_by do |e|
      color_order.index(e)
    end
    sorted.join(', ')
  end

end
