defmodule Laskuri.Repo do
  use Ecto.Repo,
    otp_app: :laskuri,
    adapter: Ecto.Adapters.Postgres
end
