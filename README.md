Iterator Pattern
================

According to the GoF, the Iterator pattern provides:

> a way to access the elements of an aggregate object sequentially without
> exposing its underlying representation.

Functionally, this means that the consumer of the iterator gets a movable
reference to items inside of an otherwise-opaque object.

Types of Iterators
------------------

There are two types of iterators: External and Internal. With an external
iterator, the consumer gets hooks that allow it to move through the items
exposed by the iterator (with methods like "has_next" and "get_next"). The
internal iterator, however, does the moving for you; you simply pass it a
block and it'll yield as many times as it sees fit.

External Iterator Example
-------------------------

```ruby

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
  puts "fruit: #{f[:name]}, #{f[:qty]}"
end
```

Internal Iterator Example
-------------------------

```ruby

myFridge = []
myFridge.push({ type: 'fruit', name: 'apple', qty: 4})
myFridge.push({ type: 'fruit', name: 'orange', qty: 2})
myFridge.push({ type: 'fruit', name: 'pear', qty: 3})
myFridge.push({ type: 'meat', name: 'rhino', qty: 1})
myFridge.push({ type: 'meat', name: 'beef', qty: 1})

def for_each_fruit(fridge)
  i = 0
  while i < fridge.length
    yield fridge[i] if fridge[i][:type] == 'fruit'
    i += 1
  end
end

for_each_fruit(myFridge) do |fruit|
  puts "internal iterator! fruit: #{fruit[:name]}, #{fruit[:qty]}"
end

```

External vs. Internal
---------------------

Use the external iterator if you need to control the iteration from the
consumer - since you have the tools to stop iteration at any time. A use-case
presented in Russ Olsen's book (Ruby Design Patterns) was the merging of two
sorted arrays. You'd need to step through each array's contents sequentially
and simultaneously - which would be difficult (if not impossible) to do using
internal iteration.

Use the internal iteration if you don't need to control iteration from the
outside.
