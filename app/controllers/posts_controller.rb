class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.order("id DESC").all

		if user_signed_in?
			@post = current_user.posts.build
		else
			render "New"
		end
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to action: "index"
		else
			render "New"
		end
	end

	def edit
		if @post.update(post_params)
			redirect_to @post
		else
			render "Edit"
		end
	end

	def update
	end

	def destroy
		@post.destroy
		redirect_to :back
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end

	def find_post
		@post = Post.find(params[:id])
	end

end
