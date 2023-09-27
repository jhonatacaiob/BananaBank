defmodule BananaBank.Factory do
  use ExMachina.Ecto, repo: BananaBank.Repo

  alias BananaBank.Users.User

  def user_factory do
    password = sequence("password")

    %User{
      name: "Joao Silva",
      email: sequence(:email, &"email-#{&1}@example.com"),
      cep: sequence(:cep, &"#{&1}", start_at: 10_000_000),
      password: password,
      password_hash: Pbkdf2.hash_pwd_salt(password)
    }
  end

  def user_create_factory(attrs) do
    %{
      name: Map.get(attrs, :name, "Joao Silva"),
      email: Map.get(attrs, :email, sequence(:email, &"email-#{&1}@example.com")),
      cep: Map.get(attrs, :cep, sequence(:cep, &"#{&1}", start_at: 10_000_000)),
      password: Map.get(attrs, :password, sequence("password"))
    }
  end
end
