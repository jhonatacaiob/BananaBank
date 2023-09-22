defmodule BananaBank.Users do
  alias BananaBank.Users.Create
  alias BananaBank.Users.Get
  alias BananaBank.Users.Update
  alias BananaBank.Users.Delete

  defdelegate create(params), to: Create, as: :call
  defdelegate get(params), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate delete(params), to: Delete, as: :call
end
