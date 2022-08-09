class NagerService

  def get_url
    binding.pry
    response = HTTParty.get("https://date.nager.at/api/v3/PublicHolidays/2022/US")
    JSON.parse(response.body, symbolize_names: true)
  end

end
