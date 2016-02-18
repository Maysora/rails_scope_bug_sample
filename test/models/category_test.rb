require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test ".map_nested_names" do
    {
      a: %w(a1 a2 a3),
      b: %w(b1 b2)
    }.each do |k,v|
      c = Category.create! name: k
      v.each { |c2| c.children.create! name: c2 }
    end
    assert_equal Category.roots.includes(children: :children).map_nested_names_w, Category.roots.includes(children: :children).map_nested_names
  end
end
