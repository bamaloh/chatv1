class ChatController < ApplicationController
  def index


    @chats = Chat.where("session_id = #{cookies["Chat_Session_id"]}").order("created_at ASC")

  end
  def post
    @text = params[:user_msg]
    @msg = Chat.new
    @msg.content = params['user_msg']
    @msg.session_id = cookies["Chat_Session_id"]
    @msg.from_id = cookies["user_id"]
    @msg.save
    render plain: @text
  end

  def bot_response

    @requestpath = "https://api.wit.ai/converse?v=20170307"
    @requestpath += "&session_id="+cookies['Chat_Session_id'].to_s
    @response = nil

    if params[:user_msg].present?


      @requestpath += "&q="+params[:user_msg]
      begin
        response = RestClient.post( @requestpath, nil, { :Authorization => "Bearer HXGME3UGIAH4JMHRRND76DPWKWPVHGF3" } )
        @response = response.body

        p "==============DETERMINE USER RESPONSE============="

        p @response

        p "==============DETERMINE USER RESPONSE============="

      rescue RestClient::ExceptionWithResponse => error
        error.response.body
        p error.response.body
      end


    else


        begin
          response = RestClient.post( @requestpath, nil, { :Authorization => "Bearer HXGME3UGIAH4JMHRRND76DPWKWPVHGF3" } )
          @response = response.body
          p @response
          @json = JSON.parse(@response)
          if @json["msg"].present?
            @text = params[:bot_msg]
            @msg = Chat.new
            @msg.content = @json["msg"]
            @msg.session_id = cookies["Chat_Session_id"]
            @msg.from_id = 0
            @msg.save
          end
        rescue RestClient::ExceptionWithResponse => error
          error.response.body
          p error.response.body
        end

    end

    render :json => @response
  end

  def simple_post
    # https://api.wit.ai/converse?v=20170307&session_id=123abc&q=weather%20in%20Brussels'
    @requestpath = "https://api.wit.ai/converse?v=20170307"
    @requestpath += "&session_id="+cookies['Chat_Session_id']
    @requestpath += "&q="+params[:msg]
    @response = nil
    # @payload = {'msg' => params[:msg]}
    begin
      # response = RestClient.post( @requestpath, @payload, { :Authorization => "Bearer BQLJZZGWNZEIH752GVSDE2SABY2TBGWA" } )
      response = RestClient.post( @requestpath, { :Authorization => "Bearer BQLJZZGWNZEIH752GVSDE2SABY2TBGWA" } )
      @response = response.body
      p "=============================================="
      p @response
      p "=============================================="
    rescue RestClient::ExceptionWithResponse => error
      error.reponse.body
    end
    render :json => @response
  end

  def simple_get
    @requestpath = "localhost:3000/chat"
    @requestpath += "params="+params["params"]
    @response = nil
    begin
      response = RestClient.get( @requestpath )
      @reesponse = response..body
    rescue RestClient::ExceptionWithResponse => error
      error.response.body
    end
    render :json => @response
  end
end
