module V1
  class ProductsController < ApplicationController
    include InventoryImportable

    rescue_from Errors::InventoryImportError, with: :handle_inventory_import_error

    def index
      products = Product.all
      render json: products, each_serializer: ProductSerializer
    end

    def show
      @product = Product.find(BSON::ObjectId(params[:id]))
      render json: @product, serializer: ProductSerializer
    end

    def import
      if valid_csv?(params[:inventory])
        import_inventory(params[:inventory].tempfile)
        render json: { message: "Inventory imported successfully."}, status: :ok
      else
        render json: { message: "Please select a CSV file to import." }, status: :unprocessable_entity
      end
    end
  end
end
