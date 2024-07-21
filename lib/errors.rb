module Errors
  class InventoryImportError < StandardError; end
  class InventoryShortageError < StandardError; end
  class NoCurrentOrderError < StandardError; end
  class OrderAlreadyPlacedError < StandardError; end
end
