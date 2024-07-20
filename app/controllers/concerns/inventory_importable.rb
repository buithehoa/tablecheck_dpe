require 'mime/types'
require 'csv'

module InventoryImportable
  def valid_csv?(file)
    tempfile = file&.tempfile
    mime_type = MIME::Types.type_for(tempfile&.path).first

    return tempfile.present? && mime_type == 'text/csv'
  end

  def import_inventory(csv_file)
    CSV.foreach(csv_file, headers: true) do |row|
      category = Category.find_or_create_by!(name: row[1])

      product = Product.find_or_initialize_by(name: row[0])
      product.category = category
      product.price = row[2]
      product.quantity = row[3]
      product.save!
    end
  rescue CSV::MalformedCSVError, Mongoid::Errors::MongoidError => e
    raise InventoryImportError, "Error importing inventory: #{e.message}"
  end
end
