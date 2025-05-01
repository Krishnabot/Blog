class AddAdminIdToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :admin_id, :integer
    add_foreign_key :blog_posts, :admins
    add_index :blog_posts, :admin_id
  end
end
