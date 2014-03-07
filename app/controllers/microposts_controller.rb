class MicropostsController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user,   only: :destroy

  def create
    @micropost = Micropost.create(micropost_params)
    if @micropost.save
    	@micropost.user = current_user
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

     def correct_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_url if @micropost.nil?
    end
end