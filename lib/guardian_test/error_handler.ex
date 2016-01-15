defmodule GT.ErrorHandler do
  def unauthenticated(conn, reason) do
    IO.inspect Guardian.Plug.claims(conn)
    conn |> Phoenix.Controller.redirect(to: "/")
  end
end
