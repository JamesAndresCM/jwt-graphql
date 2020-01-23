class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_for_authentication(email: params[:email])
    render json: {} and return unless user

    is_valid_for_auth = user.valid_for_authentication? { user.valid_password?(params[:password]) }
    if is_valid_for_auth 
      render json: { 
        user: {
          id: user.id,
          user: user.name,
          email: user.email,
          token: user.token
        }
      }
    else
      bad_request
    end
  end

  def new
    head :ok
  end

  private
  
  def bad_request
    render json: { status: 401, msg: "Invalid email address or password" }
  end
end
