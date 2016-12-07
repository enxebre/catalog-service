module CatalogApp
  module Products
    class TShirt
      attr_reader :name

      def initialize attributes
        @name = attributes[:name]
      end

      def == other
        other.is_a?(TShirt) && other.name == name
      end
    end
  end
end