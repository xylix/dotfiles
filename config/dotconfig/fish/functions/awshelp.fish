function awshelp
    # Robocorp AWS MFA config
    export AWS_MFA_IDENTITY_PROFILE="robocorp-main"
    export AWS_MFA_DURATION="43200"

    alias awsmfa-mai="awsmfa -t default && export AWS_PROFILE=default"
    alias awsmfa-cod='awsmfa arn:aws:iam::312661337933:role/robocorp-admin -t _robocode && export AWS_PROFILE=_robocode'
    alias awsmfa-con='awsmfa arn:aws:iam::455468081687:role/robocorp-admin -t _robocontainer && export AWS_PROFILE=_robocontainer'
    alias awsmfa-pre='awsmfa arn:aws:iam::297373913498:role/robocorp-admin -t _robocontainer-premium && export AWS_PROFILE=_robocontainer-premium'
    alias awsmfa-dev='awsmfa arn:aws:iam::827142569422:role/robocorp-admin -t _robocloud-dev && export AWS_PROFILE=_robocloud-dev'
    alias awsmfa-adm="awsmfa arn:aws:iam::730170722072:role/robocorp-admin -t _robocorp-admin -d7200 && export AWS_PROFILE=_robocorp-admin"
    alias awsmfa-hub="awsmfa arn:aws:iam::035578020162:role/robocorp-admin -t _robohub && export AWS_PROFILE=_robohub"
    alias awsmfa-rpa="awsmfa arn:aws:iam::360269616275:role/robocorp-admin -t _rpafw && export AWS_PROFILE=_rpafw"
    alias awsmfa-bac='awsmfa arn:aws:iam::594389146674:role/robocorp-admin -t _robocorp-backup -d7200&& export AWS_PROFILE=_robocorp-backup'
    alias awsmfa-glo='awsmfa arn:aws:iam::878616451960:role/robocorp-admin -t _robocorp-global -d7200&& export AWS_PROFILE=_robocorp-global'
    alias awsmfa-eu='awsmfa arn:aws:iam::467232950774:role/robocorp-admin -t _robocloud-eu -d7200 && export AWS_PROFILE=_robocloud-eu'
    alias awsmfa-res='awsmfa arn:aws:iam::891294075653:role/robocorp-admin -t _research && export AWS_PROFILE=_research'
    alias awsmfa-cic='awsmfa arn:aws:iam::710450854638:role/robocorp-admin -t _robocloud-cicd -d7200&& export AWS_PROFILE=_robocloud-cicd'
    alias awsmfa-ope='awsmfa arn:aws:iam::278896037270:role/robocorp-admin -t _robocorp-operations -d7200 && export AWS_PROFILE=_robocorp-operations'
    # The next ones contain the instance id in the role definition. Replace
    # the example id with your own instance.
    #
    # The first one should be used with Serverless services where
    # Permissions Boundaries are not in use yet.
    #alias awsmfa-sls-unsafe='awsmfa arn:aws:iam::827142569422:role/ernok-ServerlessDeployment -t _serverless-deployment-unsafe && export AWS_PROFILE=_serverless-deployment-unsafe'
    # The second one is for services with active Permissions Boundaries.
    #alias awsmfa-slb='awsmfa arn:aws:iam::827142569422:role/ernok-ServerlessDeploymentBounded -t _serverless-deployment-bounded && export AWS_PROFILE=_serverless-deployment-bounded'
    # And the last one for Admin UI deployments.
    #arn:aws:iam::827142569422:role/ernok-admin-ui-deployment

    alias awsuse-mai='export AWS_PROFILE=default'
    alias awsuse-cod='export AWS_PROFILE=_robocode'
    alias awsuse-con='export AWS_PROFILE=_robocontainer'
    alias awsuse-pre='export AWS_PROFILE=_robocontainer-premium'
    alias awsuse-dev='export AWS_PROFILE=_robocloud-dev'
    alias awsuse-adm='export AWS_PROFILE=_robocorp-admin'
    alias awsuse-hub='export AWS_PROFILE=_robohub'
    alias awsuse-rpa='export AWS_PROFILE=_rpafw'
    alias awsuse-bac="export AWS_PROFILE=_robocorp-backup"
    alias awsuse-glo='export AWS_PROFILE=_robocorp-global'
    alias awsuse-eu='export AWS_PROFILE=_robocloud-eu'
    alias awsuse-res='export AWS_PROFILE=_research'
    alias awsuse-ope='export AWS_PROFILE=_robocorp-operations'
    alias awsuse-cic="export AWS_PROFILE=_robocloud-cicd"
    alias awsuse-sls-unsafe='export AWS_PROFILE=_serverless-deployment-unsafe'
    alias awsuse-slb='export AWS_PROFILE=_serverless-deployment-bounded'
end
