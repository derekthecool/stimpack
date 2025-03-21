---@diagnostic disable: undefined-global

local shareable = require('luasnippets.functions.shareable_snippets')

local function true_or_false_choice_node(index)
    return c(index, {
        t('$false'),
        t('$true'),
    })
end

local function param(index)
    return sn(
        index,
        fmt(
            [[
     [Parameter(Mandatory = {Required}, ValueFromPipeline = {FromPipeline})]
         [{Type}]${ParamName}
     ]],
            {
                Required = true_or_false_choice_node(1),
                FromPipeline = true_or_false_choice_node(2),
                Type = i(3, 'string'),
                ParamName = i(4, 'ParamName'),
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
                        nil,
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

local powershell_foreground_highlights = {
    t('Gray'),
    t('Green'),
    t('Yellow'),
    t('Red'),
    t('Blue'),
    t('Cyan'),
    t('Magenta'),
    t('White'),
    t('Black'),
    t('DarkBlue'),
    t('DarkGreen'),
    t('DarkCyan'),
    t('DarkRed'),
    t('DarkMagenta'),
    t('DarkYellow'),
    t('DarkGray'),
}
local powershell_background_highlights = {
    t('Black'),
    t('DarkGreen'),
    t('DarkYellow'),
    t('DarkRed'),
    t('DarkBlue'),
    t('DarkCyan'),
    t('DarkMagenta'),
    t('Gray'),
    t('DarkGray'),
    t('Blue'),
    t('Green'),
    t('Cyan'),
    t('Red'),
    t('Magenta'),
    t('Yellow'),
    t('White'),
}

local function PesterTest(index)
    return sn(
        index,
        fmt(
            [[
    Describe '{TestGroupName}' {{
        It '{TestDescription}' {{
            {Assertion}
        }}
    }}
    ]],
            {
                TestGroupName = i(1, 'Test group'),
                TestDescription = i(2, 'This test does ....'),
                Assertion = i(3, '$(Get-ChildItem).Count | Should -Be 42'),
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
            { trig = 'New-Alias', snippetType = 'snippet', condition = nil },
            { trig = 'alias', snippetType = 'snippet', condition = nil },
        },
        fmt([[New-Alias -Name '{Name}' -Value {Value}]], {
            Name = i(1, 'Name'),
            Value = i(2, 'Value'),
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
            { trig = 'Write-FormatView', snippetType = 'snippet', condition = nil },
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
            { trig = 'hash table', snippetType = 'autosnippet', condition = nil },
        },
        fmt(
            [[
        @{{
            {Items}
        }}
        ]],
            {
                Items = i(1),
            }
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

    ms(
        {
            { trig = 'TEST', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = 'test', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[It '<TestDescription>'
            <Multiple>
            {
                <Code>
            }
        ]],
            {
                TestDescription = i(1, 'This test should do ....'),
                Multiple = c(2, {
                    t(''),
                    sn(
                        nil,
                        fmt(
                            [[-TestCases @(
                                @{ <Variable> = <Value> }
                            )
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

                Code = i(3),
            },
            {
                delimiters = '<>',
            }
        )
    ),

    ms(
        {
            { trig = 'ASSERT', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = 'assert', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        {Input} | Should -{Option}
        ]],
            {
                Input = i(1, 'VariableOrCommand'),
                Option = c(2, {
                    t('Be'),
                    t('Throw'),
                    t('BeOfType'),
                    t('BeTrue'),
                    t('BeFalse'),
                    t('HaveCount'),
                    i(1),
                }),
            }
        )
    ),

    ms(
        {
            { trig = 'FILE_TEST', snippetType = 'autosnippet', condition = conds.line_begin },
            { trig = 'test_file', snippetType = 'snippet', condition = nil },
        },
        fmt(
            [[
        BeforeAll {{
            . {Filename}
        }}

        {Test}
        ]],
            {
                Filename = d(1, function(args, snip)
                    local nodes = {}

                    -- Add nodes for snippet
                    local scandir = require('plenary.scandir')
                    local files = scandir.scan_dir(
                        string.format('%s/..', vim.fn.expand('%:h')),
                        { respect_gitignore = true, search_pattern = '%.ps1' }
                    )

                    for _, value in ipairs(files) do
                        table.insert(nodes, t(value))
                    end

                    -- local choices = c(1, nodes)

                    return sn(nil, {
                        c(1, nodes),
                    })
                end, {}),
                Test = PesterTest(2),
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
        Write-Error "The command [{RepProgram}] {Message}"
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
    if(-not $?)
    {{
         Write-Error "{Message}"
         {HandleOption}
    }}
        ]],
            {
                Message = i(1, 'Error, the last command did not work'),
                HandleOption = c(2, {
                    i(1, 'exit'),
                    t('return'),
                }),
            }
        )
    ),

    ms(
        {
            { trig = '###', snippetType = 'snippet', condition = conds.line_begin },
        },
        fmt([[{}]], {
            c(1, {

                -- Short version

                sn(
                    nil,
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
                            Example = i(4, 'PS> Add-Extension -name "File"'),
                        }
                    )
                ),

                -- Full version
                sn(
                    nil,
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
                    )
                ),
            }),
        })
    ),

    s(
        'list',
        fmt('${} = New-Object System.Collections.Generic.List[string]', {
            i(1),
        })
    ),

    s(
        'script',
        fmt(
            [[
        <#
        .Name
           {}
        .Synopsis
           {}
        .DESCRIPTION
           {}
        .EXAMPLE
           Example of how to use this cmdlet
        .EXAMPLE
           Another example of how to use this cmdlet
        .INPUTS
           Inputs to this cmdlet (if any)
        .OUTPUTS
           Output from this cmdlet (if any)
        .NOTES
           General notes
        .COMPONENT
           The component this cmdlet belongs to
        .ROLE
           The role this cmdlet belongs to
        .FUNCTIONALITY
           The functionality that best describes this cmdlet
        #>
        [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
            SupportsShouldProcess=$true,
            PositionalBinding=$false,
            HelpUri = 'http://www.microsoft.com/',
            ConfirmImpact='Medium')]
        [Alias()]
        [OutputType([String])]
        Param
        (
            [Parameter(Mandatory=$true,
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true,
                ValueFromRemainingArguments=$false)]
            [ValidateNotNull()]
            [ValidateNotNullOrEmpty()]
            # Checks to make sure path is valid first
            # [ValidateScript({{Test-Path $_}})]
            # [ValidateLength(1,5)]
            # [ValidatePattern('match this regex .*')]
            # [ValidateCount(0,5)]
            # [ValidateSet('sun', 'moon', 'earth')]
            # [Alias('p1','test','anothername')]
            ${}
        )

        Begin
        {{
            {}
        }}
        Process
        {{
            if ($pscmdlet.ShouldProcess("Target", "Operation"))
            {{
                {}
            }}
        }}
        End
        {{
            {}
        }}
        ]],
            {
                f(function(args, snip)
                    return vim.fn.expand('%:t')
                end, {}),
                i(1, 'Short script description'),
                i(2, 'Long script description'),
                i(3, 'param1'),
                i(4, 'echo "start code"'),
                i(5, 'echo "perform code"'),
                i(6, 'echo "end code"'),
            }
        )
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

    ms(
        {
            { trig = 'REGMATCH', snippetType = 'autosnippet', condition = conds.line_begin },
        },
        fmt(
            [[
    if({String} -cmatch '{Pattern}')
    {{
        {Code}
    }}
        ]],
            {
                String = i(1, 'string to match'),
                Pattern = i(2, '.*'),
                Code = i(3),
            }
        )
    ),

    ms(
        {
            { trig = 'ALLREGMATCH', snippetType = 'autosnippet' },
        },
        fmt(
            -- Old method
            -- [regex]::Matches({Source}, '{Pattern}', 'IgnorePatternWhitespace') | ForEach-Object {{ $_.{DoSomething} }}
            -- New method uses PSScriptTools function ConvertFrom-Text
            [[ConvertFrom-Text '{Pattern}']],
            {
                Pattern = i(1, '.*'),
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
            { trig = 'FREACH', snippetType = 'autosnippet' },
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
