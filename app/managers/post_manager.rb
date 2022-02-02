module PostManager
  def self.get_by_id(id)
    return Post.select("id", "title", "content").where(id: id, deleted_at: nil).take
  end

  def self.create(title, content)
    params = {:title => title, :content => content}
    @post = Post.new(params)
    saved = @post.save
    (saved) ? @post : false
  end

  def self.delete(id)
    @post = PostManager.get_by_id(id)
    @post.update(deleted_at: DateTime.now)
    saved = @post.save
    (saved) ? @post : false
  end

  def self.get_all()
    Post.select("id", "title", "content").where(deleted_at: nil).all
  end

  def self.get_all_no_restrictions()
    Post.all
  end
end