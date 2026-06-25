@echo off

REM This batch is used to setup the AWS ACCESS and SECRET keys
REM which will be used by packer and terraform in order to create 
REM a custom AWS AMI and deploy an EC2 instance from it
REM intended to be used as dev and PoC

REM Batch is used instead of python, to minimize tool requirment on the local mahchine 

REM assign the path to the creds file to a var
set AWS_CSV_CREDS=%~1

REM obtain credentials, either from the provided file or from interactive user input, if the file does not exist
IF NOT EXIST "%AWS_CSV_CREDS%" (
    call :GetCredentials
) ELSE (

    REM Parse the provided file and extract the AWS access and secret keys and assign them to vars
    for /f "tokens=1,2 delims=," %%A in ('more +1 %AWS_CSV_CREDS%') do (
        set "AWS_ACCESS_KEY=%%A"
        set "AWS_SECRET_KEY=%%B"
    )
)

call :SetVars

goto :EOF

REM Label for obtaining AWS secret and access keys trough user input
:GetCredentials
    echo "AWS CREDENTIALS FILE NOT FOUND"
    echo. 
    set /P "AWS_ACCESS_KEY=Enter your AWS ACCESS KEY: "
    set /P "AWS_SECRET_KEY=Enter your AWS SECRET KEY: "
    goto :EOF

REM Label for setting packer and terraform vars to be used during the tools runtime
:SetVars
    set PKR_VAR_aws_access_key=%AWS_ACCESS_KEY%
    set PKR_VAR_aws_secret_key=%AWS_SECRET_KEY%
    set TF_VAR_aws_access_key=%AWS_ACCESS_KEY%
    set TF_VAR_aws_secret_key=%AWS_SECRET_KEY%
    goto :EOF