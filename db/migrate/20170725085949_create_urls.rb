class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :real_url
      t.string :awesome_url
      t.timestamps
    end
  end
end
