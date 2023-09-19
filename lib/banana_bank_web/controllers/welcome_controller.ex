defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def index(conn, params) do    
    conn
    |> put_status(:ok)
    |> json(%{message: "NBem vino ao BananaBank", status: :ok})
  end
end
