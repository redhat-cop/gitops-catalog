# GPU Notes

## Instance Types

AWS GPU Types:

Multi-instance GPU (MIG) can be:

- `p5.48xlarge`  - 8 x H100 Tensor Core
- `p4d.24xlarge` - 8 x A100 Tensor Core  

Time-slicing GPU can be any Nvidia type (as documented by Nvidia):

- P3 - V100
  - `p3.2xlarge`  - 1 x V100
  - `p3.8xlarge`  - 4 x V100
  - `p3.16xlarge` - 8 x V100
- P2 - K80
  - `P2.xlarge`   - 1  x K80
  - `P2.8xlarge`  - 8  x K80
  - `P2.16xlarge` - 16 x K80
- G5g - T4G
  - `g5g.{,2,4,8}xlarge`         - 1 x T4G
  - `g5g.16xlarge`, `g5g.metal`  - 2 x T4G
- G5 - A10G
  - `g5.{,2,4,8,16}xlarge`  - 1 x A10G
  - `g5.{12,24}xlarge`      - 4 x A10G
  - `g5.48xlarge`           - 8 x A10G
- G4dn - T4
  - `g4dn.{,2,4,8,16}xlarge` - 1 x T4
  - `g4dn.48xlarge`          - 4 x T4
  - `g4dn.metal`             - 8 x T4
- G3 - M60
  - `g3s.xlarge`  - 1 x M60
  - `g3.4xlarge`  - 1 x M60
  - `g3.8xlarge`  - 2 x M60
  - `g3.16xlarge` - 4 x M60


## Links

- [Docs - AWS GPU Instances](https://aws.amazon.com/ec2/instance-types/#Accelerated_Computing)
- [Docs - Nvidia GPU Operator on Openshift](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/openshift/contents.html)
- [Docs - Nvidia GPU admin dashboard](https://docs.openshift.com/container-platform/4.11/monitoring/nvidia-gpu-admin-dashboard.html)
- [Docs - MIG support in OCP](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/openshift/mig-ocp.html)
- [Blog - Red Hat Nvidia GPUs on OpenShift](https://cloud.redhat.com/blog/autoscaling-nvidia-gpus-on-red-hat-openshift)
- [Demo - GPU DevSpaces](https://github.com/bkoz/devspaces)
- [GPU Operator default config map](https://gitlab.com/nvidia/kubernetes/gpu-operator/-/blob/v23.6.1/assets/state-mig-manager/0400_configmap.yaml?ref_type=tags)