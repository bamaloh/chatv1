class ChatController < ApplicationController
  def index
    session['session_id'] = 1
    session['user_id'] = 1
    
    @chats = Chat.where("session_id = 1").order("created_at ASC")

  end
  def post
    @text = params[:user_msg]
    # render json: @text
    @msg = Chat.new

    # create_table "chats", force: :cascade do |t|
    #   t.integer "session_id"
    #   t.integer "from_id"
    # end






    @msg = Chat.new
    @msg.content = params['user_msg']
    @msg.session_id = 1
    @msg.from_id = 1
    @msg.save

    # if @msg.save
    #   flash[:notice] = "Successfully created post!"
    #   redirect_to post_path(@msg)
    # else
    #   flash[:alert] = "Error creating new post!"
    #   render :new
    # end
    render plain: @text
  end
end
