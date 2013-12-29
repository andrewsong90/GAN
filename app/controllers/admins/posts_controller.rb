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
			redirect_to admins_post_path(@post)
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		
	end

	def show
		@post=Post.find(params[:id])
	end

	private

	def post_params
		params.require(:post).permit(:content, :title)
	end

end
