defmodule MyAppWeb.ReproLive do
  alias Phoenix.LiveView.AsyncResult
  use MyAppWeb, :live_view

  import MyAppWeb.CoreComponents, only: [button: 1]

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:data, AsyncResult.ok([]))}
  end

  def render(assigns) do
    dbg(assigns.data)

    ~H"""
    <div class="p-4">
      <p class="my-4">
        Click Load Data. 3 items should be displayed. Then click Remove First entry. The expected result is 2 items displayed.
      </p>
      <div class="grid grid-cols-2 gap-4">
        <.async_result :let={data} assign={@data}>
          <.live_component module={MyAppWeb.ReproLiveComponent} id="repro" data={data} />
        </.async_result>
        <!-- Uncomment this to get a different issue
        <.live_component
          module={MyAppWeb.ReproLiveComponentWithAsyncResult}
          id="repro_async"
          data={@data}
        />
        -->
      </div>
      <div class="my-4">
        <.button phx-click="load">Load data</.button>
        <.button phx-click="remove">Remove first entry</.button>
      </div>
    </div>
    """
  end

  def handle_event("load", _, socket) do
    socket =
      assign_async(socket, :data, fn ->
        Process.sleep(100)

        {:ok,
         %{data: [%{id: 1, value: "First"}, %{id: 2, value: "Second"}, %{id: 3, value: "Third"}]}}
      end)

    {:noreply, socket}
  end

  def handle_event("remove", _, socket) do
    socket =
      assign_async(socket, :data, fn ->
        Process.sleep(100)
        {:ok, %{data: [%{id: 2, value: "Second"}, %{id: 3, value: "Third"}]}}
      end)

    {:noreply, socket}
  end
end
