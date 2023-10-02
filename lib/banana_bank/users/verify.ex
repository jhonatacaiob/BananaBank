defmodule BananaBank.Users.Verify do
  alias BananaBank.Users
  alias Users.User
  alias BananaBank.Repo

  def call(%{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> verify(user, password)
    end
  end

  defp verify(user, password) do
    case Pbkdf2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end
