class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog = current_user.blogs.build(blog_params)
      if params[:back]
        render :new
      else
        if @blog.save
          redirect_to blogs_path, notice: "ブログ作成完了！"
        else
          render :new
        end
      end
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  def show
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログ編集完了！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログ削除完了！"
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :user_id, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

end
