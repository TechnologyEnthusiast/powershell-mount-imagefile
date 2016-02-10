#
# Mount-ImageFile.ps1
#

# This function will use DISM to mount a VHD or WIM image file
Function Mount-ImageFile
{
	[CmdletBinding()]
	Param ( 

		[Parameter(Mandatory=$true,Position=0)]
		[string]$ImageFile,

		[Parameter(Mandatory=$false,Position=1)]
		[string]$MountDir = "X:\"
	)

	# Test to make sure the image file exists
	Begin
	{
		if (Test-Path $ImageFile)
		{
			Write-Verbose "$ImageFile is a valid file."
		}
		else
		{
			Write-Warning "Cannot locate $ImageFile"
			BREAK;
		}
	}

	# Use DISM to mount the image file
	Process
	{
		write-verbose "Attemping to image file"
		try
			{
				Invoke-Expression "dism /Mount-Image /ImageFile:$ImageFile /Index:1 /MountDir:$MountDir"
			}
			catch [System.Exception]
			{
				Write-Warning "Unable to mount $ImageFile to $MountDir"
				BREAK;
			}
	}
	
	# Verify mount was successful
	End
	{
		if (Test-Path $MountDir)
		{
			write-verbose "The $ImageFile has been successfully mounted."
		}
		else
		{
			Write-Verbose "$ImageFile was not successfully mounted."
		}
	}
}
