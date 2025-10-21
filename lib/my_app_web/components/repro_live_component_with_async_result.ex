defmodule MyAppWeb.ReproLiveComponentWithAsyncResult do
  use MyAppWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.async_result :let={data} assign={@data}>
        <p :for={item <- data} :key={item.id}>{item.value}</p>
      </.async_result>
    </div>
    """
  end

  def handle_event(_, _, socket) do
    {:noreply, socket}
  end
end
