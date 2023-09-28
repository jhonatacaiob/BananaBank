defmodule BananaBank.Users.Update do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> update(user, params)
    end
  end

  defp update(user, params) do
    with {:ok, _result} <- client().call(params["cep"]) do
      user
      |> User.changeset(params)
      |> Repo.update()
    end
  end

  defp client() do
    Application.get_env(:banana_bank, :via_cep_client, ViaCepClient)
  end
end
