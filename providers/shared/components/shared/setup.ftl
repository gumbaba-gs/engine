[#ftl]

[#-- Shared Component --]
[#-- The Shared component is used to define common component macros which are shared across all components --]
[#-- Each component can replace the shared component macros but defining a macro which is more specific then the shared one --]

[#-- Default build blueprint --]
[#macro shared_buildblueprint_generationcontract occurrence ]
    [@addDefaultGenerationContract subsets=[ "config" ] /]
[/#macro]

[#macro shared_buildblueprint_config occurrence ]
    [@addToDefaultJsonOutput
        content={
            "Occurrence" : occurrence
        }
    /]
[/#macro]

[#-- Default management contract --]
[#macro shared_unitlist_generationcontract occurrence ]
    [@addDefaultGenerationContract subsets=[ "managementcontract" ] /]
[/#macro]

[#macro shared_unitlist_managementcontract occurrence ]

    [@createOccurrenceManagementContractStep
        occurrence=occurrence
    /]

    [#list (occurrence.Occurrences)![] as subOccurrence ]
        [@createOccurrenceManagementContractStep
            occurrence=subOccurrence
        /]
    [/#list]

    [#if getOutputContent("stages")?has_content ]
        [#list getOutputContent("stages")?keys as deploymentGroup ]
            [@createResourceSetManagementContractStep
                deploymentGroupDetails=getDeploymentGroupDetails(deploymentGroup)
            /]
        [/#list]
    [/#if]
[/#macro]

[#-- Default testcase --]
[#macro shared_deploymenttest_generationcontract occurrence ]
    [@addDefaultGenerationContract subsets=[ "testcase" ] /]
[/#macro]

[#macro shared_deploymenttest_testcase occurrence ]
    [#local solution = occurrence.Configuration.Solution ]
    [#local componentType = occurrence.Core.Type ]

    [#local testProfileNames = (solution.Profiles.Testing)![] ]

    [#local testCaseNames = []]
    [#list testProfileNames as testProfileName ]
        [#if (testProfiles[testProfileName]!{})?? ]
            [#local testProfileDetail = testProfiles[testProfileName] ]

            [#if testProfileDetail["*"]?? ]
                [#local testCaseNames += testProfileDetail["*"].TestCases ]
            [/#if]

            [#if testProfileDetail[componentType]??]
                [#local testCaseNames += testProfileDetail[componentType].TestCases ]
            [/#if]
        [/#if]
    [/#list]

    [#local testCaseNames = getUniqueArrayElements(testCaseNames) ]

    [#local tests = {} ]
    [#list testCaseNames as testCaseName ]
        [#local testCaseFullName = concatenate(
                                        [
                                            getOccurrenceDeploymentUnit(occurrence),
                                            (occurrence.Core.ShortTypedName),
                                            testCaseName
                                        ],
                                        "_"
                                    )?replace("-", "_")]
        [#if testCases[testCaseName]?? ]
            [#local testCase = testCases[testCaseName] ]

            [#local tests = mergeObjects(
                tests,
                {
                    testCaseFullName  : {
                        "filename" : concatenate(
                                        [
                                            commandLineOptions.Deployment.Output.Prefix,
                                            testCase.OutputSuffix
                                        ],
                                        ""
                                    ),
                        "cfn_lint" : testCase.Tools.CFNLint,
                        "cfn_nag"  : testCase.Tools.CFNNag
                    }
                }
            )]

            [#list (testCase.Structural.JSON.Match)!{} as id,matchTest ]
                [#local tests = combineEntities(tests,
                    {
                        testCaseFullName : {
                            "json_structure" : {
                                "match" : [
                                    {
                                        "path" : matchTest.Path,
                                        "value" : matchTest.Value
                                    }
                                ]
                            }
                        }
                    },
                    APPEND_COMBINE_BEHAVIOUR
                )]
            [/#list]

            [#list (testCase.Structural.JSON.Length)!{} as id,legnthTest ]
                [#local tests = combineEntities(tests,
                    {
                        testCaseFullName : {
                            "json_structure"  : {
                                "length" : [
                                        {
                                            "path" : legnthTest.Path,
                                            "value" : legnthTest.Count
                                        }
                                ]
                            }
                        }
                    },
                    APPEND_COMBINE_BEHAVIOUR
                )]
            [/#list]

            [#if testCase.Structural.JSON.Exists?has_content ]
                [#local existPaths = []]
                [#list testCase.Structural.JSON.Exists as path ]
                    [#local existPaths += [
                            {
                                "path" : path
                            }
                        ]
                    ]
                [/#list]
                [#local tests = mergeObjects(
                    tests,
                    {
                        testCaseFullName  : {
                            "json_structure" : {
                                "exists" : existPaths
                            }
                        }
                    }
                )]
            [/#if]

            [#if testCase.Structural.JSON.NotEmpty?has_content ]
                [#local notEmtpyPaths = []]
                [#list testCase.Structural.JSON.NotEmpty as path ]
                    [#local notEmtpyPaths += [
                            {
                                "path" : path
                            }
                        ]
                    ]
                [/#list]
                [#local tests = mergeObjects(
                    tests,
                    {
                        testCaseFullName  : {
                            "json_structure" : {
                                "not_empty" : notEmtpyPaths
                            }
                        }
                    }
                )]
            [/#if]

            [#list (testCase.Structural.CFN.Resource)!{} as id,CFNResourceTest ]
                [#local tests = combineEntities(tests,
                    {
                        testCaseFullName : {
                            "cfn_structure"  : {
                                "resource" : [
                                    {
                                        "id" : CFNResourceTest.Name,
                                        "type" : CFNResourceTest.Type
                                    }
                                ]
                            }
                        }
                    },
                    APPEND_COMBINE_BEHAVIOUR
                )]
            [/#list]

            [#if testCase.Structural.CFN.Output?has_content ]
                [#local cfnOutputPaths = []]
                [#list testCase.Structural.CFN.Output as path ]
                    [#local cfnOutputPaths += [
                            {
                                "id" : path
                            }
                        ]
                    ]
                [/#list]
                [#local tests = mergeObjects(
                    tests,
                    {
                        testCaseFullName  : {
                            "cfn_structure" : {
                                "output" : cfnOutputPaths
                            }
                        }
                    }
                )]
            [/#if]
        [/#if]
    [/#list]

    [@addToDefaultJsonOutput
        content=tests
    /]
[/#macro]
