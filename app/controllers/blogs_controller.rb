class BlogsController < ApplicationController
  before_action :set_blog,only:[:show,:edit,:update,:destroy]
  before_action :login_sender,only:[:confirm,:index,:create,:new,:edit,:update,:destroy]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    @user = current_user
    @blog.user_id = current_user.id
    render :new if @blog.invalid?
  end

  def edit
  end

  def create

    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @current_user = current_user
    if @blog.save
      ContactMailer.contact_mail(@blog,@current_user).deliver
      redirect_to blogs_path,notice:"新規投稿しました！"
    else
      render 'new'
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path,notice:"投稿を編集しました！"
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path,notice:"投稿を削除しました！"
  end

private
  def blog_params
    params.require(:blog).permit(:image,:image_cache,:title,:content,:user_id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def login_sender
    if logged_in?
    else
      redirect_to new_session_path,notice:"Secondgramを使うにはログインしてください"
    end
  end

end
