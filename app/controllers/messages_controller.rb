class MessagesController < ApplicationController
  add_breadcrumb Proc.new{|c| c.t("messages.new.title")}, :new_message_path

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      AppMailer.support(@message).deliver 
      flash[:notice] = t("messages.successfully_create")
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
    
end
