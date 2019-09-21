# Oslo

Proof of Concept for second generation package (2GP)

### Environment Setup

1. Install the [SFDX Command Line Interface (CLI)](https://developer.salesforce.com/tools/sfdxcli)
1. This project contains some tasks for the VS Code editor that facilitate operations against local/internal environments. Install [VS Code + SF Extensions](https://forcedotcom.github.io/salesforcedx-vscode/articles/getting-started/install)
1. Clone this project : `git@git.soma.salesforce.com:sustainability-cloud/Sustainability-App.git`

## Testing

The `project_setup.sh` script under `scripts` folder will create a scratch org, deploy the code and create the users needed to test the app.

Running the script directly in a terminal

```
$ scripts/project_setup.sh
```

Running the script in VSCode as a task:

1. Open the Command Palette or use the key shortcut `command + p`
1. Type `task` and you should see the list of tasks configured in `.vscode/tasks.json`
1. Select `Scratch Org setup` and follow the prompts
