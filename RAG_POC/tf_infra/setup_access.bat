@echo off

REM This batch is used to setup the AWS API key 
REM which will be used by terraform in order to deploy the dev machine
REM intended to be used as PoC

set AWS_CSV_CREDS=%~1

IF NOT EXIST "%AWS_CSV_CREDS%" (
    call :GetCredentials
) ELSE (
    for /f "tokens=1,2 delims=," %%A in ('more +1 %AWS_CSV_CREDS%') do (
        set "AWS_ACCESS_KEY=%%A"
        set "AWS_SECRET_KEY=%%B"
    )
)

call :SetVars

goto :EOF

:GetCredentials
    echo "AWS CREDENTIALS FILE NOT FOUND"
    echo. 
    set /P "AWS_ACCESS_KEY=Enter your AWS ACCESS KEY: "
    set /P "AWS_SECRET_KEY=Enter your AWS SECRET KEY: "
    goto :EOF

:SetVars
    set PKR_VAR_aws_access_key=%AWS_ACCESS_KEY%
    set PKR_VAR_aws_secret_key=%AWS_SECRET_KEY%
    set TF_VAR_aws_access_key=%AWS_ACCESS_KEY%
    set TF_VAR_aws_secret_key=%AWS_SECRET_KEY%
    goto :EOF