module V1
  class ProductsController < ApplicationController
    rescue_from ::InventoryImportError, with: :handle_inventory_import_error

    include InventoryImportable

    def index
      products = Product.all
      render json: products, each_serializer: ProductSerializer
    end

    def show
    end

    def import
      if valid_csv?(params[:inventory])
        import_inventory(params[:inventory].tempfile)
        render json: { message: "Inventory imported successfully."}, status: :ok
      else
        render json: { message: "Please select a CSV file to import." }, status: :unprocessable_entity
      end
    end

    private

    def handle_inventory_import_error(exception)
      render json: { message: exception.message }, status: :unprocessable_entity
    end
  end
end
