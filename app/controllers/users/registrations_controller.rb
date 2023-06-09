class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def sign_up(resource_name, resource)
  #by pass the session store on the default implementation
    sign_in resource, store: false
  end
  
  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }, status: :created
  end

  def register_failed
    render json: { message: "Something went wrong." }, status: :bad_request
  end
end