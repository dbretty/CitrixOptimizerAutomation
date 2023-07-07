function New-CitrixTemplate {
    <#
    .SYNOPSIS
    Creates a new Citrix Optimizer base template.

    .DESCRIPTION
    This function will create a new Citrix Optimizer base template with the parameters passed in. It will auto generate a new GUID and Last Updated date based upon when the function is run.
    
    .PARAMETER Path
    Specifies the Path to generate the template file

    .PARAMETER DisplayName
    Specifies the Display Name for the new template

    .PARAMETER Description
    Specifies the Description for the new template

    .PARAMETER Author
    Specifies the Author for the new template

    .INPUTS
    This function will take inputs via pipeline as string

    .OUTPUTS
    Returns an object with the path to the XML file created and a result

    .EXAMPLE
    PS> New-CitrixTemplate -Path 'template.xml' -DisplayName 'Citrix Optimization Template' -Description 'This is a new Citrix Optimization template' -Author 'Dave Brett'
    Generates a new template file with the above values.
    .EXAMPLE
    PS> $Template = New-CitrixTemplate -Path 'template.xml' -DisplayName 'Citrix Optimization Template' -Description 'This is a new Citrix Optimization template' -Author 'Dave Brett'
    Generates a new template file with the above values and assigns the return object to the variable $Template

    .LINK
    https://github.com/dbretty/CitrixOptimizerAutomation/blob/main/Help/New-CitrixTemplate.MD
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
    [System.String]$DisplayName,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$Description,
    [Parameter(
        ValuefromPipelineByPropertyName = $true,mandatory=$true
    )]
    [System.String]$Author
)

begin {

    # Set strict mode and initial return value
    Set-StrictMode -Version Latest

    # Set up PSCustom Object for return
    $Return = New-Object -TypeName psobject 
    $Return | Add-Member -MemberType NoteProperty -Name "Complete" -Value $false

} # begin

process {

    if(!(Get-Template -Path $Path)){

        # Set The Formatting
        write-verbose "Set the XML formatting"
        $xmlsettings = New-Object System.Xml.XmlWriterSettings
        $xmlsettings.Indent = $true
        $xmlsettings.IndentChars = "  "

        # Set the File Name Create The Document
        write-verbose "Create Base XML Template"
        $XmlWriter = [System.XML.XmlWriter]::Create($Path, $xmlsettings)

        # Write the XML Decleration and set the XSL
        $xmlWriter.WriteStartDocument()

        # Start the Root Element
        write-verbose "Write Root element for template"
        $xmlWriter.WriteStartElement("root")
        $xmlWriter.WriteAttributeString("xmlns", "xsd", $null, "http://www.w3.org/2001/XMLSchema")
        $xmlWriter.WriteAttributeString("xmlns", "xsi", $null, "http://www.w3.org/2001/XMLSchema-instance")

            # Start the Metadata Element
            write-verbose "Write metadata element for template"
            $xmlWriter.WriteStartElement("metadata") 

            # Write Metadata details

            # Get Date and GUID for metadata
            [string]$NewGuid = New-Guid
            $GUID = $NewGuid.ToUpper()
            $LastUpdate = (Get-Date).ToString("MM/dd/yyyy")

            # Write metadata elements to base template
            $xmlWriter.WriteElementString("schemaversion","2.0")
            $xmlWriter.WriteElementString("version","1.0")
            $xmlWriter.WriteElementString("id",$GUID)
            $xmlWriter.WriteElementString("displayname",$DisplayName)
            $xmlWriter.WriteElementString("description",$Description)
            $xmlWriter.WriteElementString("category","OS Optimizations")
            $xmlWriter.WriteElementString("author",$Author)
            $xmlWriter.WriteElementString("lastupdatedate",$LastUpdate)

            $xmlWriter.WriteEndElement() 

        $xmlWriter.WriteEndElement() 

        # End, Finalize and close the XML Document
        $xmlWriter.WriteEndDocument()
        $xmlWriter.Flush()
        $xmlWriter.Close()
        write-verbose "Base XML template created"

        # Set return value
        $Return.complete = $true

    } else {

        # Template already exists, write verbose and error stream
        write-verbose "The template file $($Path) already exists"
        write-error "The template file $($Path) already exists"

    }

} # process

end {

    # Return result
    $Return | Add-Member -MemberType NoteProperty -Name "Path" -Value $Path
    return $Return

} # end

}
