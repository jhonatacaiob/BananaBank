defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Create
  # alias BananaBank.Accounts.Get
  # alias BananaBank.Accounts.Update
  # alias BananaBank.Accounts.Delete

  defdelegate create(params), to: Create, as: :call
  # defdelegate get(params), to: Get, as: :call
  # defdelegate update(params), to: Update, as: :call
  # defdelegate delete(params), to: Delete, as: :call
end
