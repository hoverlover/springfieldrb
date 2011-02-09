class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :github_username
      t.string :twitter_username

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
