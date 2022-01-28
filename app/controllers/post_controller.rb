require 'Date'

class PostController < ApplicationController
  before_action :set_post, only: %i[ edit update delete ]

  def show
    @post = Post.select("id", "title", "content").where(id: post_params[:id], deleted_at: nil).take

    if(@post.present?)
      logger.debug "Found #{@post}"
      render json: @post.to_json(only: [:id, :title, :content])
    else
      logger.debug "Not found #{@post}"
      render json: { message: "Post with id #{post_params[:id]} not found" }, status: 404
    end
  end

  def list
    render json: Post.select("id", "title", "content").where(deleted_at: nil).all
  end

  def create
    logger.debug "Creating post..."
    @post = Post.new(post_params)
    logger.debug "Is saved: #{@post.save}"
    render json: @post
  end

  def delete
    @post.update(deleted_at: DateTime.now)
    #logger.debug "Is the post deleted: #{@post.save}"
    render json: "Deleted post with ID ##{@post.id}"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(post_params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.permit(:id, :title, :content)#.require(:id).permit(:id, :title, :content)
  end
end
