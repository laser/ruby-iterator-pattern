class FruitIterator
  def self.get_fruits(fridge)
    i = 0
    fruits = []
    while i < fridge.length
      fruits.push(fridge[i]) if fridge[i][:type] == 'fruit'
      i += 1
    end
    fruits
  end

  def initialize(fridge)
    @fruits = self.class.get_fruits(fridge)
    @index  = 0
  end

  def has_next?
    @index < @fruits.length
  end

  def get_next
    fruit = @fruits[@index]
    @index += 1
    fruit
  end

end

myFridge = []
myFridge.push({ type: 'fruit', name: 'apple', qty: 4})
myFridge.push({ type: 'fruit', name: 'orange', qty: 2})
myFridge.push({ type: 'fruit', name: 'pear', qty: 3})
myFridge.push({ type: 'meat', name: 'rhino', qty: 1})
myFridge.push({ type: 'meat', name: 'beef', qty: 1})

iterator = FruitIterator.new myFridge

while iterator.has_next?
  f = iterator.get_next
  puts "external iterator! fruit: #{f[:name]}, #{f[:qty]}"
end
