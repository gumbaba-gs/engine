[#case "codeontap"]
[#case "_codeontap"]
[#case "_hamlet"]
[#case "hamlet"]

    [#assign settings = _context.DefaultEnvironment]

    [#assign jenkinsAgentImage = settings["DOCKER_AGENT_IMAGE"]!"hamletio/hamlet"]

    [#assign awsAutomationUser = settings["AWS_AUTOMATION_USER"]!"ROLE" ]
    [#assign awsAgentAutomationRole = settings["AWS_AUTOMATION_ROLE"]!"codeontap-automation" ]

    [#assign azureAuthMethod = settings["AZ_AUTH_METHOD"]!"service" ]
    [#assign azureTenantId   = settings["AZ_TENANT_ID"]!""]

    [#assign dockerStageDir = settings["DOCKER_STAGE_DIR"]!"/tmp/docker-build" ]

    [@Attributes image=jenkinsAgentImage /]

    [@DefaultLinkVariables          enabled=false /]
    [@DefaultCoreVariables          enabled=false /]
    [@DefaultEnvironmentVariables   enabled=false /]
    [@DefaultBaselineVariables      enabled=false /]

    [@Settings {
        "AWS_AUTOMATION_USER"   : awsAutomationUser,
        "AWS_AUTOMATION_ROLE"   : awsAgentAutomationRole,
        "AZ_AUTH_METHOD"        : azureAuthMethod,
        "AZ_TENANT_ID"          : azureTenantId,
        "DOCKER_STAGE_DIR"      : dockerStageDir,
        "STARTUP_COMMANDS"      : (settings["STARTUP_COMMANDS"])!""
    }/]

    [#-- Propeties volumes provide a read only share between the jenkins server and the agents --]
    [#-- The mount can either be an efs share or a host mount which must be available to all containers --]
    [#if ((_context["Links"]["efs_properties"])!{})?has_content ]
        [@Volume
            name="codeontap_properties"
            containerPath="/var/opt/codeontap/"
            volumeLinkId="efs_properties"
        /]

        [@Volume
            name="properties"
            containerPath="/var/opt/properties/"
            volumeLinkId="efs_properties"
        /]

    [#else]

        [#if settings["CODEONTAPVOLUME"]?has_content ]
            [@Volume
                name="codeontap"
                containerPath="/var/opt/codeontap/"
                hostPath=settings["CODEONTAPVOLUME"]
            /]
        [#elseif settings["PROPERTIESVOLUME"]?has_content ]
            [@Volume
                name="codeontap"
                containerPath="/var/opt/codeontap/"
                hostPath=settings["PROPERTIESVOLUME"]
            /]
        [/#if]

        [#if settings["PROPERTIESVOLUME"]?has_content ]
            [@Volume
                name="properties"
                containerPath=(settings["PROPERTIES_DIR"])!"/var/opt/properties/"
                hostPath=settings["PROPERTIESVOLUME"]
            /]
        [/#if]

    [/#if]

    [#if settings["AWS_AUTOMATION_POLICIES"]?has_content ]
        [@ManagedPolicy settings["AWS_AUTOMATION_POLICIES"]?split(",") /]
    [/#if]

    [#if (settings["AWS_AUTOMATION_ACCOUNTS"]!"")?has_content ]
        [#assign automationAccounts = asArray( (settings["AWS_AUTOMATION_ACCOUNTS"]!"")?eval ) ]

        [#assign automationAccountRoles = []]
        [#list automationAccounts as automationAccount ]
            [#assign automationAccountRoles += [
                                                    formatGlobalArn(
                                                        "iam",
                                                        formatRelativePath("role", awsAgentAutomationRole),
                                                        automationAccount  )
                                                ]]
        [/#list]

        [@Policy
            [
                getPolicyStatement( ["sts:AssumeRole"], automationAccountRoles)
            ]
        /]
    [/#if]

    [#if (settings["JENKINS_PERMANENT_AGENT"]!"false")?boolean  ]

        [#assign jenkinsUrl = settings["JENKINS_URL"] ]

        [#if (settings["JENKINS_LOCAL_FQDN"]!"")?has_content ]
            [#assign jenkinsUrl = "http://" + settings["JENKINS_LOCAL_FQDN"] + ":8080" ]
        [/#if]

        [@Command
            [
                "-url",
                jenkinsUrl,
                settings["JENKINS_PERMANENT_AGENT_SECRET"],
                settings["JENKINS_PERMANENT_AGENT_NAME"]
            ]
        /]
    [/#if]

    [#-- Docker Agent Access --]
    [#assign dockerEnabled = ((settings["ENABLE_DOCKER"])!"true")?boolean ]
    [#assign dindEnabled = (settings["DIND_ENABLED"]!"false")?boolean ]

    [#if dockerEnabled && dindEnabled ]
        [@fatal
            message="DockerInDocker and DockerOutOfDocker Agent modes enabled"
            context={
                "ENABLE_DOCKER" : dockerEnabled,
                "DIND_ENABLED" : dindEnabled
            }
            detail="Update settings so only one agent docker mode is enabled"
        /]
    [/#if]

    [#-- DockerOutOfDocker Agent--]
    [#-- The docker out of docker provides a bind mount volume to the containers own docker socket --]
    [#-- This can cause issues with port conflicts and disk usage on the hosts. The AWS linux docker volumes dir is pretty small --]
    [#if dockerEnabled ]

        [#assign dockerHostDaemon = settings["DOCKER_HOST_DAEMON"]!"/var/run/docker.sock"]

        [@Volume
            name="dockerDaemon"
            containerPath="/var/run/docker.sock"
            hostPath=dockerHostDaemon
        /]

        [@Volume
            name="dockerStage"
            containerPath=dockerStageDir
            hostPath=dockerStageDir
        /]
    [/#if]


    [#-- DockerInDockerAgent --]
    [#-- In this model a sidercar container running in priviledged mode offers the docker service for the agent to use --]
    [#-- We also use a dockerStage directory to share local bind mounts between the agent and the dind host --]
    [#-- This agent requires the dind side car and enabling privledged mode in a container which is considered a secrity risk --]
    [#-- This requires the ecs host to have the ebs VolumeDriver Enabled --]
    [#if dindEnabled ]

        [#assign dockerStageDir = settings["DOCKER_STAGE_DIR"]!"/home/jenkins"  ]
        [#assign dockerStageSize = settings["DOCKER_STAGE_SIZE_GB"]!"20"        ]
        [#assign dockerStagePersist = (settings["DOCKER_STAGE_PERSIST"]?boolean)!false ]
        [#assign dindHost = settings["DIND_DOCKER_HOST_URL"]!"tcp://dind:2376"  ]
        [#assign dindTLSVerify = settings["DIND_DOCKER_TLS_VERIFY"]!"true"      ]

        [#if dindTLSVerify?boolean ]
            [@Settings
                {
                    "DOCKER_CERT_PATH" : "/docker/certs/client"
                }
            /]

            [@Volume
                name="dind_certs_client"
                containerPath="/docker/certs/client"
                readOnly=true
            /]

        [/#if]

        [@Settings
            {
                "DOCKER_HOST" : dindHost,
                "DOCKER_TLS_VERIFY" : dindTLSVerify
            }
        /]

        [@Volume
            name="dockerStage"
            containerPath=dockerStageDir
            volumeEngine="ebs"
            scope=dockerStagePersist?then(
                        "shared",
                        "task"
            )
            driverOpts={
                "volumetype": "gp2",
                "size": dockerStageSize
            }
        /]

    [/#if]

    [#break]

[#case "_dind" ]
[#case "dind" ]
    [@DefaultLinkVariables enabled=false /]
    [@DefaultCoreVariables enabled=false /]
    [@DefaultEnvironmentVariables enabled=false /]
    [@DefaultBaselineVariables enabled=false /]

    [@Hostname hostname=_context.Name /]

    [#assign dockerStageDir = settings["DOCKER_STAGE_DIR"]!"/home/jenkins"  ]
    [#assign dockerStageSize = settings["DOCKER_STAGE_SIZE_GB"]!"20"        ]
    [#assign dockerStagePersist = (settings["DOCKER_STAGE_PERSIST"]?boolean)!false ]
    [#assign dockerLibSize = settings["DOCKER_LIB_VOLUME_SIZE"]!"20"         ]
    [#assign dindTLSVerify = settings["DIND_DOCKER_TLS_VERIFY"]!"true"      ]


    [#if dindTLSVerify?boolean ]
        [@Settings
            {
                "DOCKER_TLS_CERTDIR" : "/docker/certs"
            }
        /]

        [@Volume
            name="dind_certs_client"
            containerPath="/docker/certs/client"
        /]
    [/#if]

    [@Volume
        name="dockerStage"
        containerPath=dockerStageDir
        volumeEngine="ebs"
        scope=dockerStagePersist?then(
                    "shared",
                    "task"
        )
        driverOpts={
            "volumetype": "gp2",
            "size": dockerStageSize
        }
    /]

    [@Volume
        name="dind_lib"
        containerPath="/var/lib/docker"
        volumeEngine="ebs"
        scope="task"
        scope=dockerStagePersist?then(
            "shared",
            "task"
        )
        driverOpts={
            "volumetype": "gp2",
            "size": dockerLibSize
        }
    /]
    [#break]

[#case "_jenkinsecs" ]
    [#assign settings = _context.DefaultEnvironment]

    [#-- The docker stage dir is used to provide a staging location for docker in docker based builds which use the host docker instance --]
    [#assign dockerStageDirs =
            (settings["DOCKER_STAGE_DIR"])?has_content?then(
                    asArray(settings["DOCKER_STAGE_DIR"]),
                    settings["DOCKER_STAGE_DIRS"]?has_content?then(
                        asArray( (settings["DOCKER_STAGE_DIRS"]?split(",") )),
                        [ "/tmp/docker-build" ]
                    )
            )]

    [#list dockerStageDirs as dockerStageDir]
        [@Directory
            path=dockerStageDir
            mode="775"
            owner="1000"
            group="1000"
        /]
    [/#list]
    [#break]
