defmodule CacheDemo do
  defmodule Cache do
    use Nebulex.Cache,
      otp_app: :my_app,
      adapter: Nebulex.Adapters.Replicated
  end

  @moduledoc """
  Documentation for `CacheDemo`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CacheDemo.hello()
      :world

  """
  def hello do
    :world
  end
end
