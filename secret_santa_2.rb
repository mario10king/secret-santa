require 'twilio-ruby'

class SecretSanta
  def initialize
    @arr = []
    puts "How many people"
    @amount = gets.chomp
    get_names
  end

  def get_names
    i = 0
    while i < @amount.to_i
      puts "what is your name"
      name = gets.chomp
      puts "what is your number"
      number = gets.chomp
      @arr << {name: name, number: number}
      i+=1
    end
    assign
  end

  def assign
    pick = @arr.dup
    amount = @amount.to_i
    i = 0
    draw = {}
    while i < amount
      person = @arr[rand(@arr.length)]
      if pick[i][:name] != person[:name]
        draw[pick[i]] = person
        @arr.delete(person)
        i += 1
      elsif pick[i][:name] == person[:name] && i == amount - 1
        exchange = pick[rand(amount-2)]
        draw[pick[i]] = draw[exchange]
        draw[exchange] = pick[i]
        i+=1 
      end
    end
    go_through(draw)
  end

  def go_through(draw)
    draw.each do |key, value|
      text_message = value[:name]
      to_number = key[:number]
      text(text_message, to_number)
    end
  end
  def text(text_message, to_number)
    account_sid = "ACd24ef9205027bbd1971cfdaf33a620d6"
    auth_token = "8cebd5d8adf626238ac2f92f074c01cd"

    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.messages.create(
      body: text_message,
      to: "+1"+to_number,
      from: "+12136993773")
    
  end
end

SecretSanta.new()
