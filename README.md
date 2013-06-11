Iterator Pattern
================

According to the GoF, the Iterator pattern provides:

> a way to access the elements of an aggregate object sequentially without
> exposing its underlying representation.

Functionally, this means that the consumer of the iterator gets a movable
reference to items inside of an otherwise-opaque object.

Types of Iterators
------------------

There are two types of iterators: External and Internal. With an External
iterator, the consumer gets hooks that allow it to move through the items
exposed by the iterator (with methods like "has_next" and "get_next"). The
Internal iterator, however, does the moving for you; you simply pass it a
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
  puts "External iterator! fruit: #{f[:name]}, #{f[:qty]}"
end

# results:
#
# External iterator! fruit: apple, 4
# External iterator! fruit: orange, 2
# External iterator! fruit: pear, 3
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
  puts "Internal iterator! fruit: #{fruit[:name]}, #{fruit[:qty]}"
end

# results:
#
# Internal iterator! fruit: apple, 4
# Internal iterator! fruit: orange, 2
# Internal iterator! fruit: pear, 3
```

External vs. Internal
---------------------

If the benefit of controlling iteration is outweighed by the overhead of
managing the state of the iterator - you may wish to simply use an Internal
iterator. If flexibility is paramount (and you find yourself needing or wanting
to control iteration explicitly) - then an External iterator may be for you.
