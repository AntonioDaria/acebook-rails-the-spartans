class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(message: post_params[:message], user_id: current_user.id)
    redirect_to posts_url
  end

  def index
    @posts = Post.all.reverse
  end

  def show
    @posts = Post.find(params[:id])

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_url
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.update(post_params)
    redirect_to posts_url, notice: "Post updated!"
  end

  def like
    @user = current_user
    @post = Post.find(params[:id])
    @user.like!(@post)
    redirect_to posts_url
  end

  def unlike
    @user = current_user
    @post = Post.find(params[:id])
    @user.unlike!(@post)
    redirect_to posts_url
  end

  def feed_like
    @user = current_user
    @post = Post.find(params[:id])
    @user.like!(@post)
    redirect_to news_path
  end

  def feed_unlike
    @user = current_user
    @post = Post.find(params[:id])
    @user.unlike!(@post)
    redirect_to news_path
  end

  def feed
    @followed_ids = Follow.where(follower_id: current_user.id).map{|x| x.followable_id }
    @followed_posts = Post.all.order("created_at DESC").map{|x| @followed_ids.include?(x.user_id) ? x : nil}.compact
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end
end
