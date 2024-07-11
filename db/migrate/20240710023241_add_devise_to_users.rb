class AddDeviseToUsers < ActiveRecord::Migration[6.1]
  def self.up
    # Check if the column does not exist before adding it
    unless column_exists?(:users, :email)
      add_column :users, :email, :string, null: false, default: ""
      add_index :users, :email, unique: true
    end

    unless column_exists?(:users, :encrypted_password)
      add_column :users, :encrypted_password, :string, null: false, default: ""
    end

    unless column_exists?(:users, :reset_password_token)
      add_column :users, :reset_password_token, :string
      add_column :users, :reset_password_sent_at, :datetime
      add_index :users, :reset_password_token, unique: true
    end

    # Uncomment any other Devise modules as needed
    # unless column_exists?(:users, :confirmation_token)
    #   add_column :users, :confirmation_token, :string
    #   add_column :users, :confirmed_at, :datetime
    #   add_column :users, :confirmation_sent_at, :datetime
    # end

    # unless column_exists?(:users, :unlock_token)
    #   add_column :users, :unlock_token, :string
    #   add_column :users, :locked_at, :datetime
    # end

    # Uncomment and modify as per your Devise configuration
  end

  def self.down
    # To roll back, you would typically remove what you added in `self.up`
    remove_column :users, :email if column_exists?(:users, :email)
    remove_column :users, :encrypted_password if column_exists?(:users, :encrypted_password)
    remove_column :users, :reset_password_token if column_exists?(:users, :reset_password_token)
    remove_column :users, :reset_password_sent_at if column_exists?(:users, :reset_password_sent_at)
    # Add removal for other columns if needed
  end
end
