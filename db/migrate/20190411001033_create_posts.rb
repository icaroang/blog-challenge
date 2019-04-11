class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :html_body
      t.text :markdown_body

      t.timestamps
    end
  end
end
