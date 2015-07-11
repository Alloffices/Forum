class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	
	def index
		@posts =Post.all.order("created_at DESC")
	end

	def new
		# building ou tthe post from the current user
		@post = current_user.posts.build
	end

	def create

		# building ou tthe post from the current user
		# Keep the post_params to permit title: and content:
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @post.update(params[:post].permit(:title, :content))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end


	def post_params
		params.require(:post).permit(:title, :content)
	end


end
