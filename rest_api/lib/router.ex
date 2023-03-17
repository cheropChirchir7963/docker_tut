defmodule RestApi.Router do
  # Bring Plug.Router module into scope
  use Plug.Router

  # Attach the Logger to log incoming requests
  plug(Plug.Logger)

  # Tell Plug to match the incoming request with the defined endpoints
  plug(:match)

  # Once there is a match, parse the response body if the content-type
  # is application/json. The order is important here, as we only want to
  # parse the body if there is a matching route.(Using the Jayson parser)
  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  # Dispatch the connection to the matched handler
  plug(:dispatch)

  # Handler for GET request with "/" path
  get "/" do
    send_resp(conn, 200, "OK")
  end

  # define the endpoint for /animations
  get "/animations" do
    # Send the response
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(animations()))
  end

  get "/animations/:id/show" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(animation(conn.params["id"])))
  end

  defp animation(id) do
    MyApp.Repo.get(MyApp.Animation, id)
    |> Map.delete("__meta__")
  end

  # query the database for all animations
  defp animations do
    MyApp.Repo.all(MyApp.Animation)
  end

  # Fallback handler when there was no match
  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
