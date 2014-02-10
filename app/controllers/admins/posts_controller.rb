class Admins::PostsController < ApplicationController

	before_filter :authenticate_admin, :except => [:show,:index]
	
	def index
		@posts=Post.all.order("created_at DESC")	
	end

	def new
		@post=Post.new
	end

	def create
		@post=Admin.find(current_user.id).posts.build(post_params)

		if @post.save
			UserMailer.delay.announcement_email(@post)
			redirect_to admins_post_path(@post)
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.update_attributes(post_params)
		if @post.save
			flash[:notice] = "Post successfully updated"
			redirect_to admins_post_path(@post)
		else
			render 'edit'
		end
	end

	def show
		@post=Post.find(params[:id])
	end

	def destroy
		@post=Post.find(params[:id])
		if @post.destroy
			flash[:notice] = "Post successfully deleted"
			redirect_to admins_posts_path
		else
			flash[:error] = "Post could not be deleted"
			redirect_to admins_post_path(@post)
		end
	end

	private

	def post_params
		params.require(:post).permit(:content, :title)
	end

end
