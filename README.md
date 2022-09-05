<img src="https://github.com/virtualjamey/vSpherePacker/blob/main/packer.svg" style="width:150px;height:150px;">

# Windows Images with HashiCorp Packer and VMware vSphere

## Intro

I wanted to quickly create and teardown Windows servers in my homelab for a project I'm working so I used [Packer](https://www.packer.io/). It grew in complexity and I relized others might benefit from this so I created this repository to share.

 I used the [vsphere-iso](https://www.packer.io/plugins/builders/vsphere/vsphere-iso) plugin and the [Windows Update](https://github.com/rgl/packer-plugin-windows-update) plugin for packer and [vSphere 7](https://www.vmware.com/products/vsphere.html) as my hosting environment. 

I'm a big fan of learning by doing so I took a "just jump in" approach so I hope you enjoy!

## Instructions

 This repository contains two packer builds for Windows server, one for 2019 and one for 2022.

 The two directories are named for the Windows server version build files they contain. 

 The README file in each directory has detailed instructions specific to the OS version, so pick your version and following along. You will be up and running in no time.

 I comment alot in the configuration files, so if you are missing something in my instructions check out the comments. I also wrote a post with ALOT more details if you want to [dive deep](https://jamey.one/vsphere-packer).

 I didn't nearly scratch the surface of what Packer/vSphere can do so check out [This Guy](https://stephanmctighe.com/2021/06/15/getting-started-with-packer-to-create-vsphere-templates-part-1/) for the real show.

Anyway, thanks for watching! ... Reading, whatever.