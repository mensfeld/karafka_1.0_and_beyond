class UsersEventsController < KarafkaController
  TRIGGER_TYPES = %w[
    video_viewed
    comment_added
  ]

  def perform
    @buffer ||= {}

    params_batch.each do |params|
      @buffer[params[:user_id]] ||= []
      @buffer[params[:user_id]] << params[:type]
    end

    users_ids = @buffer.select { |_k, v| (TRIGGER_TYPES - v).empty? }.keys
    users_ids.each { |id| @buffer.delete(id) }
    respond_with users_ids unless users_ids.empty?
  end
end
