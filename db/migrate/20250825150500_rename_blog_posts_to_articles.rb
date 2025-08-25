class RenameBlogPostsToArticles < ActiveRecord::Migration[7.0]
  def change
    rename_table :blog_posts, :articles

    if index_name_exists?(:articles, "index_blog_posts_on_admin_id")
      rename_index :articles, "index_blog_posts_on_admin_id", "index_articles_on_admin_id"
    end
    if index_name_exists?(:articles, "index_blog_posts_on_slug")
      rename_index :articles, "index_blog_posts_on_slug", "index_articles_on_slug"
    end

    change_column_null :articles, :title, false
    change_column_null :articles, :body, false
    change_column_null :articles, :slug, false
    change_column_null :articles, :admin_id, false

    change_column_default :articles, :status, from: nil, to: "draft"
    change_column_null :articles, :status, false

    add_index :articles, [:status, :published_at]
    add_index :articles, :created_at
    add_index :articles, :updated_at

    enable_extension "pg_trgm" unless extension_enabled?("pg_trgm")
    enable_extension "btree_gin" unless extension_enabled?("btree_gin")
    add_index :articles, :tags, using: :gin
  end
end
