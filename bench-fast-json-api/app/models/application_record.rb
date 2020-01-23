class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def offset_object(params)
      offset(offset_per_page(params)).limit(PaginatorHelper::OBJECTS_PER_PAGE)
    end

    def offset_per_page(params)
      if params[:page].present? && params[:page].to_i.positive?
        (params[:page].to_i - 1) * PaginatorHelper::OBJECTS_PER_PAGE
      else
        0
      end
    end
  end
end
