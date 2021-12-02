defmodule PasswordGeneratorWeb.PageController do
  use PasswordGeneratorWeb, :controller

  def index(conn, _params, password_lengths) do
    password = ""

    conn
    |> render(
      "index.html",
      password_lengths: password_lengths,
      password: password
    )
  end

  def generate(conn, %{"password" => password_params}, password_lengths) do
    length = String.to_integer(password_params["length"])
    options = Map.delete(password_params, "length")
    password = PassGenerator.generate(length, options)

    conn
    |> render(
      "index.html",
      password_lengths: password_lengths,
      password: password
    )
  end

  def action(conn, _) do
    password_lengths = [
      Weak: Enum.map(6..15, & &1),
      Strong: Enum.map(16..88, & &1),
      Unbelievable: [100, 150]
    ]

    args = [conn, conn.params, password_lengths]
    apply(__MODULE__, action_name(conn), args)
  end
end
