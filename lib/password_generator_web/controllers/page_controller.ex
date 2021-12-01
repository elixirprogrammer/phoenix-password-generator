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
    password = get_password(password_params)

    conn
    |> render(
      "index.html",
      password_lengths: password_lengths,
      password: password
    )
  end

  def api_generate(conn, params, _) do
    password = get_password(params)

    json(conn, %{password: password})
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

  defp get_password(params) do
    length = String.to_integer(params["length"])
    options = Map.delete(params, "length")
    PassGenerator.generate(length, options)
  end
end
