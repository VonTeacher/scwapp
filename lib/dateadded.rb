module Dateadded

  def date_added
    self.created_at.strftime("%B %d, %Y")
  end

end
