class UsersEngagedController < KarafkaController
  BATCH_SIZE = 100

  def perform
    @buffer ||= []
    @buffer += params_batch.map { |params| params[:user_id] }
    @buffer.uniq!

    return if @buffer.size < BATCH_SIZE

    engaged_users_ids = @buffer.shift(BATCH_SIZE)
    # Mailing::DeliverEngagementEmail.call(users_ids: engaged_users_ids)
    Karafka.logger.fatal "Sent thanks note to users: #{engaged_users_ids}"
  end
end
