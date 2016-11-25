defmodule BlogPhoenix.Post do
  use BlogPhoenix.Web, :model
  import Ecto.Query

  schema "posts" do
    field :title, :string
    field :body, :string

    has_many :comments, BlogPhoenix.Comment, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
  end

  def count_comments(query) do
    from table in query,
      group_by: table.id,
      left_join: c in assoc(table, :comments),
      select: {table, count(c.id)  }
  end
end
