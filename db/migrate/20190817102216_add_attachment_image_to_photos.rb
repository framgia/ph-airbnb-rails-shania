class AddAttachmentImageToPhotos < ActiveRecord::Migration[5.2]
  def up
    add_attachment :photos, :image
  end

  def down
    remove_attachment :photos, :image
  end
end
