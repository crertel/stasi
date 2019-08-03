defmodule StasiWeb.TrafficChannel do
  use Phoenix.Channel
  def join("traffic:dashboard", _message, socket) do
    {:ok, socket}
  end

  def handle_info(msg, state) do
    IO.inspect(msg, label: "no idea what this is")
    {:noreply, state}
  end
end

# defimpl Jason.Encoder, for: ElixirRigidPhysics.World do
#   def encode(%ElixirRigidPhysics.World{bodies: bodies} = world, opts) do

#     clean_bodies = for {ref, body} <- bodies, into: %{} do

#       clean_body = for {k, v} <- body, into: %{} do
#         case {k,v} do
#           {k, v} when is_reference(v) -> {k, "#{inspect v}"}
#           {k, v} when is_tuple(v)-> {k, Tuple.to_list(v)}
#           {k, v} -> {k,v}
#         end
#       end

#       {inspect(ref), clean_body}
#     end

#     Jason.Encode.map( %ElixirRigidPhysics.World{ world | bodies: clean_bodies}, opts)
#   end
# end
