module UsersHelper

  def user_profile_handicap_index user
    if user.rounds.count < 5
      content_tag(:p, "#{5 - user.rounds.count} more rounds needed to obtain an index.")
    else
      content_tag(:h3, )
      # index calc
    end
  end

  def user_greeting user
    if user == current_user
      content_tag(:h2, "Hi&#44; #{user.username}!".html_safe) +
      content_tag(:button) do
       link_to 'Add a New Round', add_round_path(user)
      end
    else
      content_tag(:h2, "Profile for #{user.username}")
    end
  end

  def user_profile_last_round user
    if user.rounds.empty?
      content_tag(:h3, 'No rounds played.', class: 'user-profile-section-header')
    else
      content_tag(:h3, 'Last Round Played:', class: 'user-profile-section-header') +
      content_tag(:div, class: 'user-last-score-wrapper') do
        content_tag(:div, "<div class='user-last-ags'>#{user.last_played.adjusted_score}</div>
                           <div class='user-last-diff'>(#{user.last_played.round_handicap_differential.round(1)})</div>".html_safe, class: 'user-last-inline user-last-right-buffer') +
        content_tag(:div, "<div class='user-last-tee'>#{user.last_played.tee.color}</div>
                           <div class='user-last-club'>#{user.last_played.club.name}</div>
                           <div class='user-last-date'>#{user.last_played.date_played.strftime('%b %d, %Y')}</div>".html_safe, class: 'user-last-inline')
      end
    end
  end

  def user_profile_latest_n_rounds user
    if user.rounds.empty?
      content_tag(:h3, 'No rounds played.', class: 'user-profile-section-header')
    else
      content_tag(:h3, "Previous Rounds Played:", class: 'user-profile-section-header') +
      content_tag(:ul, class: 'user-rounds-played') do
        user.rounds.order('date_played DESC').drop(1).collect { |r| concat(content_tag(:li, "<span class='user-all-score'>#{'%3d' % r.adjusted_score}</span> on <span class='user-all-tee'>#{r.tee.color}</span> at #{link_to r.club.name, club_path(r.club)} (#{r.date_played.strftime('%b %d, %Y')})".html_safe))}
      end
    end
  end

end
