module EntriesHelper
  def month_start_date(year, month)
    Date.parse("#{year}-#{month}-01")
  end
  
  def month_end_date(year, month)
    Date.parse("#{year.to_i+month.to_i/12}-#{(month.to_i)%12+1}-01")-1.day
  end
  
  def year_start_date(year)
    Date.parse("#{year}-01-01")
  end
  
  def year_end_date(year)
    Date.parse("#{year.to_i+1}-01-01")-1.day
  end
end
