# release-patches
Store patch files for LTS releases of Armory Spinnaker.

## How it works
The repository has kustomization files for being consumed by anyone that uses Kustomize for deploying 
Armory Spinnaker. We use branches to group different versions of the Armory Spinnaker.

| Branch Name  | Version Type
|:----------- | :---------
| **main**  |  Stable LTS
| **rc**  |  Stable Release Candidates for LTS

Astrolabe is responsible for updating the version in the patch files. It only update with a newer LTS 
or LTS RC. The Legacy version are not supported (for now).

## How rollback

We are continuously testing our Armory Spinnaker version but sometimes we are not quick enough to deliver 
fixes. That's why this repository should be the source of trust. Every time, we find something that is not
 working as we expect we may rollback the commit with the version that has issues. 
 
In this way, every environment that is being affected will be triggered with the rollback they want.