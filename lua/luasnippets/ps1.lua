---@diagnostic disable: undefined-global
local shareable = require('luasnippets.functions.shareable_snippets')

-- stylua: ignore start
local powershell_foreground_highlights = { t('Gray'), t('Green'), t('Yellow'), t('Red'), t('Blue'), t('Cyan'), t('Magenta'), t('White'), t('Black'), t('DarkBlue'), t('DarkGreen'), t('DarkCyan'), t('DarkRed'), t('DarkMagenta'), t('DarkYellow'), t('DarkGray'), }
local powershell_background_highlights = { t('Black'), t('DarkGreen'), t('DarkYellow'), t('DarkRed'), t('DarkBlue'), t('DarkCyan'), t('DarkMagenta'), t('Gray'), t('DarkGray'), t('Blue'), t('Green'), t('Cyan'), t('Red'), t('Magenta'), t('Yellow'), t('White'), }
local powershell_standard_parameter_names = { t('Accessed'), t('ACL'), t('After'), t('All'), t('Allocation'), t('Append'), t('Application'), t('As'), t('Assembly'), t('Attribute'), t('Before'), t('Binary'), t('BlockCount'), t('CaseSensitive'), t('CertFile'), t('CertIssuerName'), t('CertRequestFile'), t('CertSerialNumber'), t('CertStoreLocation'), t('CertSubjectName'), t('CertUsage'), t('Class'), t('Cluster'), t('Command'), t('CompatibleVersion'), t('Compress'), t('CompressionLevel'), t('Continuous'), t('Count'), t('Create'), t('Created'), t('Credential'), t('CSPName'), t('CSPType'), t('Culture'), t('Delete'), t('Description'), t('Domain'), t('Drain'), t('Drive'), t('Encoding'), t('Erase'), t('ErrorLevel'), t('Event'), t('Exact'), t('Exclude'), t('Filter'), t('Follow'), t('Force'), t('From'), t('Group'), t('Id'), t('Include'), t('Incremental'), t('Input'), t('InputObject'), t('Insert'), t('Interactive'), t('Interface'), t('Interval'), t('IpAddress'), t('Job'), t('KeyAlgorithm'), t('KeyContainerName'), t('KeyLength'), t('LiteralPath'), t('Location'), t('Log'), t('LogName'), t('Mac'), t('Modified'), t('Name'), t('NewLine'), t('NoClobber'), t('Notify'), t('NotifyAddress'), t('Operation'), t('Output'), t('Overwrite'), t('Owner'), t('Parameter'), t('ParentId'), t('Path'), t('Port'), t('Principal'), t('Printer'), t('Privilege'), t('Prompt'), t('Property'), t('Quiet'), t('Reason'), t('Recurse'), t('Regex'), t('Repair'), t('RepairString'), t('Retry'), t('Role'), t('SaveCred'), t('Scope'), t('Select'), t('ShortName'), t('SID'), t('Size'), t('Speed'), t('State'), t('Stream'), t('Strict'), t('TempLocation'), t('TID'), t('Timeout'), t('true'), t('Truncate'), t('Trusted'), t('TrustLevel'), t('Type'), t('URL'), t('User'), t('Value'), t('ValueFromPipeline'), t('Verify'), t('Version'), t('Wait'), t('WaitTime'), t('Width'), t('Wrap'), }
-- stylua: ignore end

local function true_or_false_choice_node(index)
    return c(index, {
        t('$false'),
        t('$true'),
    })
end

---easily create a choice node from a table of options
---@param index number
---@param options table
---@return c
local function option_choice_node(index, options)
    return c(
        index,
        map(function(i)
            return t(i)
        end, options):totable()
    )
end

local function param(index)
    return sn(
        index,
        fmt(
            [[
            [Parameter({ParamOptions})]
            [{Type}]${ParamName}
            ]],
            {
                -- https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/parameter-attribute-declaration?view=powershell-7.5
                ParamOptions = i(1, 'test'),
                Type = i(2, 'string'),
                -- 'Mandatory|ParameterSetName=""|Position=0|ValueFromPipeline|ValueFromRemainingArguments|HelpMessage=""|DontShow'
                ParamName = c(3, powershell_standard_parameter_names),
            }
        )
    )
end

local function param_block(index)
    return sn(
        index,
        fmt(
            [[
            {CmdletBinding}
            param (
                {FirstParam}
            )
            ]],
            {
                CmdletBinding = c(1, {
                    t(''),
                    sn(
                        1,
                        fmt(
                            [=[
                  [CmdletBinding(
                      SupportsShouldProcess
                  )]
                  ]=],
                            {}
                        )
                    ),
                }),

                FirstParam = param(2),
            }
        )
    )
end

local function PesterAssert(index)
    return sn(
        index,
        fmt([[Should -{Option}]], {
            Option = c(1, {
                t('Be'),
                t('BeExactly'),
                t('BeGreaterThan'),
                t('BeGreaterOrEqual'),
                t('BeLessThan'),
                t('BeLessOrEqual'),
                t('BeIn'),
                t('BeLike'),
                t('BeLikeExactly'),
                t('BeNullOrEmpty'),
                t('BeOfType'),
                t('BeTrue'),
                t('BeFalse'),
                t('Contain'),
                t('ContainExactly'),
                t('Exist'),
                t('FileContentMatch'),
                t('FileContentMatchMultiline'),
                t('FileContentMatchExactly'),
                t('HaveCount'),
                t('HaveType'),
                t('Match'),
                t('MatchExactly'),
                t('MatchMultiline'),
                t('Not'),
                t('Throw'),
                t('ThrowExactly'),
                t('ThrowContaining'),
                t('Invoke'),
                t('InvokeExactly'),
                i(1),
            }),
        })
    )
end

local function PesterTestSkip(index)
    return sn(
        index,
        fmt([[{Choices}]], {
            Choices = c(1, {
                t(''),
                t('-Skip:(-not(Test-Path Env:CI))'),
                sn(
                    nil,
                    fmt([[-Skip:([bool](!(Get-Command {Program} -ErrorAction SilentlyContinue)))]], {
                        Program = i(1, 'tshark'),
                    })
                ),
                t('-Skip:$true'),
                t('-Skip:$false'),
            }),
        })
    )
end

