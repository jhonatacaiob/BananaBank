defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  describe "create/2" do
    test "Create user successfully", %{conn: conn} do
      response =
        conn
        |> post(~p"/api/users/", %{
          name: "usuario",
          email: "usuario@email.com",
          password: "1234566",
          cep: "12345336"
        })
        |> json_response(:created)

      expected_response = %{
        "data" => %{
          "cep" => "12345336",
          "email" => "usuario@email.com",
          "name" => "usuario"
        },
        "message" => "User criado com sucesso!"
      }

      assert response == expected_response
    end

    test "create user fails when it has invalid arguments", %{conn: conn} do
      response =
        conn
        |> post(~p"/api/users/", %{
          name: "usuario",
          email: "usuario",
          password: "1236",
          cep: "12345"
        })
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

    test "create user fails when required key is missing", %{conn: conn} do
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
end
