# $page = Invoke-WebRequest 'https://www.lua.org/manual/5.4/manual.html'
#
# #region AgilityPackExample
# $agility_output = ConvertFrom-HTML -Content $page.Content -Engine AgilityPack
# #endregion
#
# #region AngleSharpExample
# $angle_output = ConvertFrom-HTML -Content $page.Content -Engine AngleSharp
#
# # CSS Selector: 'a[name^="pdf-"] code'
# #
# # This matches all <code> elements that are:
# # - Inside an <a> (anchor) element
# # - Where the <a> element has a "name" attribute starting with "pdf-"
# #
# # For example, it will match this structure:
# #
# # <a name="pdf-string.find">
# #   <code>string.find (s, pattern [, init [, plain]])</code>
# # </a>
# #
# # It will NOT match <code> elements that are:
# # - Outside <a> tags
# # - Inside <a> tags where name does not start with "pdf-"
# $angle_output.QuerySelectorAll('a[name^="pdf-"] code') |
#     Select-Object @{ Name = 'CodeText'; Expression = { $_.TextContent.Trim() } } |
#     Where-Object { $_ -match '\(' }
#
#
# #endregion

#region Powershell blessed parameter names
# Select the 156 blessed powershell parameter names
$powershell_version = '7.5'
$pages = @(
    "activity-parameters"
    "date-and-time-parameters"
    "format-parameters"
    "property-parameters"
    "quantity-parameters"
    "resource-parameters"
    "security-parameters"
)

$pages | ForEach-Object {
    Invoke-RestMethod "https://learn.microsoft.com/en-us/powershell/scripting/developer/cmdlet/${_}?view=powershell-7.5"
} | ForEach-Object {
    (ConvertFrom-Html -Content $_ -Engine AngleSharp).QuerySelectorAll('tr td strong') | Select-Object -ExpandProperty TextContent
} | Sort-Object -Unique


#endregion
