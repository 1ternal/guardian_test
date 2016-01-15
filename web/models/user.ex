defmodule GT.User do
  use GT.Web, :model

  schema "users" do
    field :email, :string
    field :password_digest, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    timestamps
  end

  @required_fields ~w(email password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> hash_pw
  end

  defp hash_pw(cs) do
    case get_change(cs, :password) do
      nil -> cs
      pwd -> put_change(cs, :password_digest, Base.encode32(pwd))
    end
  end
end
