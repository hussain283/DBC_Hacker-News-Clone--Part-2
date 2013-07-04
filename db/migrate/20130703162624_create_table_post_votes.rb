class CreateTablePostVotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|
      t.integer :value, default: 0
      t.references :post
      t.references :user
      t.timestamps
    end

    create_table :comment_votes do |t|
      t.integer :value, default: 0
      t.references :comment
      t.references :user
      t.timestamps
    end
    
    add_index :comment_votes, [:user_id, :comment_id], :unique
    add_index :post_votes, [:user_id, :post_id], :unique

  end
end
