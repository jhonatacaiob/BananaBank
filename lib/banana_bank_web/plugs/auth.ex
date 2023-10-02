defmodule BananaBankWeb.Plugs.Auth do
  import Plug.Conn
  alias BananaBankWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- Plug.Conn.get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      conn
      |> assign(:user_id, data.user_id)
    else
      _error ->
        conn
        |> send_resp(:unauthorized, ~s[{"message": "Unauthorized"}])
        |> halt()
    end
  end
end
