# frozen_string_literal: true

RSpec.describe EasyHash do
  it "has a version number" do
    expect(EasyHash::VERSION).not_to be nil
  end

  it "converts each element of array into EasyHash object" do
    object_array = EasyHash::HashToObject.new({}).send(
      :convert_to_array_of_objects, [{ foo: :bar }, { foo2: :bar2 }]
    )

    expect(object_array[0].class.name).to eq('EasyHash::HashToObject')
    expect(object_array[0].foo).to eq(:bar)
    expect(object_array[1].class.name).to eq('EasyHash::HashToObject')
    expect(object_array[1].foo2).to eq(:bar2)
  end

  it "converts HashToObject to a real hash" do
    expected_hash = { foo: :bar }

    expect(EasyHash::HashToObject.new(expected_hash).to_h).to eq(expected_hash)
  end

  it "converts hash into HashToObject and access each value as a method" do
    hash = {
      person: {
        name: 'John',
        age: 30,
        children: [
          { name: 'John Jr', age: 5 },
          { name: 'Johana', age: 2 }
        ]
      }
    }

    easy_hash = EasyHash::HashToObject.new(hash)

    expect(easy_hash.person.name).to eq('John')
    expect(easy_hash.person.age).to eq(30)
    expect(easy_hash.person.children[0].name).to eq('John Jr')
    expect(easy_hash.person.children[0].age).to eq(5)
    expect(easy_hash.person.children[1].name).to eq('Johana')
    expect(easy_hash.person.children[1].age).to eq(2)
  end
end
