ExUnit.start

Mix.Task.run "ecto.create", ~w(-r GT.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r GT.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(GT.Repo)

