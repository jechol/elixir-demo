defmodule CounterWeb.CounterLive do
  use CounterWeb, :live_view

  def mount(_params, _session, socket) do
    region = System.get_env("FLY_REGION") || "local"

    if connected?(socket) do
      Phoenix.PubSub.subscribe(Counter.PubSub, "counter")
    end

    Agent.start(fn -> 0 end, name: {:global, :counter})
    count = Agent.get({:global, :counter}, fn x -> x end)

    {:ok, assign(socket, count: count, region: region)}
  end

  def render(assigns) do
    ~H"""
    <div class="container">
      <h3>Region: <%= assigns.region %></h3>
      <h1>Counter: <%= assigns.count %></h1>
      <button phx-click="increment">Increment</button>
      <button phx-click="decrement">Decrement</button>
    </div>
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
