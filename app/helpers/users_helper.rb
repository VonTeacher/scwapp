module UsersHelper

  def user_profile_handicap_index user
    if ( user.rounds.count < 4 )
      content_tag(:h3, "You need to enter #{5 - user.rounds.count} more rounds to obtain a handicap score.")
    elsif user.rounds.count == 4
      content_tag(:h3, "You need to enter one more round to obtain a handicap score.")
    else
      content_tag(:h3, "Handicap Index: ", class: 'user-profile-h3') +
      content_tag(:span, "#{user.handicap_index}", class: 'user-profile-hci')
    end
  end

  def user_add_new_round user
    if user == current_user
      content_tag(:span, class: 'user-add-round-button') do
        link_to 'Add a New Round', add_round_path(user)
      end
    end
  end

  def user_greeting user
    if user == current_user
      content_tag(:h2, "Hi&#44; #{user.username}!".html_safe, class: 'user-greeting')
    else
      content_tag(:h2, "Profile for #{user.username}")
    end
  end

  def user_profile_last_round user
    if user.rounds.empty?
      # content_tag(:h3, 'No rounds played.', class: 'user-profile-section-header')
    elsif user == current_user
      content_tag(:h3, 'Last Round Played:', class: 'user-profile-section-header inline-block') +
      content_tag(:span, link_to(' <i class="fas fa-edit"></i> (Edit) '.html_safe, edit_round_path(user.last_played), class: 'inline-block no-deco edit-function')) +
      content_tag(:span, link_to(' <i class="fas fa-trash-alt"></i> (Delete) '.html_safe, round_path(user.last_played.id), method: :delete)) +
      content_tag(:div, class: 'user-last-score-wrapper') do
        content_tag(:div, "<div class='user-last-ags'>#{user.last_played.adjusted_score}</div>".html_safe, class: 'user-last-inline user-last-right-buffer') +
        content_tag(:div, "<div class='user-last-tee'>#{user.last_played.tee.color}</div>
                           <div class='user-last-club'>#{user.last_played.club.name}</div>
                           <div class='user-last-date'>#{user.last_played.date_played.strftime('%b %d, %Y')}</div>".html_safe, class: 'user-last-inline')
      end
    else
      content_tag(:h3, 'Last Round Played:', class: 'user-profile-section-header') +
      content_tag(:div, class: 'user-last-score-wrapper') do
        content_tag(:div, "<div class='user-last-ags'>#{user.last_played.adjusted_score}</div>".html_safe, class: 'user-last-inline user-last-right-buffer') +
        content_tag(:div, "<div class='user-last-tee'>#{user.last_played.tee.color}</div>
                           <div class='user-last-club'>#{user.last_played.club.name}</div>
                           <div class='user-last-date'>#{user.last_played.date_played.strftime('%b %d, %Y')}</div>".html_safe, class: 'user-last-inline')
      end
    end
  end

  def user_profile_latest_n_rounds user
    if user.rounds.empty?
      content_tag(:h3, 'No rounds played.', class: 'user-profile-section-header')
    elsif user == current_user
      content_tag(:h3, "Previous Rounds Played:", class: 'user-profile-section-header inline-block') +
      content_tag(:ul, class: 'user-rounds-played') do
        user.rounds.order('date_played DESC').drop(1).collect { |r| concat(content_tag(:li, "<span class='user-all-score'>#{'%3d' % r.adjusted_score}</span> on <span class='user-all-tee'>#{r.tee.color}</span> at #{link_to r.club.name, club_path(r.club)} (#{r.date_played.strftime('%b %d, %Y')}) <span class='inline-block no-deco edit-function'>#{link_to '<i class="fas fa-edit"></i>'.html_safe, edit_round_path(r)}</span><span class='inline-block no-deco delete-function'>#{link_to '<i class="fas fa-trash-alt"></i>'.html_safe, round_path(r), method: :delete}</span>".html_safe))}
      end
    else
      content_tag(:h3, "Previous Rounds Played:", class: 'user-profile-section-header') +
      content_tag(:ul, class: 'user-rounds-played') do
        user.rounds.order('date_played DESC').drop(1).collect { |r| concat(content_tag(:li, "<span class='user-all-score'>#{'%3d' % r.adjusted_score}</span> on <span class='user-all-tee'>#{r.tee.color}</span> at #{link_to r.club.name, club_path(r.club)} (#{r.date_played.strftime('%b %d, %Y')})".html_safe))}
      end
    end
  end

end
