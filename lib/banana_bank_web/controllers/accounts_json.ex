defmodule BananaBankWeb.AccountsJSON do
  def create(%{account: account}) do
    %{
      message: "Conta criada com sucesso!",
      data: account
    }
  end

  def transaction(%{transaction: %{withdraw: from_account, deposit: to_account}}) do
    %{
      message: "Transferencia realizada!",
      data: %{
        from_account: from_account,
        to_account: to_account
      }
    }
  end
end
