class ApplicationController < ActionController::API
  include Paginate
  before_action :authenticate_user!
  before_action :set_page

  def oj_optimize(object)
    Oj.optimize_rails
    Oj.dump(object, mode: :compat, time_format: :ruby, use_to_json: true)
  end

  def paginate_object(object)
    total_pages_result = total_pages(object)
    paginate_result = paginate(@page, object)
    { 
      total_pages: total_pages_result,
      data: paginate_result
    }
  end

  def set_page
    @page = params[:page].to_i <= 0 ? 1 : params[:page].to_i
  end

  def parse_date(arg)
    arg = arg.to_s.tr('"', '')
    if valid_date?(arg)
      Date.strptime(arg, '%Y-%m-%d')
    else
      nil
    end
  rescue ArgumentError
    nil
  end

  def valid_date?(arg)
    /^[0-9]{4}\-[0-9]{1,2}\-[0-9]{1,2}$/.match(arg).present?
  end
end
