module AuthenticationCheck
  extend ActiveSupport::Concern
  
  def is_user_logged_in
    byebug
    if current_user.nil?
      render json: { message: "No user is authenticated." },
        status: :unauthorized
    end
  end
end