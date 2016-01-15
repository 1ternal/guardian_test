defmodule GT.SessionController do
  use GT.Web, :controller

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Repo.get_by(GT.User, %{email: email}) do
      nil -> conn |> redirect(to: "/login")
      user ->
        if Base.encode32(password) == user.password_digest do
          conn
          |> Guardian.Plug.sign_in(user)
          |> redirect(to: "/")
        else
          conn |> redirect(to: "/login")
        end
    end
  end
end
