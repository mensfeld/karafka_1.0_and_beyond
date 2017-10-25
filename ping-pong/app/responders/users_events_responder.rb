class UsersEventsResponder < ApplicationResponder
  topic :users_engaged, required: true, multiple_usage: true

  def respond(users_ids)
    users_ids.each do |user_id|
      respond_to :users_engaged, user_id: user_id
    end
  end
end
