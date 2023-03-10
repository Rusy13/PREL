# frozen_string_literal: true

require 'date'

def validate_date(start_year, start_month, start_day)
  @y = start_year
  @m = start_month
  @d = start_day
  if Date.valid_date?(@y, @m, @d) 
    puts "дата в норме #{@y} #{@m} #{@d} "
  else
    abort "дата не в норме"
  end
  @data = Date.new(@y, @m, @d)
  @sdv = @d

end

def validate_period(input1)
  reg = /^\d{4}(M\d{1}(0|1|2)?(D\d{1,2})?)?$/
  if input1 =~ reg
    puts "Входные данные корректны"
  else
    abort "Ошибка: входные данные содержат недопустимые символы"
  end
end

def period(input1)
  regday = /.*M.*D.*|.*D.*M.*/
  regmon = /.*M.*/
  if input1 =~ regday
    puts "Входные day"
    day(input1)
  elsif input1 =~ regmon
    puts "Входные mon"
    month(input1)
  else
    puts "Входные year"
    year(input1)
  end
end

# проход по периодам
def prohod(array)
  arr = array
  arr.each do |item|
    if @f != 1
      validate_period(item)
      period(item)
    end
  end
end


def year(input1)
  @y = @data.year
  @m = @data.month
  @d = @data.day
  year = input1.slice(0, 4).to_i
  puts year
  if @y == year
    @data = (Date.new(@y, @m, @d).next_year)
    puts @data
  else
    @f = 1
    puts "Ошибка годов"
  end
  return
end

def month(input1)
  @y = @data.year
  @m = @data.month
  @d = @data.day
  curday = 0

  if input1[6] =~ /^[012]$/
    puts "Месяц двойной"
    month = input1.slice(5, 7).to_i
    puts month
    puts @m
    if @m == month
      @data.next_month
      @data = @data.next_month
      curday = @data.day
      curday += 1
      if Date.valid_date?(@data.year, @data.month, curday)
        while @data.day != @sdv
          @data += 1
        end
      end
      puts @data
    else
      @f = 1
      puts "Ошибка month"
    end
    puts "---------------------"
  else
    puts "Месяц одинарный"
    month = input1.slice(5, 6).to_i
    puts month
    puts @m
    if @m == month
      @data.next_month
      @data = @data.next_month
      curday = @data.day
      curday += 1
      if Date.valid_date?(@data.year, @data.month, curday)
        while @data.day != @sdv
          @data += 1
        end
      end
      puts(@data)
    else
      @f = 1
      puts ("Ошибка month")
    end
  end
end

def day(input1)
  @y=@data.year
  @m=@data.month
  @d=@data.day
  @data = (Date.new(@y,@m,@d).next_day)
  @sdv = @data.day

  if input1.length == 9
    puts "Day двойной"
    day = input1[-2..-1].to_i
    puts (day)
    puts (@d)
    if @d == day
      @data.next_day
      puts(@data)
    else
      @f = 1
      puts ("Ошибка Day")
    end
  else
    puts "Day одинар"
    puts input1
    day = input1[7].to_i
    puts (day)
    puts (@d)
    if @d == day
      @data.next_day
      puts(@data)
    else
      @f = 1
      puts ("Ошибка Day")
    end
  end
end

def initialize(periods, start)
  @periods = periods
  @start_date = start 
  @start_day, @start_month,@start_year = @start_date.split('.').map(&:to_i)
end

def main()
  start = "30.01.2020"
  periods = ["2020M1", "2020", "2021", "2022", "2023", "2024M2", "2024M3D29"]
  initialize(periods, start)
  @f = 0
  @sdv = @start_day
  validate_date(@start_year,@start_month,@start_day)
  prohod(periods)
  if @f == 0
    puts('------------------------------------')
    puts(true)
  else
    puts('------------------------------------')
    puts(false)
  end
end

main()