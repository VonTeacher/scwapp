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

  # THIS CODE NEEDS WORK!
  # July 10, 2017
  def list_tees_in_color_order club
    tee_array = []
    color_order = ['Blue', 'White', 'Gold', 'Green', 'Red']
    club.tees.each { |t| tee_array << t }
    sorted = tee_array.sort_by do |e|
      color_order.index(e[:color])
    end
    sorted
  end

end
