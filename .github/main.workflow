workflow "BuildDeploy" {
    on = "push"
    resolves = ["Deploy"]
}

action "Deploy" {
    uses = "./sphinx-build"
}