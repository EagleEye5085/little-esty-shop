require 'date'
class NagerSearch

  def service
    NagerService.new
  end

  def holiday_list
    @_holidays = service.get_url.map do |holiday|
      if holiday[:date] > Date.today.to_s
        Holiday.new(holiday)
      end
    end.compact
  end

  def next_3_holidays
    holiday_list.first(3)
  end

end
