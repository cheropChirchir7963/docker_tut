import Config

config :rest_api, MyApp.Repo,
  database: "rest_api_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :rest_api, ecto_repos: [MyApp.Repo]
