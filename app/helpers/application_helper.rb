module ApplicationHelper

  def birthday_format(date)
    Date.iso8601(date).strftime('%Y %B %e')
  end
end
