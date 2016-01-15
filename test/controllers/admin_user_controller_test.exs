defmodule GT.Admin.UserControllerTest do
  use GT.ConnCase

  test "get admin users index page" do
    GT.User.changeset(%GT.User{}, %{email: "user@example.com", password: "password"}) |> Repo.insert!
    conn = post conn, login_path(conn, :create), session: %{"email" => "user@example.com", "password" => "password"}

    IO.inspect Guardian.Plug.claims(conn)
    IO.inspect Guardian.Plug.authenticated?(conn) # true
    conn = get conn, admin_user_path(conn, :index)
    assert text_response(conn, 200)
  end
end