local function PesterTest(index)
    return sn(
        index,
        fmt(
            [[
        It '{TestDescription}' {Multiple} 
            {Command} | {Assertion}
        }}
    ]],
            {
                TestDescription = i(1, 'This test does ....'),
                Multiple = c(2, {
                    -- If multiple test case data style is not wanted then use this curly bracket
                    t('{'),

                    -- Otherwise format like this multi test case style
                    sn(
                        nil,
                        fmt(
                            [[-TestCases @(
                                @{ <Variable> = <Value> }
                            ) {
                            ]],
                            {
                                Variable = i(1, 'Variable'),
                                Value = i(2, 'Value'),
                            },
                            {
                                delimiters = '<>',
                            }
                        )
                    ),
                }),
                Command = i(3, 'command'),
                Assertion = PesterAssert(4),
            }
        )
    )
end

local function PesterTestGroup(index)
    return sn(
        index,
        fmt(
            [[
    Describe '{TestGroupName}' {Skip} {{
        {TestBody}
    }}
    ]],
            {
                TestGroupName = i(1, 'Test group'),
                Skip = PesterTestSkip(2),
                TestBody = PesterTest(3),
            }
        )
    )
end

local function CustomObject(index)
    return sn(
        index,
        fmt(
            [[
     [PSCustomObject]@{{
         {Items}
     }}
     ]],
            {
                Items = i(1, 'Name = "Derek"'),
            }
        )
    )
end

local function ApprovedVerb(index)
    return sn(
        index,
        fmt([[{}]], {
            c(1, {
                t('Get'),
                t('Add'),
                t('Clear'),
                t('Close'),
                t('Copy'),
                t('Enter'),
                t('Exit'),
                t('Find'),
                t('Format'),
                t('Hide'),
                t('Join'),
                t('Lock'),
                t('Move'),
                t('New'),
                t('Open'),
                t('Optimize'),
                t('Push'),
                t('Pop'),
                t('Redo'),
                t('Remove'),
                t('Rename'),
                t('Reset'),
                t('Resize'),
                t('Search'),
                t('Select'),
                t('Set'),
                t('Show'),
                t('Skip'),
                t('Split'),
                t('Step'),
                t('Switch'),
                t('Undo'),
                t('Unlock'),
                t('Watch'),
                t('Connect'),
                t('Disconnect'),
                t('Read'),
                t('Receive'),
                t('Send'),
                t('Write'),
                t('Backup'),
                t('Checkpoint'),
                t('Compare'),
                t('Compress'),
                t('Convert'),
                t('ConvertFrom'),
                t('ConvertTo'),
                t('Dismount'),
                t('Edit'),
                t('Expand'),
                t('Export'),
                t('Group'),
                t('Import'),
                t('Initialize'),
                t('Limit'),
                t('Merge'),
                t('Mount'),
                t('Out'),
                t('Publish'),
                t('Restore'),
                t('Save'),
                t('Sync'),
                t('Unpublish'),
                t('Update'),
                t('Debug'),
                t('Measure'),
                t('Ping'),
                t('Repair'),
                t('Resolve'),
                t('Test'),
                t('Trace'),
                t('Approve'),
                t('Assert'),
                t('Build'),
                t('Complete'),
                t('Confirm'),
                t('Deny'),
                t('Deploy'),
                t('Disable'),
                t('Enable'),
                t('Install'),
                t('Invoke'),
                t('Register'),
                t('Request'),
                t('Restart'),
                t('Resume'),
                t('Start'),
                t('Stop'),
                t('Submit'),
                t('Suspend'),
                t('Uninstall'),
                t('Unregister'),
                t('Wait'),
                t('Use'),
                t('Block'),
                t('Grant'),
                t('Protect'),
                t('Revoke'),
                t('Unblock'),
                t('Unprotect'),
            }),
        })
    )
end

