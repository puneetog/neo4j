class SessionsController < ApplicationController

  def new
  end

  def create

    user = User.find(email: params[:session][:email].downcase)
    if user && User.encrypt_password(user.email, params[:session][:password]) == user.password
      # Sign the user in and redirect to the user's show page.
      sign_in user
      redirect_to user
    else
      # Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
  	sign_out
    redirect_to root_url
  end

  def confirm_user
    user = User.find(confirmation_token: params[:token])
    if user.present?
      user.confirmed_at = Time.now
      user.confirmation_token = ""
      user.save
      sign_in user
      redirect_to user
    else
      redirect_to root_path, notice: "Token is invalid"
    end
  end
end
