[#ftl]

[#macro shared_entrance_unitlist ]

  [#assign allDeploymentUnits = true]

  [#-- override the deployment group to get all deployment groups --]
  [@addCommandLineOption
      option={
        "Deployment" : {
          "Group" : {
            "Name" : "*"
          }
        }
      }
  /]

  [#if (commandLineOptions.Deployment.Unit.Subset!"") == "generationcontract" ]
    [#assign allDeploymentUnits = false]
  [/#if]

  [@generateOutput
      deploymentFramework=commandLineOptions.Deployment.Framework.Name
      type=commandLineOptions.Deployment.Output.Type
      format=commandLineOptions.Deployment.Output.Format
  /]

[/#macro]
