class AddAttachmentImageToPins < ActiveRecord::Migration[4.2]
  def self.up
    change_table :pins do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :pins, :image
  end
end
