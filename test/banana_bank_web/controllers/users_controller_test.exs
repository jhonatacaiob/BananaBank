defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  import BananaBank.Factory

  describe "create/2" do
    test "Create user successfully", %{conn: conn} do
      user = build(:user_create)

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
      user = build(:user_create, password: "123", email: "email", cep: "123")

      response =
        conn
        |> post(~p"/api/users/", user)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "cep" => ["should be 8 character(s)"],
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
        },
      }

      assert response == expected_response
    end

    test "get user should fail when id not exists", %{conn: conn} do
      response =
        conn
        |> get(~p"/api/users/999")
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found", "status" => "not_found"}

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

      expected_response = %{"message" => "User not found", "status" => "not_found"}

      assert response == expected_response
    end
  end
end
