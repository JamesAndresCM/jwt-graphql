class ApplicationController < ActionController::API
  before_action :authenticate_user!

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
