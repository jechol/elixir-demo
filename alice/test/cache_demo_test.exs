defmodule CacheDemoTest do
  use ExUnit.Case
  doctest CacheDemo

  test "greets the world" do
    assert CacheDemo.hello() == :world
  end
end
