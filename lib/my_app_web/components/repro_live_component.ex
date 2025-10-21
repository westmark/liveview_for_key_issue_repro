defmodule MyAppWeb.ReproLiveComponent do
  use MyAppWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <p :for={item <- @data} :key={item.id}>{item.value}</p>
    </div>
    """
  end

  def handle_event(_, _, socket) do
    {:noreply, socket}
  end
end
