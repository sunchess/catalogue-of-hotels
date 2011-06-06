class CommentsController < InheritedResources::Base
  belongs_to :place, :hotel, :polymorphic => true, :optional => true
  load_and_authorize_resource :comment, :through => [:place, :hotel]

  before_filter :set_cookie_user_name, :only => :create

  def create
    resource.user = current_user
    create!(:notice => t("comments.successfully_create")) { parent_url(:anchor => "comment_#{resource.id}") }
  end

  private 
  def set_cookie_user_name
    cookies[:comment_user_name] = { :value => params[:comment][:user_name], :expires => 3.month.from_now }
  end

end
