defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import BananaBank.Factory
  import Mox

  alias BananaBank.ViaCep.ClientMock

  setup :verify_on_exit!

  setup do
    expected_response = %{
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
    }

    {:ok, response: expected_response}
  end

  describe "create/2" do
    @tag :wip
    test "Create user successfully", %{conn: conn, response: expected_response} do
      user = build(:user_create)

      expect(ClientMock, :call, fn args ->
        assert args == user.cep

        {:ok, %{body: expected_response}}
      end)

      response =
        conn
        |> post(~p"/api/users/", user)
        |> json_response(:created)

      expected_response = %{
        "data" => %{
          "cep" => user.cep,
          "email" => user.email,
          "name" => user.name
        },
        "message" => "User criado com sucesso!"
      }

      assert response == expected_response
    end

    test "create user should fail when it has invalid arguments", %{conn: conn} do
      user = build(:user_create, password: "123", email: "email")

      response =
        conn
        |> post(~p"/api/users/", user)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "email" => ["has invalid format"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert response == expected_response
    end

    test "create user should fail when required key is missing", %{conn: conn} do
      response =
        conn
        |> post(~p"/api/users/", %{})
        |> json_response(400)

      expected_response = %{
        "errors" => %{
          "cep" => ["can't be blank"],
          "email" => ["can't be blank"],
          "password" => ["can't be blank"],
          "name" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end

    test "create user should fail if the email already exists", %{conn: conn} do
      user = insert(:user)
      new_user = build(:user_create, email: user.email)

      response =
        conn
        |> post(~p"/api/users/", new_user)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"email" => ["has already been taken"]}}

      assert response == expected_response
    end
  end

  describe "get/2" do
    test "get user successfully", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> get(~p"/api/users/#{user.id}")
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "cep" => user.cep,
          "email" => user.email,
          "name" => user.name
        }
      }

      assert response == expected_response
    end

    test "get user should fail when id not exists", %{conn: conn} do
      response =
        conn
        |> get(~p"/api/users/999")
        |> json_response(:not_found)

      expected_response = %{"message" => "Resource not found", "status" => "not_found"}

      assert response == expected_response
    end
  end

  describe "update/2" do
    test "Update user successfully", %{conn: conn} do
      user = insert(:user)

      new_user = build(:user_create)

      response =
        conn
        |> put(~p"/api/users/#{user.id}", new_user)
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "cep" => new_user.cep,
          "email" => new_user.email,
          "name" => new_user.name
        },
        "message" => "User alterado com sucesso"
      }

      assert response == expected_response
    end

    test "Update user should fail when id not exists", %{conn: conn} do
      new_user = build(:user_create)

      response =
        conn
        |> put(~p"/api/users/#{999}", new_user)
        |> json_response(:not_found)

      expected_response = %{"message" => "Resource not found", "status" => "not_found"}

      assert response == expected_response
    end

    test "update user should fail if the email already exists", %{conn: conn} do
      user = insert(:user)
      new_user = build(:user_create, email: user.email)

      response =
        conn
        |> post(~p"/api/users/", new_user)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"email" => ["has already been taken"]}}

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "delete user successfully", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> delete(~p"/api/users/#{user.id}")
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "cep" => user.cep,
          "email" => user.email,
          "name" => user.name
        },
        "message" => "User excluido com sucesso"
      }

      assert response == expected_response
    end

    test "delete user should fail when id not exists", %{conn: conn} do
      response =
        conn
        |> delete(~p"/api/users/999")
        |> json_response(:not_found)

      expected_response = %{"message" => "Resource not found", "status" => "not_found"}

      assert response == expected_response
    end
  end
end
