# coding: utf-8
require_relative "toto"
require "test/unit"

class TestToto < Test::Unit::TestCase
  def test_simple
    a = {a: "a1", b: "b", d: "same"}
    b = {a: "a2", c: "c", d: "same"}
    assert_equal deep_diff(a, b), {
                   [:a] => ["a1", "a2"],
                   [:b] => ["b", nil],
                   [:c] => [nil, "c"],
                 }
  end

  def test_nested_array
    a = {foo: [0, 2]}
    b = {foo: [1, 2, 4]}
    assert_equal deep_diff(a, b), {[:foo, 0] => [0, 1],
                                   [:foo, 2] => [nil, 4]}
  end

  def test_nested_array_inside_hash
    a = {foo: [{bar: "a", baz: "bazA"}]}
    b = {foo: [{bar: "b", baz: "bazB"}]}
    assert_equal deep_diff(a, b), {
                   [:foo, 0, :bar] => ["a", "b"],
                   [:foo, 0, :baz] => ["bazA", "bazB"],
                 }
  end

  def test_differente_sub_structure
    a = {foo: "bar"}
    b = {foo: {bar: "boo"}}
    assert_equal deep_diff(a, b), {
                   [:foo] => ["bar", {bar: "boo"}],
                 }
  end

end
