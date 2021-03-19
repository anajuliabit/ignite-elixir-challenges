defmodule ReportsGenerator do

  alias ReportGenerator.Parser

  @persons [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Jakeliny",
    "Cleiton",
    "Diego",
    "Joseph",
    "Rafael",
    "Danilo",
    "Vinicius"
  ]

  @months [
     janeiro: 1,
     fevereiro: 2,
     março: 3,
     abril: 4,
     maio: 5,
     junho: 6,
     julho: 7,
     agosto: 8,
     setembro: 9,
     outubro: 10,
     novembro: 11,
     dezembro: 12,
  ]

  @years [
    2016,
    2017,
    2018,
    2019,
    2020,
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  defp sum_values([name, day_hours, _day, month, year], %{:all_hours => hours, :hours_per_month => months, :hours_per_year => years} = report) do
    hours = Map.put(hours, name, hours[name] + day_hours)

    person_months = calculate_hours_per_month(months[name], month, day_hours)
    months = Map.put(months, name, person_months)

    person_years = years[name]
    person_years = Map.put(person_years, year, person_years[year] + day_hours)
    years = Map.put(years, name, person_years)

    %{report | :all_hours => hours, :hours_per_month => months, :hours_per_year => years }
 end

 defp calculate_hours_per_month(months, month, day_hours) do
    current_month = Enum.find(@months, fn {_k, v } -> v == month end)
    {key, _v} = current_month
    Map.put(months,  key, months[key] + day_hours)
 end

  defp report_acc do
    hours = Enum.into(@persons, %{}, &{&1, 0})

    months_format = Enum.map(@months, fn {k, _v} -> k end)
    months = Enum.into(@persons, %{}, fn person -> {person, Enum.into(months_format, %{}, &{&1, 0})} end)

    years = Enum.into(@persons, %{}, fn person -> {person, Enum.into(@years, %{}, &{&1, 0})} end)

    %{:all_hours => hours, :hours_per_month => months, :hours_per_year => years}
  end

end
