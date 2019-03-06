workflow "BuildDeploy" {
    on = "push"
    resolves = ["Deploy"]
}

action "Build" {
    uses = "./sphinx-build"
}

action "Deploy" {
    needs = "Build"
    uses = "maxheld83/ghpages@v0.2.1"
    env = {
        BUILD_DIR = "_build/html"
    }
    secrets = ["GH_PAT"]
}
