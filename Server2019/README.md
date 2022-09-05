# Packer/vSphere Windows Server Builds

## How to use this repo to get up and running quickly
1. Get an ISO: I got the mine from the [Microsoft Evaluation Center](https://www.microsoft.com/en-gb/evalcenter/evaluate-windows-server) but you can use retail as well.
2. Get VMWare Tools: You can download the latest from [here](https://packages.vmware.com/tools/releases/latest/windows) or they can be found at `/productlocker/vmtools` on the esxi host. You are looking for Windows.iso
3. Now you have to get both the install iso and the VMWare tools iso to a datastore so we can reference their location later. Check [this](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-492D6904-7471-4D66-9555-9466CCCA6931.html) out if you don't know how. Make sure you note the datastore path and filename, you have to have them later.
4. Clone this repo locally
5. Review `autounattend.xml` for the ProductKey tag and update if using retail iso. You should not need to touch anything else.
6. Review `setup.ps1` and `postSetup.ps1` and make sure they don't do anything you don't want. For most people, as is, is great.
7. Fill out `variableDefinitionFile.auto.pkrvar.hcl` with the correct values for your setup. 
8. Download packer from the [Packer Downloads](https://www.packer.io/downloads) page and follow [Install Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) specific to your environment.
9.  Run  `packer init .` Make sure to note the period after init. Its required, its how packer knows to look in the correct directory for files it recognizes.
10. Run `packer validate .` If you see a ton of errors don't worry. If you have just one formatting issue the rest of the errors are likely followalongs that will be fixed by fixing the first.
11. Run `packer build .` 

Most errors come from typing things wrong in the `variableDefinitionFile.auto.pkrvars.hcl`, at least they did for me:) 

That is all the is really needed to get going but if you are intested  I put alot more detail below.

<br>

# Configuration files and Packer deails

## First off my directory structure for your viewing pleasure.

```
├── Server 2019
│   ├── answers
│   │   ├── autounattend.xml
│   ├── scripts
│   │   ├── installVMWareTools.ps1
│   │   ├── postSetup.ps1
│   │   ├── setup.ps1
│   ├── Server2019.build.pkr.hcl
│   ├── variableDeclarationFile.pkr.hcl
│   ├── variableDefinitionFile.auto.pkrvars.hcl
```
<br>

> These build and variable files are written in [HCL2](https://www.packer.io/docs/templates/hcl_templates) instead of JSON keeping with [Packers](https://www.packer.io/) preffered way to write Packer configuration.

<br>

## **autounattend.xml**

The `autounattend.xml` file is located in the `answers` directory because it answers the windows installer questions during install.

It does stuff like partition the disk, set region, run scripts, etc. The [Windows System Image Manager](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/windows-system-image-manager-technical-reference) is how the files are created but its easier to look at others, learn the strucutre and change if needed to match your setup.

One thing to note for us is that it calls `installVMWareTools.ps1` and `setup.ps1` so if you change the file names you need to update this file.

> The local Administrator password is in clear text. If you use this for more than your home lab you should consider this guide [Hide Sensitive Data in an Answer File](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/hide-sensitive-data-in-an-answer-file)

<br>

## **InstallVMWareTools.ps1, setup.ps1 and postSetup.ps1** 

These three files run to configure the windows image in the way I want. The first two are callled from the `autounattend.xml` and the last is run by the packer provisioner towards the end of the build.

I got `InstallVMWareTools.ps1` from [here](https://github.com/getvpro/Build-Packer/blob/master/Scripts/Install-VMTools.ps1) becuase I ran into [this](https://scriptech.io/automatically-reinstalling-vmware-tools-on-server2016-after-the-first-attempt-fails-to-install-the-vmtools-service/)

I comment alot in `setup.ps1` and `postSetup.ps1` if you want details of why I did each step.

<br>

## **variableDeclarationFile.pkr.hcl**

This file is where I define the variable names and types that `Server2019.build.pkr.hcl` will look for. Its the file that names variables whos value will be supplied by variableDefinitionfile.auto.pkrvars.hcl

<br>

## **variableDefinitionFile.auto.pkrvars.hcl**

Before you can run the build you need to fill out this file with the information from your environment. I committed `variableDefinitionFile.auto.pkrvars.hcl` without vaules as an example. You should consider using environment variables or passing sensitive variables like this and not store them in the file.

```dosbatch
packer build -var "vcenter_username=administrator@vsphere.local" -var "vcenter_password=Jamey1!" -var "winrm_password=Jamey1!" .
```

Also remember the WinRM username and password should match the local administrator account its what Packer uses to connect for customisation. 

The version of Packer, the [vsphere-iso](https://www.packer.io/plugins/builders/vsphere/vsphere-iso) plugin and the [Windows Update](https://github.com/rgl/packer-plugin-windows-update) plugins to be used is defined in the hashicorp block of the `Server2019.build.pkr.hcl` file:

<br>

## **Server2019.build.pkr.hcl**

I used two plugins. You can see them in the `terraform` block of this file. The other two blocks are source and build. Source is where I define things like vCenter settings, VM settings, iso locations, etc. In the build section we reference the source block and also call packer provisioners to run stuff after the initial configuration/install run.

<br>

## **Recap**

So to recap, once you have filled out the variable values in `variableDefinitionFile.auto.pkrvar.hcl` and placed the ISOs in the datastore, cloned the repo the only thing you need to do is run.

```dosbatch
packer init .
```
```dosbatch
packer validate .
```
```dosbatch
packer build .
```

Thanks for watching... Reading, whatever.