def for_each_fruit(fridge)
  i = 0
  while i < fridge.length
    yield fridge[i] if fridge[i][:type] == 'fruit'
    i += 1
  end
end

myFridge = []
myFridge.push({ type: 'fruit', name: 'apple', qty: 4})
myFridge.push({ type: 'fruit', name: 'orange', qty: 2})
myFridge.push({ type: 'fruit', name: 'pear', qty: 3})
myFridge.push({ type: 'meat', name: 'rhino', qty: 1})
myFridge.push({ type: 'meat', name: 'beef', qty: 1})

for_each_fruit(myFridge) do |fruit|
  puts "internal iterator! fruit: #{fruit[:name]}, #{fruit[:qty]}"
end
