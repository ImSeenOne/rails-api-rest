module UserManager
  def self.get_by_id(id)
    User.select("id", "username", "name", "lastname").where(id: id, deleted_at: nil).take
  end

  def self.get_by_username(username)
    User.select("id", "username", "name", "lastname").where(username: username, deleted_at: nil).take
  end

  def self.create(id, username, password, password_confirmation, name, lastname, bio)
    params = {username: username, password: password, password_confirmation: password_confirmation, name: name, lastname: lastname, bio: bio}
    User.create(params)
  end

  def self.delete(id)
    @user = UserManager.get_by_id(id)
    @user.update(deleted_at: DateTime.now)
    saved = @user.save
    (saved) ? @post : false
  end

  def self.get_all()
    User.select("id", "username", "name", "lastname").where(deleted_at: nil).all
  end

  def self.get_all_no_restrictions()
    User.all
  end
end