class AddArticleFieldsToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :slug, :string
    add_index  :blog_posts, :slug, unique: true

    add_column :blog_posts, :status, :string
    add_column :blog_posts, :published_at, :datetime
    add_column :blog_posts, :excerpt, :text
    add_column :blog_posts, :reading_time, :integer

    add_column :blog_posts, :tags, :string, array: true, default: []
  end
end
