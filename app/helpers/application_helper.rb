module ApplicationHelper
  def time_format(datetime)
    datetime.strftime('%d/%m/%Y') if datetime.present?
  end
end
