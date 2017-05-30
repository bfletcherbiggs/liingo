defmodule Liingoew.Application do
  import Supervisor.Spec, warn: false

  if Mix.env == :test do
    def children, do: [
      # Start the endpoint when the application starts
      # Commented to Avoid - repo Liingoew.Repo is not started, please ensure it is part of your supervision tree
      supervisor(Liingoew.Web.Endpoint, []),
      # Start the Ecto repository
      supervisor(Liingoew.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(Liingoew.Worker, [arg1, arg2, arg3]),

      worker(Commerce.Billing.Worker, stripe_worker_configuration(), id: :stripe),
      worker(Commerce.Billing.Worker, braintree_worker_configuration(), id: :braintree),
      CartEventManager.child_spec
    ]

  else
   def children, do: [
        # Start the endpoint when the application starts
        # Commented to Avoid - repo Liingoew.Repo is not started, please ensure it is part of your supervision tree
        supervisor(Liingoew.Web.Endpoint, []),
        # Start the Ecto repository
        supervisor(Liingoew.Repo, []),
        # Here you could define other workers and supervisors as children
        # worker(Liingoew.Worker, [arg1, arg2, arg3]),
        worker(Commerce.Billing.Worker, stripe_worker_configuration(), id: :stripe),
        worker(Commerce.Billing.Worker, braintree_worker_configuration(), id: :braintree),
        CartEventManager.child_spec
    ]
  end

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Liingoew.Supervisor]
    with {:ok, pid} <- Supervisor.start_link(children(), opts),
         :ok        <- CartEventManager.register_with_manager,
    do: {:ok, pid}
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  # def config_change(changed, _new, removed) do
  #   Liingoew.Web.Endpoint.config_change(changed, removed)
  #   :ok
  # end

  def stripe_worker_configuration do
    worker_config = Application.get_env(:Liingoew, :stripe)
    gateway_type = worker_config[:type]
    settings = %{credentials: worker_config[:credentials],
                 default_currency: worker_config[:default_currency]}
    [gateway_type, settings, [name: :stripe]]
  end

  def braintree_worker_configuration do
    worker_config = Application.get_env(:Liingoew, :braintree)
    gateway_type = worker_config[:type]
    settings = %{}
    [gateway_type, settings, [name: :braintree]]
  end

  # when running Liingoew tests we need the Liingoew endpoint running.

end