local snippets = {
    ms(
        {
            { trig = 'script', snippetType = 'snippet', condition = nil },
            { trig = 'single_file', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        [CmdletBinding()]
        {params}
        ]],
            {
                params = param_block(1),
            }
        )
    ),
    ms(
        {
            { trig = 'RootModule', snippetType = 'snippet', condition = nil },
        },
        fmt([[RootModule = '{}']], {
            i(1, './Root.psm1'),
        })
    ),
    ms(
        {
            { trig = 'ModuleVersion', snippetType = 'snippet', condition = nil },
        },
        fmt([[ModuleVersion = '{Version}']], {
            Version = i(1, '0.1.0'),
        })
    ),
    ms(
        {
            { trig = 'RequiredModules', snippetType = 'snippet', condition = nil },
        },
        fmt([[RequiredModules = @('{RequiredModules}')]], {
            RequiredModules = i(1, 'SharpCompress.dll'),
        })
    ),

    ms({
        { trig = 'TempDirectory', snippetType = 'snippet', condition = nil },
    }, { t([[[IO.Path]::GetTempPath()]]) }),
    ms({
        { trig = 'TempPath', snippetType = 'snippet', condition = nil },
    }, { t([[[IO.Path]::GetTempFileName()]]) }),
    ms({
        { trig = 'ToBase64String', snippetType = 'snippet', condition = nil },
    }, fmt([[[Convert]::ToBase64String([IO.File]::ReadAllBytes($($PWD.Path) + '/file.txt'))]], {})),
    ms(
        {
            { trig = 'FromBase64String', snippetType = 'snippet', condition = nil },
        },
        fmt([[[convert]::FromBase64String('{String}')]], {
            String = i(1, 'SGVsbG8gd29ybGQ='),
        })
    ),

    ms(
        {
            { trig = 'Write-ProgressEx', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        ${ProgressArgsName} = @{{
            Id = {Id}
            ShowProgressBar = 'Force'
            Activity = "{Action}"
            Status = "{StatusMessage}"
            Total = {TotalCalculation}
            Increment = $true
        }}
        Write-ProgressEx @args
        ]],
            {
                ProgressArgsName = i(1, 'args'),
                Id = i(2, '0'),
                Action = i(3, 'MainAction'),
                StatusMessage = i(4, 'Processing: $_'),
                TotalCalculation = i(5, '$Files.Length'),
            }
        )
    ),
    ms(
        {
            { trig = 'psake_task', snippetType = 'snippet', condition = nil },
            { trig = 'psake task', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
      Task {Name} {{
          {Code}
      }}
      ]],
            {
                Name = i(1, 'TaskName'),
                Code = i(2),
            }
        )
    ),
    ms(
        {
            { trig = 'ModuleName', snippetType = 'snippet', condition = nil },
            { trig = 'module name', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
      @{{ ModuleName = '{Name}'; ModuleVersion = '{Version}' }}
      ]],
            {
                Name = i(1, 'SimplySql'),
                Version = i(2, '2.1.0.96'),
            }
        )
    ),
    ms(
        {
            { trig = 'FunctionsToExportCollector', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
Task FunctionsToExport {
    # RegEx matches files like Verb-Noun.ps1 only, not psakefile.ps1 or *-*.Tests.ps1
    $functionNames = Get-ChildItem -Recurse | Where-Object { $_.Name -match "^[^\.]+-[^\.]+\.ps1$" } -PipelineVariable file | ForEach-Object {
        $ast = [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref] $null, [ref] $null)
        if ($ast.EndBlock.Statements.Name)
        {
            $ast.EndBlock.Statements.Name
        }
    }
    Write-Verbose "Using functions $functionNames"
    $moduleManifest = "${PSScriptRoot}/*.psd1"
    Update-ModuleManifest -Path $moduleManifest -FunctionsToExport $functionNames
}
      ]],
            {},
            { delimiters = '<>' }
        )
    ),
    ms(
        {
            { trig = 'paramset', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = '__AllParameterSets')]
        [string]$Param1,

        [Parameter(ParameterSetName = 'Debug')]
        [switch]$Param2
    )
      ]],
            {}
        )
    ),
    ms(
        {
            { trig = 'paramset_switch', snippetType = 'snippet', condition = nil },
            { trig = 'param switch', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
      switch ($PSCmdlet.ParameterSetName)
      {
          'Default' { <DefaultSet> }
          '<NextSetName>' { <NextSetBlock> }
      }
      ]],
            {
                DefaultSet = i(1, 'echo "Default code block here"'),
                NextSetName = i(2, 'CustomSwitchTriggerName'),
                NextSetBlock = i(3, 'echo "CustomSwitch code block"'),
            },
            { delimiters = '<>' }
        )
    ),
    ms(
        {
            { trig = 'timer_run_in_same_scope', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
# Create a PowerShell oneshot powershell timer
$timer = New-Object Timers.Timer
$timer.Interval = {Interval}
$timer.AutoReset = $false

# Register event to trigger our deferred load on the main thread
Register-ObjectEvent -InputObject $timer -EventName Elapsed -Action {{
    {Code}
}} | Out-Null
$timer.Start()
      ]],
            {
                Interval = i(1, '5000'),
                Code = i(2),
            }
        )
    ),
    ms({
        { trig = 'PSReadLine_AddToHistory', snippetType = 'snippet', condition = nil },
    }, fmt('[Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory({Command})', { Command = i(1, 'ls') })),

    ms(
        {
            { trig = 'ConvertTo-SecureString', snippetType = 'snippet', condition = nil },
            { trig = 'Set-Secret_BuildPSCredential', snippetType = 'snippet', condition = nil },
            { trig = 'PSCredential', snippetType = 'snippet', condition = nil },
            { trig = 'Credential', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    $securePassword = ConvertTo-SecureString $env:OrionFotaProduction -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential ($env:OrionFotaProductionUser, $securePassword)
    Set-Secret -Name 'OrionFotaProduction' -Secret $cred
        ]],
            {}
        )
    ),
    ms(
        {
            { trig = 'required_modules', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
# List all required powershell modules and install them if necessary
# Must provide the Name, optionally the RequiredVersion
$RequiredModules = @(
    @{ Name = 'PSScriptTools' },
    @{ Name = 'PSFzf' },
    @{ Name = 'SimplySql' },
    @{ Name = 'Selenium' },
    @{ Name = 'Microsoft.PowerShell.SecretManagement' },
    @{ Name = 'Microsoft.PowerShell.SecretStore' },
    @{ Name = 'SqlServer' },
    @{ Name = 'PSWriteOffice' },
    @{ Name = 'Join-Object' },
    @{ Name = 'PSTeams' }
)
if(-not (Get-Module -Name $($RequiredModules[0]['Name']) -ListAvailable -ErrorAction SilentlyContinue))
{
    Write-Host "Required modules are not found, installing"
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    $RequiredModules | ForEach-Object -ThrottleLimit 5 -Parallel { Install-Module @_ -SkipPublisherCheck }
}
        ]],
            {},
            { delimiters = '<>' }
        )
    ),

    ms(
        {
            { trig = 'dynamic_param', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    # I used module PSScriptTools helper function New-PSDynamicParameter to generate this dynamic param
    dynamicparam
    {
        if (-not $PSBoundParameters['Interactive'])
        {
            $paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary

            # Defining parameter attributes
            $attributeCollection = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
            $attributes = New-Object System.Management.Automation.ParameterAttribute
            $attributes.ParameterSetName = '__AllParameterSets'
            $attributes.Mandatory = $True
            $attributeCollection.Add($attributes)

            # Defining the runtime parameter
            $dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter('Path', [String], $attributeCollection)
            $paramDictionary.Add('Path', $dynParam1)

            return $paramDictionary
        }
    }
        ]],
            {},
            {
                delimiters = '<>',
            }
        )
    ),

    ms(
        {
            { trig = 'dotnet_publish', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
$dotnetArgs = @(
    "publish"
    "$PSScriptRoot/BelleLTE_RMA.csproj"
    "--output", $PublishDirectory
    "--runtime", "win-x64"
    "--configuration", "Release"
    "-p:PublishSingleFile=true"
    "--self-contained=true"
)

dotnet @dotnetArgs

if(-not $?)
{{
    Write-Error "dotnet publish failed"
    exit
}}
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'environment_exists', snippetType = 'snippet', condition = nil },
            { trig = 'env_exists', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        if({Not}$env:{Variable})
        {{
            {Code}
        }}
        ]],
            {
                Not = c(1, {
                    t(''),
                    t('-not'),
                }),
                Variable = i(2, 'EnvironmentVariableName'),
                Code = i(3, 'default'),
            }
        )
    ),

    ms(
        {
            { trig = 'platform', snippetType = 'snippet', condition = nil },
            { trig = 'Linux', snippetType = 'snippet', condition = nil },
            { trig = 'Windows', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        switch ($null)
        {
            {$IsWindows}
            {
                <Windows>
            }
            {$IsLinux}
            {
                <Linux>
            }
            {$IsMacOS}
            {
                <Mac>
            }
            default
            {
                <Other>
            }
        }
        ]],
            {
                Windows = i(1, 'WindowsAction'),
                Linux = i(2, 'LinuxAction'),
                Mac = i(3, 'MacAction'),
                Other = i(4, 'OtherAction'),
            },
            {
                delimiters = '<>',
            }
        )
    ),
    ms(
        {
            { trig = 'hash hash', snippetType = 'autosnippet', condition = nil },
            { trig = '@{', snippetType = 'autosnippet', condition = nil },
            { trig = 'hash', snippetType = 'snippet', condition = nil },
        },
        fmt([[{}]], {
            c(1, {
                sn(
                    nil,
                    fmt([[@{{{Items}}}]], {
                        Items = r(1, 'Items'),
                    })
                ),
                sn(
                    nil,
                    fmt(
                        [[
                        @{{
                            {Items}
                        }}
                        ]],
                        {
                            Items = r(1, 'Items'),
                        }
                    )
                ),
            }),
        })
    ),

    ms(
        {
            { trig = 'hashtable_iterate', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        foreach ({Item} in {Hashtable})
        {{
            {Code}
        }}
        ]],
            {
                Item = i(1, 'item'),
                Hashtable = i(2, 'Hashtable'),
                Code = i(3, '$item.Name - $item.Value'),
            }
        )
    ),

    ms(
        {
            { trig = 'New-Alias', snippetType = 'snippet', condition = nil },
            { trig = 'alias', snippetType = 'snippet', condition = nil },
            { trig = 'alias alias', snippetType = 'autosnippet', condition = nil },
        },
        c(1, {
            -- Proof that a snippet  node can be made with just a format  node
            fmt('[Alias(\'{Name}\')]', {
                Name = i(1, 'Name'),
            }),
            fmt([[New-Alias -Name '{Name}' -Value {Value}]], {
                Name = i(1, 'Name'),
                Value = i(2, 'Value'),
            }),
        })
    ),

    ms(
        {
            { trig = 'Test-Path', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        if({Option}(Test-Path {Path}))
        {{
            {Code}
        }}
        ]],
            {
                Option = c(1, {
                    t('-not'),
                    t(''),
                }),
                Path = i(2, 'Path'),
                Code = i(3),
            }
        )
    ),

    -- https://stackoverflow.com/a/49096299
    ms(
        {
            { trig = 'is_verbose', snippetType = 'snippet', condition = nil },
            { trig = 'verbose', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
                if($PSBoundParameters.ContainsKey('Verbose'))
                {{
                    {Code}
                }}
        ]],
            {
                Code = i(1, 'Extra debugging stuff here if verbose enabled'),
            }
        )
    ),

    ms(
        {
            { trig = 'empty', snippetType = 'snippet', condition = nil },
            { trig = '[string]::IsNullOrEmpty', snippetType = 'snippet', condition = nil },
        },
        fmt([[{Choices}]], {
            Choices = c(1, {
                sn(
                    nil,
                    fmt(
                        [[
                        if([string]::IsNullOrEmpty(${String}))
                        {{
                            {Code}
                        }}
                        ]],
                        {
                            String = i(1, 'StringName'),
                            Code = i(2, 'return'),
                        }
                    )
                ),

                sn(
                    nil,
                    fmt(
                        [[
                        [string]::IsNullOrEmpty(${String})
                        ]],
                        {
                            String = i(1, 'StringName'),
                        }
                    )
                ),
            }),
        })
    ),

    ms(
        {
            { trig = 'serial_port', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        $port = New-Object System.IO.Ports.SerialPort

        # Set the serial port parameters
        $port.PortName = "COM1"
        $port.BaudRate = 9600
        $port.Parity = [System.IO.Ports.Parity]::None
        $port.DataBits = 8
        $port.StopBits = [System.IO.Ports.StopBits]::One
        $port.Handshake = [System.IO.Ports.Handshake]::None

        # Open the port
        $port.Open()
        ]],
            {}
        )
    ),

    ms(
        {
            { trig = 'format string', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        "{FormatString}" -f {DynamicVariables}
        ]],
            {
                FormatString = i(1, '{0}'),
                DynamicVariables = d(2, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    local input = (args[1] or {})[1]
                    local _, variable_count = (input or ''):gsub('{[^}]+}', '')
                    for variable = 1, variable_count do
                        -- Insert comma before if not the first node
                        if variable > 1 then
                            table.insert(nodes, t(','))
                        end
                        table.insert(nodes, i(variable, string.format('Var%d', variable)))
                    end

                    return sn(nil, nodes)
                end, { 1 }),
            }
        )
    ),
    ms(
        {
            { trig = 'WriteFormatView', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
# Uses EZOut to format as specified here
# Generate by running ../Dots.EzFormat.ps1
# Generated output located ../Dots.format.ps1xml
Write-FormatView `
    -TypeName 'System.Text.RegularExpressions.Match' `
    -Name DotsRegexView `
    -Property Value, Index, Success, Groups `
    -StyleRow {
    $_.Success ? 'Foreground.Green' : 'Foreground.Red'
} `
    -AutoSize
        ]],
            {},
            { delimiters = '<>' }
        )
    ),
    ms(
        {
            { trig = 'environment_variable_set', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        [environment]::SetEnvironmentVariable('{Name}', {Value}, '{Scope}')
        ]],
            {
                Name = i(1, 'EnvironmentVariableName'),
                Value = c(2, {
                    i(1, 'Value'),
                    sn(
                        nil,
                        fmt([['{Value}']], {
                            Value = i(1, 'Value'),
                        })
                    ),
                }),

                Scope = c(3, {
                    t('User'),
                    t('Process'),
                    t('Machine'),
                }),
            }
        )
    ),
    ms(
        {
            { trig = 'mkdir', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        New-Item -ItemType Directory -ErrorAction SilentlyContinue
        ]],
            {}
        )
    ),
    ms(
        {
            { trig = 'ShouldProcess', snippetType = 'snippet', condition = nil },
            { trig = 'WhatIf', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        [CmdletBinding(SupportsShouldProcess)]

        if ($PSCmdlet.ShouldProcess("{Message}"))
        {{
            {Actual}
        }}
        else
        {{
            # WhatIf code, should not perform any actions
            {WhatIf}
        }}
        ]],
            {
                Message = i(1, 'Message about the impact of this command'),
                Actual = i(2),
                WhatIf = i(3),
            }
        )
    ),
    ms(
        {
            { trig = 'readonly', snippetType = 'snippet', condition = nil },
            { trig = 'Set-Variable', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    Set-Variable -Name {Name} -Value {Value} -Option ReadOnly
    ]],
            {
                Name = i(1, 'MyVariable'),
                Value = i(2, '1234'),
            }
        )
    ),

    ms(
        {
            { trig = 'argument_completer_native', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
            $scriptblock = {
                param(
                    $wordToComplete,
                    $commandAst,
                    $cursorPosition
                )

            dotnet complete --position $cursorPosition $commandAst.ToString() | ForEach-Object {
                    [System.Management.Automation.CompletionResult]::new(
                        $_,               # completionText
                        $_,               # listItemText
                        'ParameterValue', # resultType
                        $_                # toolTip
                    )
                }
            }

            Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock
        ]],
            {},
            { delimiters = '<>' }
        )
    ),

    ms(
        {
            { trig = 'argument_completer_powershell', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
                    $s = {
                        param(
                            $commandName,
                            $parameterName,
                            $wordToComplete,
                            $commandAst,
                            $fakeBoundParameters
                        )

                    $services = Get-Service | Where-Object {
                            $_.Status -eq 'Running' -and $_.Name -like "$wordToComplete*"
                        }

                    $services | ForEach-Object {
                            New-Object -Type System.Management.Automation.CompletionResult -ArgumentList @(
                                $_.Name          # completionText
                                $_.Name          # listItemText
                                'ParameterValue' # resultType
                                $_.Name          # toolTip
                            )
                        }
                    }

                    Register-ArgumentCompleter -CommandName Stop-Service -ParameterName Name -ScriptBlock $s
        ]],
            {},
            { delimiters = '<>' }
        )
    ),

    ms(
        {
            { trig = 'override tostring', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[

    [string]ToString()
    {{
        $fileName = ($this.Path -split '[/\\]' | Select-Object -Last 1)
        return "$($this.Enabled) : $fileName"
    }}
        ]],
            {}
        )
    ),
    ms(
        {
            { trig = 'FTP', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        # https://www.opentechguides.com/how-to/article/powershell/154/directory-listing.html

# Function to get directory listing
Function Get-FTPFileList {

Param (
 [System.Uri]$server,
 [string]$username,
 [string]$password,
 [string]$directory

)

try
 {
    #Create URI by joining server name and directory path
    $uri =  "$server$directory"

    #Create an instance of FtpWebRequest
    $FTPRequest = [System.Net.FtpWebRequest]::Create($uri)

    #Set the username and password credentials for authentication
    $FTPRequest.Credentials = New-Object System.Net.NetworkCredential($username, $password)

    #Set method to ListDirectoryDetails to get full list
    #For short listing change ListDirectoryDetails to ListDirectory
    $FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails

    #Get FTP response
    $FTPResponse = $FTPRequest.GetResponse()

    #Get Reponse data stream
    $ResponseStream = $FTPResponse.GetResponseStream()

    #Read data Stream
    $StreamReader = New-Object System.IO.StreamReader $ResponseStream

    #Read each line of the stream and add it to an array list
    $files = New-Object System.Collections.ArrayList
    While ($file = $StreamReader.ReadLine())
     {
       [void] $files.add("$file")

    }

}
catch {
    #Show error message if any
    write-host -message $_.Exception.InnerException.Message
}

    #Close the stream and response
    $StreamReader.close()
    $ResponseStream.close()
    $FTPResponse.Close()

    Return $files


}

#Set server name, user, password and directory
$server = 'ftp://servername/'
$username = 'ftp_user'
$password = 'ftp_passwd'
$directory ='directory_path'

#Function call to get directory listing
$filelist = Get-FTPFileList -server $server -username $username -password $password -directory $directory

#Write output
Write-Output $filelist
        ]],
            {},
            { delimiters = '<>' }
        )
    ),
    ms(
        {
            { trig = '$\\(\\)', regTrig = false, snippetType = 'autosnippet', condition = nil },
        },
        fmt([[$({})]], {
            i(1),
        })
    ),

    ms(
        {
            { trig = 'error', snippetType = 'snippet', condition = nil },
            { trig = 'error action', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[-ErrorAction {Options}]], {
            Options = c(1, {
                t('SilentlyContinue'),
                t('Stop'),
                t('Break'),
                t('Ignore'),
                t('Inquire'),
                t('Suspend'),
                t('Continue'),
            }),
        })
    ),

    ms(
        {
            { trig = 'custom object', snippetType = 'snippet', condition = nil },
        },
        fmt([[{Custom}]], {
            Custom = CustomObject(1),
        })
    ),

    ms(
        {
            { trig = 'pipelineInput', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string]$pipelineInput
)

Begin {
    <BeginWork>
}

Process {
    <ProcessWork>
}

End {
    <EndWork>
}
        ]],
            {
                BeginWork = i(1, 'echo start processing'),
                ProcessWork = i(2, 'ForEach-Object { $_ }'),
                EndWork = i(3, 'echo end processing'),
            },
            {
                delimiters = '<>',
            }
        )
    ),

    ms(
        {
            { trig = 'Update-TypeData', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        Update-TypeData -TypeName {TypeName} -DefaultDisplayPropertySet {ListOfPropertiesToShow} CreatedBy -ErrorAction SilentlyContinue
        ]],
            {
                TypeName = i(1, 'MyClass'),
                ListOfPropertiesToShow = i(2, 'Id, Count, Sum'),
            }
        )
    ),

    ms(
        {
            { trig = 'ENUM', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
enum {Name} {{
    {Items}
}}
        ]],
            {
                Name = i(1, 'MyEnum'),
                Items = i(2, 'Item1'),
            }
        )
    ),

    ms(
        {
            { trig = 'CLASS', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
class {ClassName} {{
    [{PropertyType}]${PropertyName}

    {RepeatClassName}([{RepeatPropertyType}]${RepeatPropertyName}) {{
        $this.{RepeatPropertyName} = ${RepeatPropertyName}
    }}
}}
        ]],
            {

                ClassName = i(1, 'MyClass'),
                PropertyType = i(2, 'string'),
                PropertyName = i(3, 'PropertyName'),
                RepeatClassName = rep(1),
                RepeatPropertyType = rep(2),
                RepeatPropertyName = rep(3),
            }
        )
    ),

    ms(
        {
            { trig = 'pester_mock', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [[
        # Mock git to intercept and inspect the call
        Mock git {{}}

        # Command to run
        dot 'git' 'status'

        # Assert that git was called with 'status' only
        Assert-MockCalled git -Exactly 1 -Scope It -ParameterFilter {{ $Args -contains 'status' -and $Args.Contains('git') -eq $false }}
        ]],
            {}
        )
    ),

    ms({
        { trig = 'test', snippetType = 'snippet', condition = nil },
        { trig = 'TEST', snippetType = 'autosnippet', condition = conds.line_begin },
    }, { PesterTest(1) }),

    ms({
        { trig = 'describe describe', snippetType = 'snippet', condition = nil },
        { trig = 'DESCRIBE', snippetType = 'autosnippet', condition = conds.line_begin },
    }, { PesterTestGroup(1) }),

    ms({
        { trig = 'skip', snippetType = 'snippet', condition = nil },
        { trig = 'skip skip', snippetType = 'autosnippet', condition = nil },
    }, {
        PesterTestSkip(1),
    }),

    ms({
        { trig = 'ASSERT', snippetType = 'autosnippet', condition = conds.line_begin },
        { trig = 'assert', snippetType = 'snippet', condition = nil },
    }, { PesterAssert(1) }),

    ms(
        {
            { trig = 'FILE_TEST', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = 'test_file', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        BeforeAll {{
            Import-Module $PSScriptRoot/../*.psd1 -Force
        }}

        {Test}
        ]],
            {
                Test = PesterTestGroup(1),
            }
        )
    ),

    ms(
        {
            { trig = 'const', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        Set-Variable {Name} -Option Constant -Value {Value}
        ]],
            {
                Name = i(1, 'MyConstVariable'),
                Value = i(2, '"Value"'),
            }
        )
    ),

    ms(
        {
            { trig = 'ValidateSet', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt([=[[ValidateSet({Items})]]=], {
            Items = i(1, 'One, Two, Three'),
        })
    ),

    ms(
        {
            { trig = 'ValidatePattern', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt(
            [=[
        [ValidatePattern('{Pattern}')]
        ]=],
            {
                Pattern = i(1, '.*'),
            }
        )
    ),
    ms(
        {
            { trig = 'ValidateCount', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt('[ValidateCount(int {minLength}, int {maxLength})]', {
            minLength = i(1, '0'),
            maxLength = i(2, '100'),
        })
    ),
    ms(
        {
            { trig = 'ValidateLength', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt('[ValidateLength(int {minLength}, int {maxLength})]', {
            minLength = i(1, '20'),
            maxLength = i(2, '100'),
        })
    ),
    ms({
        { trig = 'ValidatePathExists', snippetType = 'snippet', condition = nil },
    }, fmt('[ValidateScript({{ Test-Path -Path $_ -PathType Leaf }})]', {})),

    ms(
        {
            { trig = 'ValidateScript', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [=[
        [ValidateScript(
        {{{ValidationLogic}}},
        ErrorMessage = "{ErrorMessage}"
        )]
        ]=],
            {
                ValidationLogic = i(1, '$_ -ge (Get-Date).Date'),
                ErrorMessage = i(2, [[{0:d} isn't a future date. Specify a later date.]]),
            }
        )
    ),

    ms(
        {
            { trig = 'ProgramExists', snippetType = 'snippet', condition = nil },
            { trig = 'which', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    if(-not $(Get-Command {Program} -ErrorAction SilentlyContinue))
    {{
        throw "The command [{RepProgram}] {Message}"
    }}
        ]],
            {
                Program = i(1, 'podman'),
                RepProgram = rep(1),
                Message = i(2, 'not found cannot continue program'),
            }
        )
    ),

    ms(
        {
            { trig = '$?', snippetType = 'snippet', condition = nil },
            { trig = 'last', snippetType = 'snippet', condition = nil },
            { trig = 'success', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
    if(-not $? -or $LASTEXITCODE -ne 0)
    {{
         {HandleOption}
    }}
        ]],
            {
                HandleOption = c(1, {
                    sn(
                        nil,
                        fmt(
                            [[
          throw "{Message}"
          ]],
                            {
                                Message = r(1, 'Error the last command did not work'),
                            }
                        )
                    ),
                    sn(
                        nil,
                        fmt(
                            [[
          Write-Error "{Message}"
          ]],
                            {
                                Message = r(1, 'Error the last command did not work'),
                            }
                        )
                    ),
                }),
            }
        )
    ),

    ms(
        {
            { trig = '###', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt([[{}]], {
            c(1, {

                -- Short version
                fmt(
                    [[
    <#
        .SYNOPSIS
        {Synopsis}

        .DESCRIPTION
        {Description}

        .PARAMETER Name
        {Parameter}

        .EXAMPLE
        {Example}
    #>
                  ]],
                    {
                        Synopsis = i(1, 'Adds a file name extension to a supplied name.'),
                        Description = i(
                            2,
                            'Adds a file name extension to a supplied name. Takes any strings for the file name or extension.'
                        ),
                        Parameter = i(3, 'Specifies the file name.'),
                        Example = i(4, 'Add-Extension -name "File"'),
                    }
                ),

                -- Full version
                fmt(
                    [[
    <#
        .SYNOPSIS
        Adds a file name extension to a supplied name.

        .DESCRIPTION
        Adds a file name extension to a supplied name.
        Takes any strings for the file name or extension.

        .PARAMETER Name
        Specifies the file name.

        .PARAMETER Extension
        Specifies the extension. "Txt" is the default.

        .INPUTS
        None. You can't pipe objects to Add-Extension.

        .OUTPUTS
        System.String. Add-Extension returns a string with the extension or file name.

        .EXAMPLE
        PS> Add-Extension -name "File"
        File.txt

        .EXAMPLE
        PS> Add-Extension -name "File" -extension "doc"
        File.doc

        .EXAMPLE
        PS> Add-Extension "File" "doc"
        File.doc

        .LINK
        Online version: http://www.fabrikam.com/add-extension.html

        .LINK
        Set-Item
    #>
                  ]],
                    {}
                ),
            }),
        })
    ),

    ms(
        {
            { trig = '.example', snippetType = 'snippet', condition = nil },
            { trig = '.example', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
      .EXAMPLE
      {Text}
      ]],
            {
                Text = i(1, 'Show the example code'),
            }
        )
    ),

    s(
        'list',
        fmt('${} = New-Object System.Collections.Generic.List[string]', {
            i(1),
        })
    ),

    ms({
        { trig = 'param_block', snippetType = 'snippet', condition = conds.line_begin },
        { trig = 'param block', snippetType = 'autosnippet', condition = conds.line_begin },
    }, param_block(1)),

    ms({
        { trig = 'param', snippetType = 'snippet', condition = conds.line_begin },
        { trig = 'param param', snippetType = 'autosnippet', condition = conds.line_begin },
    }, param(1)),

    -- s(
    --     'param',
    --     fmt(
    --         [[
    -- {}[Parameter(
    --     Mandatory=${},
    --     ValueFromPipeline=$true,
    --     ValueFromPipelineByPropertyName=$true,
    --     ValueFromRemainingArguments=$false,
    --     Position=0,
    --     ParameterSetName='Parameter Set 1')]
    -- [{}]${}
    --     ]],
    --         {
    --             c(1, {
    --                 t(''),
    --                 t(','),
    --             }),
    --
    --             c(2, {
    --                 t('true'),
    --                 t('false'),
    --             }),
    --             c(3, {
    --                 t('switch'),
    --                 i(1, 'WriteYourOwnType'),
    --                 t('string'),
    --                 t('int32'),
    --             }),
    --             i(4, 'VariableName'),
    --         }
    --     )
    -- ),

    s(
        'get-date',
        fmt(
            [[
     Get-Date -Format "{}"
        ]],
            {
                i(1, 'yyyy-MM-dd'),
            }
        )
    ),

    ms({
        { trig = 'REGMATCH', snippetType = 'autosnippet', condition = conds.line_begin },
    }, {
        c(1, {
            sn(
                nil,
                fmt(
                    [[
                [regex]::Match({String}, {Pattern})
                ]],
                    {

                        String = i(1, 'input'),
                        Pattern = i(2, '.*'),
                    }
                )
            ),
            sn(
                nil,
                fmt(
                    [[
                if({String} -cmatch '{Pattern}')
                {{
                    {Code}
                }}
                ]],
                    {
                        String = i(1, 'input'),
                        Pattern = i(2, '.*'),
                        Code = i(3),
                    }
                )
            ),
        }),
    }),

    ms(
        {
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet' },
        },
        fmt(
            -- Old method
            [[[regex]::Matches({String}, '{Pattern}']],
            {
                String = i(1, 'input'),
                Pattern = i(2, '.*'),
            }
        )
    ),

    ms(
        {
            { trig = 'process', snippetType = 'snippet', condition = nil },
            { trig = 'process process', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
            process {{
                {Code}
            }}
            ]],
            {
                Code = i(1),
            }
        )
    ),
    ms(
        {
            { trig = 'begin', snippetType = 'snippet', condition = nil },
            { trig = 'begin begin', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
            begin {{
                {Code}
            }}
            ]],
            {
                Code = i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'end', snippetType = 'snippet', condition = nil },
            { trig = 'end end', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
            end {{
                {Code}
            }}
            ]],
            {
                Code = i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'WHILE', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[{Choices}
        ]],
            {
                Choices = c(1, {
                    sn(
                        nil,
                        fmt(
                            [[
                            while ({Condition})
                            {{
                                {Code}
                            }}
                            ]],
                            {
                                Condition = i(1, '$true'),
                                Code = i(2),
                            }
                        )
                    ),

                    sn(
                        nil,
                        fmt(
                            [[
                            do {{
                                {Code}
                            }} while ({Condition})
                            ]],
                            {
                                Condition = i(1, '$true'),
                                Code = i(2),
                            }
                        )
                    ),
                }),
            }
        )
    ),

    ms(
        {
            { trig = 'FOR', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        for(${Variable} = {InitialValue}; ${RepeatVariable} {Condition}; ${RepeatVariable}{Operation}){{
            {Code}
        }}
        ]],
            {
                Variable = i(1, 'i'),
                InitialValue = i(2, '0'),
                RepeatVariable = rep(1),
                Condition = i(3, '-lt 10'),
                Operation = i(4, '++'),
                Code = i(5),
            }
        )
    ),

    ms(
        {
            { trig = '\\\\', snippetType = 'autosnippet', condition = nil },
        },
        fmt([[{}]], {
            c(1, {
                -- t('(?<{NamedCaptureGroup})}'),
                sn(
                    nil,
                    fmt([[(?<{NamedCaptureGroup}>{Pattern})]], {
                        NamedCaptureGroup = i(1, 'NamedCaptureGroup'),
                        Pattern = i(2, '.*'),
                    })
                ),
                -- https://learn.microsoft.com/en-us/dotnet/standard/base-types/character-classes-in-regular-expressions
                t('(?# Letter, Uppercase)\\p{Lu}'),
                t('(?# Letter, Lowercase)\\p{Ll}'),
                t('(?# Letter, Titlecase)\\p{Lt}'),
                t('(?# Letter, Modifier)\\p{Lm}'),
                t('(?# Letter, Other)\\p{Lo}'),
                t('(?# All letter characters. This includes the Lu, Ll, Lt, Lm, and Lo characters.)\\p{L}'),
                t('(?# Mark, Nonspacing)\\p{Mn}'),
                t('(?# Mark, Spacing Combining)\\p{Mc}'),
                t('(?# Mark, Enclosing)\\p{Me}'),
                t('(?# All combining marks. This includes the Mn, Mc, and Me categories.)\\p{M}'),
                t('(?# Number, Decimal Digit)\\p{Nd}'),
                t('(?# Number, Letter)\\p{Nl}'),
                t('(?# Number, Other)\\p{No}'),
                t('(?# All numbers. This includes the Nd, Nl, and No categories.)\\p{N}'),
                t('(?# Punctuation, Connector)\\p{Pc}'),
                t('(?# Punctuation, Dash)\\p{Pd}'),
                t('(?# Punctuation, Open)\\p{Ps}'),
                t('(?# Punctuation, Close)\\p{Pe}'),
                t('(?# Punctuation, Initial quote (may behave like Ps or Pe depending on usage))\\p{Pi}'),
                t('(?# Punctuation, Final quote (may behave like Ps or Pe depending on usage))\\p{Pf}'),
                t('(?# Punctuation, Other)\\p{Po}'),
                t(
                    '(?# All punctuation characters. This includes the Pc, Pd, Ps, Pe, Pi, Pf, and Po categories.)\\p{P}'
                ),
                t('(?# Symbol, Math)\\p{Sm}'),
                t('(?# Symbol, Currency)\\p{Sc}'),
                t('(?# Symbol, Modifier)\\p{Sk}'),
                t('(?# Symbol, Other)\\p{So}'),
                t('(?# All symbols. This includes the Sm, Sc, Sk, and So categories.)\\p{S}'),
                t('(?# Separator, Space)\\p{Zs}'),
                t('(?# Separator, Line)\\p{Zl}'),
                t('(?# Separator, Paragraph)\\p{Zp}'),
                t('(?# All separator characters. This includes the Zs, Zl, and Zp categories.)\\p{Z}'),
                t('(?# Other, Control A.K.A. non printables)\\p{Cc}'),
                t('(?# Other, Format)\\p{Cf}'),
                t('(?# Other, Surrogate)\\p{Cs}'),
                t('(?# Other, Private Use)\\p{Co}'),
                t('(?# Other, Not Assigned or Noncharacter)\\p{Cn}'),
                t('(?# All other characters. This includes the Cc, Cf, Cs, Co, and Cn categories.)\\p{C}'),
                t('\\d'),
                t('\\d+'),
                t('\\d*'),
                t('\\w'),
                t('\\w+'),
                t('\\w*'),
                t('\\s'),
                t('\\s+'),
                t('\\s*'),
                -- My awesome regexes with descriptions
                t('?# Non vowels, uses range subtraction)[a-zA-Z-[aeiouAEIOU]]'),
            }),
        })
    ),
}

local autosnippets = {
    s(
        'IF',
        fmt(
            [[
        if({})
        {{
            {}
        }}
        {}{}
        ]],
            {
                i(1),
                i(2),
                i(3),
                m(3, 'else', 'no'),
            }
        )
    ),

    s(
        'ELS_EI_F',
        fmt(
            [[
        elseif({})
        {{
            {}
        }}
        ]],
            {
                i(1),
                i(2),
            }
        )
    ),

    s(
        'ELSE',
        fmt(
            [[
        else
        {{
            {}
        }}
        ]],
            {
                i(1),
            }
        )
    ),

    ms(
        {
            { trig = 'SWITCH', snippetType = 'autosnippet' },
        },
        fmt(
            [[
        switch {Options} ({Expression}) {{
            {MatchValue} {{ {Code} }}
            default {{ {DefaultCode} }}
        }}
        ]],
            {
                Options = c(1, {
                    t('-Regex'),
                    t(''),
                    t('-Wildcard'),
                    t('-Exact'),
                    t('-CaseSensitive'),
                    t('-File'),
                }),
                Expression = i(2, 'Variable'),
                MatchValue = i(3, '"Match this value"'),
                Code = i(4, 'echo run this code'),
                DefaultCode = i(5, 'Write-Error "This code fails"'),
            }
        )
    ),

    ms(
        {
            { trig = 'function', snippetType = 'snippet', condition = nil },
            { trig = 'FUNCTION', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
        function {Verb}-{Noun} {{
            {ParamBlock}
            {Code}
        }}
        ]],
            {
                Verb = ApprovedVerb(1),
                Noun = i(2, 'Noun'),
                ParamBlock = param_block(3),
                Code = i(4),
            }
        )
    ),

    ms(
        {
            { trig = 'Write-Host', snippetType = 'snippet' },
            { trig = 'PRINT', snippetType = 'autosnippet' },
            { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
            { trig = 'Write-Output', snippetType = 'snippet' },
        },
        fmt([[{}]], {
            d(1, function(args, snip)
                local nodes = {}

                local printFunctionToUse = ''

                if snip.trigger == 'ERRORPRINT' or snip.trigger == 'Write-Error' then
                    printFunctionToUse = 'Error'
                elseif snip.trigger == 'PRINT' or snip.trigger == 'Write-Information' then
                    printFunctionToUse = 'Information'
                else
                    printFunctionToUse = 'Output'
                end

                table.insert(
                    nodes,
                    sn(
                        1,
                        fmt(
                            [[
                    Write-{FunctionToUse} "{Text}"
                    ]],
                            {
                                FunctionToUse = t(printFunctionToUse),
                                Text = i(1),
                            }
                        )
                    )
                )

                return sn(nil, nodes)
            end, {}),
        })
    ),

    ms(
        {
            { trig = 'Write-Host', snippetType = 'snippet' },
            -- { trig = 'PRINT', snippetType = 'autosnippet' },
            -- { trig = 'Write-Host', snippetType = 'snippet' },
            -- { trig = 'ERRORPRINT', snippetType = 'autosnippet' },
            -- { trig = 'Write-Output', snippetType = 'snippet' },
        },
        fmt(
            [[
            {}
        ]],
            {

                d(1, function(args, snip)
                    local nodes = {}

                    local write_host = sn(
                        nil,
                        fmt(
                            [[
                     Write-Host "{}" -ForegroundColor {} -BackgroundColor {}
                     ]],
                            {
                                i(1),
                                c(2, powershell_foreground_highlights),
                                c(3, powershell_background_highlights),
                            }
                        )
                    )

                    local write_output = sn(
                        nil,
                        fmt(
                            [[
                    Write-Output "{}"
                    ]],
                            {
                                i(1),
                            }
                        )
                    )

                    local write_error = sn(
                        nil,
                        fmt(
                            [[
                    Write-Error "{}"
                    ]],
                            {
                                i(1),
                            }
                        )
                    )

                    local choices = {
                        write_error,
                        write_host,
                        write_output,
                    }

                    -- local function tableMoveFirstToLast(items)
                    --     local firstItem = items[1]
                    --     table.remove(items, 1)
                    --     items[#items + 1] = firstItem
                    -- end
                    -- if snip.trigger ~= 'ERRORPRINT' then
                    --     tableMoveFirstToLast(choices)
                    -- end

                    table.insert(nodes, c(1, choices))

                    return sn(nil, nodes)
                end, {}),
            }
        )
    ),

    ms(
        {
            { trig = 'foreach', snippetType = 'snippet', condition = nil },
            { trig = 'FREACH', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        foreach ({Item} in {Collection})
        {{
            {Code}
        }}
        ]],
            {
                Item = i(1, 'item'),
                Collection = i(2, 'collection'),
                Code = i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'ForEach-Object', snippetType = 'snippet' },
            { trig = 'ForEach-Object { $_', snippetType = 'autosnippet', wordTrig = false },
        },
        fmt([[{}]], {
            c(1, {
                sn(
                    nil,
                    fmt([[ForEach-Object {{ {} }}]], {
                        i(1),
                    })
                ),

                -- Full foreach-object
                sn(
                    nil,
                    fmt(
                        [[
                ForEach-Object -Begin {
                     <Begin>
                 } -Process {
                     <Process>
                } -End {
                     <End>
                }
                ]],
                        {
                            Begin = i(1, '$sum = 0'),
                            Process = i(2, '$sum += $_'),
                            End = i(3, '$sum'),
                        },

                        {
                            delimiters = '<>',
                        }
                    )
                ),
            }),
        })
    ),

    s(
        'TRY',
        fmt(
            [[
        try
        {{
            {}
        }}
        catch
        {{
            {}
        }}
        {}
        ]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),
}

return snippets, autosnippets
