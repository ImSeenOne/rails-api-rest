require_relative '../managers/post_manager'
require 'colorize'

class PostController < ApplicationController
  before_action :set_post, only: %i[ edit update delete ]

  def show
    logger.info "Entered to post#show".colorize(:light_magenta)
    @post = PostManager.get_by_id(post_params[:id])
    if(@post.present?)
      logger.debug "Found #{@post}".colorize(:yellow)
      render json: @post.to_json(only: [:id, :title, :content])
    else
      logger.debug "Not found post with id: #{post_params[:id]}".colorize(:red)
      render json: { message: "Post with id #{post_params[:id]} not found" }, status: 404
    end
  end

  def list
    logger.info "Entered to post#list".colorize(:light_magenta)
    render json: PostManager.getAll
  end

  def create
    logger.info "Entered to post#create".colorize(:light_magenta)
    logger.debug "Creating post...".colorize(:yellow)
    @post = PostManager.create(post_params[:title], post_params[:content]).present?
    if(@post.present?)
      logger.debug "Post created succesfully".colorize(:green)
      render json: {message: "Post created succesfully"}
    else
      logger.debug "An error has occurred, post \"#{post_params[:title]}\" couldn't be created".colorize(:red)
      render json: {message: "An error has occurred, post '#{post_params[:title]}' couldn't be created"}
    end
  end

  def delete
    logger.info "Entered to post#delete".colorize(:light_magenta)
    @post = PostManager.delete(post_params[:id])
    if(@post.present?)
      logger.debug "Post ##{@post.id} deleted succesfully".colorize(:green)
      render json: {message: "Post ##{@post.id} deleted succesfully"}
    else
      logger.debug "Post ##{@post.id} couldn't be deleted".colorize(:red)
      render json: {message: "Post ##{@post.id} couldn't be deleted"}, status: 500
    end
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
