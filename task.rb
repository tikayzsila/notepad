require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now

  end
  def read_from_console

    puts "Что нужно сделать?"
    @text = STDIN.gets.chomp

    puts "К каком числу? (указать в формате ДД.ММ.ГГГГ, например 31.01.2022 "
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    time_string = "Создано #{@created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")} \n\r \n\r"

    deadline = "Крайний срок: #{@due_date}"
    return[deadline, @text, time_string]
  end

  def to_db_hash
    return super.merge(
      {
        'text' => @text,
      'created_at' => @due_date.to_s
      }
    )
  end
  def load_data(data_hash)
    super(data_hash)
    @due_date = Date.parse(data_hash['due_date'])
  end
end