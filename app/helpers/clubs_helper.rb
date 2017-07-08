module ClubsHelper

  def join_tees_with_commas club
    tee_array = []
    club.tees.each { |t| tee_array << t.color }
    tee_array.join(', ')
  end

end
