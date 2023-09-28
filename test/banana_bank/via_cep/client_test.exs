defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  @cep_valido "01001000"

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns cep info", %{bypass: bypass} do
      body_response = ~s({
        "bairro": "Sé",
        "cep": "01001-000",
        "complemento": "lado ímpar",
        "ddd": "11",
        "gia": "1004",
        "ibge": "3550308",
        "localidade": "São Paulo",
        "logradouro": "Praça da Sé",
        "siafi": "7107",
        "uf": "SP"
      })

      expected_response =
        {:ok,
         %{
           "bairro" => "Sé",
           "cep" => "01001-000",
           "complemento" => "lado ímpar",
           "ddd" => "11",
           "gia" => "1004",
           "ibge" => "3550308",
           "localidade" => "São Paulo",
           "logradouro" => "Praça da Sé",
           "siafi" => "7107",
           "uf" => "SP"
         }}

      Bypass.expect(bypass, "GET", "/#{@cep_valido}/json/", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body_response)
      end)

      response = Client.call("http://localhost:#{bypass.port}", @cep_valido)

      assert response == expected_response
    end
  end
end
