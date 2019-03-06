workflow "BuildDeploy" {
    on = "push"
    resolves = ["Deploy"]
}

action "Deploy" {
    uses = "./action-a"
    secrets = ["GITHUB_TOKEN"]
}