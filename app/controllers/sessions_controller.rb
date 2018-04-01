class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      jwt = JsonWebToken.encode({ user_id: user.id })
      render json: { jwt: jwt }, status: :created
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

    def session_params
      params.require(:session).permit(:email, :password, :remember_me)
    end
end
