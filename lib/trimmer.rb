module Trimmer
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def trim_fields(*fields)
      before_validation do
        fields.each do |field|
          self[field].squish! if self[field].respond_to?(:squish!)
        end
      end
    end
  end
end