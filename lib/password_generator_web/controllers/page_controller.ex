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
    {:ok, password} = PassGenerator.generate(password_params)

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
