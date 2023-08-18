class RemoveOldReferenceFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :posts, :user, foreign_key: true
  end
end
