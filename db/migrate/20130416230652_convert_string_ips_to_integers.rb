class ConvertStringIpsToIntegers < ActiveRecord::Migration

  def ip_to_string(address)
    ip = address
    return nil unless ip
    ip += 4_294_967_296 if ip < 0 # Convert from 2's complement
    "#{(ip & 0xFF000000) >> 24}.#{(ip & 0x00FF0000) >> 16}.#{(ip & 0x0000FF00) >> 8}.#{ip & 0x000000FF}"
  end

  def up
    User.find_each do |user|
      user.current_sign_in_ip = user.read_attribute(:current_sign_in_ip) if user.read_attribute(:current_sign_in_ip)
      user.last_sign_in_ip = user.read_attribute(:last_sign_in_ip) if user.read_attribute(:last_sign_in_ip)
      user.save!
    end
    change_column :users, :current_sign_in_ip, :integer
    change_column :users, :last_sign_in_ip,    :integer
  end

  # Before rollback can occur, the IP conversion functions will need to be removed/commented out from the user model

  def down
    change_column :users, :current_sign_in_ip, :string
    change_column :users, :last_sign_in_ip,    :string
    User.find_each do |user|
      user.current_sign_in_ip = ip_to_string(user.read_attribute(:current_sign_in_ip).to_i) if user.read_attribute(:current_sign_in_ip)
      user.last_sign_in_ip = ip_to_string(user.read_attribute(:last_sign_in_ip).to_i) if user.read_attribute(:last_sign_in_ip)
      user.save!
    end
  end
end
