class Post < ApplicationRecord
  def deleted_at
    @deleted_at
  end

  def set_deleted_at(d_at)
    @deleted_at = d_at
  end
end
