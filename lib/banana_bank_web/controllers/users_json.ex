defmodule BananaBankWeb.UsersJSON do
  def create(%{user: user}) do
    %{
      message: "User criado com sucesso!",
      data: user
    }
  end

  def delete(%{user: user}), do: %{message: "User excluido com sucesso", data: user}
  def get(%{user: user}), do: %{data: user}
  def update(%{user: user}), do: %{message: "User alterado com sucesso", data: user}
end
