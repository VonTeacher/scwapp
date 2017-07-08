module ClubsHelper

  def join_tees_with_commas club
    tee_array = []
    club.tees.each { |t| tee_array << t.color }
    tee_array.sort_by do |e|
      ['blue', 'white', 'gold', 'green', 'red'].index(e)
    end
  end

end
