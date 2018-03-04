class AddTagToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :tag, :text, array: true, default:[]
  end
end
