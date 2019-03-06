workflow "BuildDeploy" {
    on = "push"
    resolves = ["Deploy"]
}

action "Build" {
    uses = "./sphinx-build"
}

action "Only on master" {
  needs = "Build"
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Deploy" {
    needs = "Only on master"
    uses = "maxheld83/ghpages@v0.2.1"
    env = {
        BUILD_DIR = "_build/html"
    }
    secrets = ["GH_PAT"]
}
