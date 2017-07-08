module ClubsHelper

  def join_tees_with_commas club
    tee_array = []
    club.tees.each { |t| tee_array << t.color }
    tee_array.sort_by do |e|
      sorted = ['blue', 'white', 'gold', 'green', 'red'].index(e)
      sorted.join(', ')
    end
  end

end
