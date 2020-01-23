# frozen_string_literal: true

module PaginatorHelper
  OBJECTS_PER_PAGE = 10.0

  def links(path, params, total_elements)
    page = params.fetch(:page, 1).to_i
    last_page = total_pages(total_elements)
    result = {}

    params = { from: params[:from], to: params[:to], sort_by: params[:sort_by], order: params[:order],
               search: params[:search], date: params[:date] }

    result[:first] = Rails.application.routes.url_helpers.send(path, params.merge(page: 1))
    result[:last] = Rails.application.routes.url_helpers.send(path, params.merge(page: last_page))
    result[:self] = Rails.application.routes.url_helpers.send(path, params.merge(page: page))
    if page * OBJECTS_PER_PAGE < total_elements
      result[:next] = Rails.application.routes.url_helpers.send(path, params.merge(page: page + 1))
    end
    if page > 1
      result[:prev] = Rails.application.routes.url_helpers.send(path, params.merge(page: page - 1))
    end
    result
  end

  def meta_data(total_elements, params)
    {
      total_elements: total_elements,
      total_pages: total_pages(total_elements),
      current_page: params.fetch(:page, 1).to_i,
      objects_per_page: OBJECTS_PER_PAGE
    }
  end

  def total_pages(total_elements)
    total_elements.zero? ? 1 : (total_elements/OBJECTS_PER_PAGE).ceil
  end
end
