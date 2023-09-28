defmodule BananaBankWeb.AccountsJSON do
  def create(%{account: account}) do
    IO.inspect(account)
    %{
      message: "Conta criada com sucesso!",
      data: %{
        balance: account.balance,
      },
    }
  end
end
