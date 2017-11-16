class PinsController < ApplicationController
    before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
    before_action :authenticate_user!, only: [:show, :edit, :update, :destroy, :upvote]
    before_action :correct_user, only: [:edit, :update]
    def index 
        if authenticate_user!
            @pins = Pin.all.order("created_at DESC")
        else
            redirect_to new_user_session_path
        end
    end

    def new 
        @pin = current_user.pins.build
    end

    def show
    end

    def create
        @pin = current_user.pins.build(pin_params)
        if @pin.save
            redirect_to @pin, notice: "Successfully created new Pin"
        else
            render 'new'
        end
    end

    def edit 
    end

    def update
        if @pin.update(pin_params)
            redirect_to @pin, notice: "Pin was Successfully updated!"
        else
            render 'edit'
        end
    end
    
    def destroy
        @pin.destroy
        redirect_to root_path
    end

    def upvote
        @pin.upvote_by current_user
        redirect_back fallback_location: root_path
    end

    private
    def pin_params
        params.require(:pin).permit(:title, :description, :image)
    end

    def find_pin
        @pin = Pin.find(params[:id])
    end

    def correct_user 
      @user = Pin.find(params[:id]).user
      redirect_to(root_url) unless (@user===current_user)
    end
end
