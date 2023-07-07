function New-CitrixTemplateGroup {
    <#
    .SYNOPSIS
    Creates a new Group in the Citrix Optimizer template.

    .DESCRIPTION
    This function will create a Group in the Citrix Optimizer template. First it will check if that group exists, if not it will add it.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .PARAMETER GroupName
    Specifies the Group Name to create

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Group creation state

    .EXAMPLE
    PS> New-CitrixTemplateGroup -Path 'template.xml' -GroupName 'OS Optimizations' 
    Creates a new Group called "OS Optimizations" in the template file.

    .LINK
    https://github.com/dbretty/Citrix.Optimizer.Template/blob/main/Help/New-CitrixTemplateGroup.MD
#>

[CmdletBinding()]

Param (
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$Path,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$GroupName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$GroupDescription
)

begin {

        # Set strict mode and initial return value
        Set-StrictMode -Version Latest

        # Set up PSCustom Object for return
        $Return = New-Object -TypeName psobject 
        $Return | Add-Member -MemberType NoteProperty -Name "Complete" -Value $false

} # begin

process {

    if(Get-Template -Path $Path){

        write-verbose "Template $($Path) found"
        write-verbose "Load Template"

        # Load Template and check for existing Group"
        [XML]$xmlfile = Get-Content $Path

        $Found = $false
        $Count = ($xmlfile.SelectNodes('//root/group')).Count
        write-verbose "Number of groups found: $($Count)"

        # Groups found, check if group already exists
        if($Count -ne 0){
            foreach($Group in $XMLFile.root.group){
                if($Group.id -eq $GroupName){
                    write-verbose "Group $($GroupName) already exists"
                    $Found = $true
                }
            }
        } else {
            write-verbose "No existing Groups found, adding new group"
        }

        if(!($Found)){

            write-verbose "Create Group element"
            $Group = $XMLFile.CreateElement("group")
        
            write-verbose "Create ID element"
            $ID = $XMLFile.CreateElement("id")
            $ID.InnerText = $GroupName
            $Group.AppendChild($ID)   
        
            write-verbose "Create DisplayName element"
            $Name = $XMLFile.CreateElement("displayname")
            $Name.InnerText = $GroupName
            $Group.AppendChild($Name)   
        
            write-verbose "Create Description element"
            $Description = $XMLFile.CreateElement("description")
            $Description.InnerText = $GroupDescription
            $Group.AppendChild($Description)   
        
            write-verbose "Add Group to XML Template"
            $XMLFile.LastChild.AppendChild($Group)
            $XMLFile.Save($Path) 
    
            $Return.Complete = $true
    
        } else {
    
            write-verbose "Group already exists - quitting"
            write-error "Group already exists - quitting"
    
        }

    } else {

        write-verbose "Template not found - quitting"
        write-error "Template not found - quitting"

    }

} # process

end {
    
    return $Return

} # end

}
