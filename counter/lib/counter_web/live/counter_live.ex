defmodule CounterWeb.CounterLive do
  use CounterWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Counter.PubSub, "counter")
    end

    Agent.start(fn -> 0 end, name: {:global, :counter})
    count = Agent.get({:global, :counter}, fn x -> x end)
    {:ok, assign(socket, count: count)}
  end

  def render(assigns) do
    ~H"""
    <h1>Counter: <%= assigns.count %></h1>
    <button phx-click="increment">Increment</button>
    <button phx-click="decrement">Decrement</button>
    """
  end

  def handle_event("increment", _params, socket) do
    count = Agent.get_and_update({:global, :counter}, fn x -> {x + 1, x + 1} end)
    Phoenix.PubSub.broadcast(Counter.PubSub, "counter", {:count, count})
    {:noreply, assign(socket, count: count)}
  end

  def handle_event("decrement", _params, socket) do
    count = Agent.get_and_update({:global, :counter}, fn x -> {x - 1, x - 1} end)
    Phoenix.PubSub.broadcast(Counter.PubSub, "counter", {:count, count})
    {:noreply, assign(socket, count: count)}
  end

  def handle_info({:count, count}, socket) do
    {:noreply, assign(socket, count: count)}
  end
end
