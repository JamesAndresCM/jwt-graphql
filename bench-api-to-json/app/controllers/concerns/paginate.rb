module Paginate
  PER = 10
  extend ActiveSupport::Concern
  def paginate(page, obj)
    begin
      obj.slice(PER * (page - 1) || 0, PER || obj.length) || []
    rescue StandardError
      puts "#{obj} is not array"
    end
  end

  def total_pages(obj)
    total = (obj.count / PER)
    total_pages = obj.count % PER != 0 ? total + 1 : total
    total_pages.to_i
  end
end
