defmodule BananaBank.Users do
  alias BananaBank.Users.Create
  alias BananaBank.Users.Get

  defdelegate create(params), to: Create, as: :call
  defdelegate get(params), to: Get, as: :call
end
