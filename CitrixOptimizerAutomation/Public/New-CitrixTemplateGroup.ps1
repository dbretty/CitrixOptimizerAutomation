function New-CitrixTemplateGroup {
    <#
    .SYNOPSIS
    Creates a new Group in the Citrix Optimizer template.

    .DESCRIPTION
    This function will create a Group in the Citrix Optimizer template. First it will check if that <group> exists, if not it will add it.
    
    .PARAMETER Path
    Specifies the Path to the template file

    .PARAMETER GroupName
    Specifies the Group Name to create

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns $true or $false depending on the Group creation state as well as the GroupName

    .EXAMPLE
    PS> New-CitrixTemplateGroup -Path 'template.xml' -GroupName 'OS Optimizations' -GroupDescription 'This is the description for the group'
    Creates a new Group called "OS Optimizations" in the template file.
    .EXAMPLE
    PS> New-CitrixTemplateGroup -Path $Template.Path -GroupName 'System Optimizations' -GroupDescription 'This is the description for the group'
    Creates a new Group called "System Optimizations" in the template file based on the result of a New-CitrixTemplate return object.
    .EXAMPLE
    PS> $Group = New-CitrixTemplateGroup -Path $Template.Path -GroupName 'System Optimizations' -GroupDescription 'This is the description for the group'
    Creates a new Group called "System Optimizations" in the template file based on the result of a New-CitrixTemplate return object and pipes this into the variable $Group.

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

    # Check if the template already exists
    if(Get-Template -Path $Path){

        write-verbose "Citrix Optimizer Template $($Path) found"
        write-verbose "Load Citrix Optimizer Template"

        # Load Template and check for existing Group"
        [XML]$xmlfile = Get-Content $Path

        # Check that the template group does not exist
        if(!(Get-TemplateGroup -Path $Path -GroupName $GroupName)){

            write-verbose "No existing Groups found, adding new group"

            # Create the Group element
            write-verbose "Create Group element"
            $Group = $XMLFile.CreateElement("group")
        
            # Create the ID element
            write-verbose "Create ID element"
            $ID = $XMLFile.CreateElement("id")
            $ID.InnerText = $GroupName
            $Group.AppendChild($ID)   
        
            # Create the display name element
            write-verbose "Create DisplayName element"
            $Name = $XMLFile.CreateElement("displayname")
            $Name.InnerText = $GroupName
            $Group.AppendChild($Name)   
        
            # Create the description element
            write-verbose "Create Description element"
            $Description = $XMLFile.CreateElement("description")
            $Description.InnerText = $GroupDescription
            $Group.AppendChild($Description)   
        
            # Append the group ID element to the Group and save the XML file
            write-verbose "Add Group to Citrix Optimizer XML Template"
            $XMLFile.LastChild.AppendChild($Group)
            $XMLFile.Save($Path) 
            
            # Add the GroupName to the return object
            $Return | Add-Member -MemberType NoteProperty -Name "GroupName" -Value $GroupName
            $Return.Complete = $true
    
        } else {
            
            # Group already exists
            write-verbose "Group $($GroupName) already exists - quitting"
            write-error "Group $($GroupName) already exists - quitting"
    
        }

    } else {

        # Template file not found
        write-verbose "Citrix Optimizer Template $($Path) not found - quitting"
        write-error "Citrix Optimizer Template $($Path) not found - quitting"

    }

} # process

end {
    
    # Pass back return object
    return $Return

} # end

}
