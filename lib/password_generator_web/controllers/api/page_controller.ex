defmodule PasswordGeneratorWeb.Api.PageController do
  use PasswordGeneratorWeb, :controller

  def api_generate(conn, params) do
    length = String.to_integer(params["length"])
    options = Map.delete(params, "length")
    password = PassGenerator.generate(length, options)

    json(conn, %{password: password})
  end
end
