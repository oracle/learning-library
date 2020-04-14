# KMS

## Introduction
OCI KMS (Key Management Service) provides centralized management of data encryption.

Encryption keys can be used for various services in OCI and can be of 2 types:
* Oracle-managed - without KMS, automatically handled by OCI
* Customer-managed - using KMS, you can handle it. Keys are stored in HSM (Hardware Security Modules) that meet FIPS 140-2 Level 3 security certification

KMS keys are customer-managed keys and can be of 3 types:
* wrapping keys - used when you need to wrap an external key material for import into Key Management. This is automatically created at vault creation. You cannot create, delete or rotate wrapping keys
* master encryption keys - can be generated or imported. This keys are stored in a vault and used when you need to associate a KMS key with a service (for ex: File Storage Service)
* data encryption keys - used to encrypt your data. It is itself encrypted with a master encryption key. For decryption purposes, the service (for ex: File Storage Service) store only the encrypted form of the data encryption key

## Prerequisites
* Terraform v0.12.9 or greater - <https://www.terraform.io/downloads.html/>
* OCI Provider for Terraform v3.61 or greater - <https://github.com/oracle/terraform-provider-oci/releases>
* IAM policies

## Deployment
Install all the software components from the Prerequisites section. Use the links from each description.

You need to define 2 IAM policies:
* one to allow a user group to delegate access to keys
* one to allow services to use keys on behalf of those user groups
```
Allow service blockstorage, objectstorage-ap-mumbai-1, FssOc1Prod, oke to use keys in compartment MS
Allow group MS to use key-delegate in compartment MS
```

You will have to generate an API signing key (public/private keys) and the public key should be uploaded in the OCI
console, for the iam user that will be used to create the resources. Also, you should make sure that this user has
enough permissions to create resources in OCI. In order to generate the API Signing key, follow the steps
from: <https://docs.us-phoenix-1.oraclecloud.com/Content/API/Concepts/apisigningkey.htm#How>
The API signing key will generate a fingerprint in the OCI console, and that fingerprint will be used in a terraform
file described below.

In addition to this, you are required to generate a ssh key for the user that will run the scripts.

You will need an oci provider which can be defined in an *.auto.tfvars file in your example folder and the values must reflect your OCI tenancy:
```
provider_oci = {
  tenancy              = ""
  user_id              = ""
  fingerprint          = ""
  key_file_path        = ""
  private_key_password = ""
  region               = ""
}
```

## Description
The KMS module is used for creating vaults, keys and key versions. After that, the keys can be used for encrypting data on different resources / services:
* Instances boot volumes
* Instances block volumes
* File System Service
* Object Storage Service

* Vault parameters
    * compartment_name - The compartment name in which the vault will be created
    * display_name - The name of the vault
    * vault\_type - The vault type. Currently, 2 types are available: VIRTUAL (the DEFAULT value) and VIRTUAL\_PRIVATE

* Key parameters
    * compartment_name - The compartment name in which the key will be created
    * display_name - The name of the key
    * vault_name -  The vault name in which the key will be created
    * key\_shape\_algorithm - the encryption algorithm for which we can use the key. Currently, only AES can be used
    * key\_shape\_size\_in\_bytes - the size of the key exprimated in bytes. Currently, 3 values can be used: 
    16 (for 128 bits), 24 (for 192 bits), 32 (for 256 bits)
    * rotation_version - whenever this number is increased, the key will be rotated. First value should be 0 in normal situations

To use a key with a specific resource / service (boot volume, block volume, File System Service, Object Storage Service) you just have to update the **kms\_key\_name** from the definition of that resource / service (instance\_params, bv\_params, win\_instance\_params, )

## Example
In the provided example, the following resources are created:

* 1 Linux Instance
    * it has 2 block volumes attached to it
    * the boot volume is encrypted using a kms key
    * 1 block volume is encrypted using a kms key
    * 1 block volume is encrypted using an Oracle-managed key (no KMS)

* 1 Windows Instance
    * it has 2 block volumes attached to it
    * the boot volume is encrypted using a kms key
    * 1 block volume is encrypted using a kms key
    * 1 block volume is encrypted using an Oracle-managed key (no KMS)

* 1 FSS (File System Service)
    * the file system is encrypted using a KMS key
    * it has 2 mount targets
    * export options can be set on mount targets

* 1 OSS (Object Storage Service)
    * it has a bucket definition
    * the bucket is encrypted using a KMS key

* 1 KMS vault
    * the type is the DEFAULT one which is also called VIRTUAL. The alternative is VIRTUAL_PRIVATE

* 3 KMS keys
    * they are located in the same vault
    * they have different shapes (AES-128, AES-192, AES-256) and can have multiple versions
    * they are used for encrypting different resources / services (boot volumes, block volumes, FSS, OSS)

The example is based on terraform.tfvars values:
```
instance_params = {
  hur1 = {
    ad                   = 1
    shape                = "VM.Standard2.8"
    hostname             = "hur1"
    boot_volume_size     = 120
    preserve_boot_volume = false
    assign_public_ip     = true
    compartment_name     = "sandbox"
    subnet_name          = "hur1pub"
    ssh_public_key       = "/home/ionut/Documents/personal/keys/id_rsa.pub"
    device_disk_mappings = "/u01:/dev/oracleoci/oraclevdb /u05:/dev/oracleoci/oraclevdc /u80:/dev/oracleoci/oraclevdd /u02:/dev/oracleoci/oraclevde /u03:/dev/oracleoci/oraclevdf /u04:/dev/oracleoci/oraclevdg"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = "key-hur1"
  }
}

bv_params = {
  bv10 = {
    ad            = 1
    display_name  = "bv10"
    bv_size       = 50
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevdb"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = "key-hur2"
  }
  bv11 = {
    ad            = 1
    display_name  = "bv11"
    bv_size       = 60
    instance_name = "hur1"
    device_name   = "/dev/oracleoci/oraclevdc"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = ""
  }
}

win_instance_params = {
  win01 = {
    ad                   = 1
    shape                = "VM.Standard2.4"
    hostname             = "win01"
    boot_volume_size     = 400
    assign_public_ip     = true
    preserve_boot_volume = false
    compartment_name     = "sandbox"
    subnet_name          = "hur1pub"
    device_disk_mappings = "D:50GB E:60GB"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = "key-hur3"
  }
}

win_bv_params = {
  winbv10 = {
    ad            = 1
    display_name  = "winbv10"
    bv_size       = 50
    instance_name = "win01"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = "key-hur2"
  }
  winbv11 = {
    ad            = 1
    display_name  = "winbv11"
    bv_size       = 60
    instance_name = "win01"
    freeform_tags = {
      "client" : "hurricane",
      "department" : "hurricane"
    }
    kms_key_name = ""
  }
}

fss_params = {
  thunder1 = {
    ad               = 1
    compartment_name = "sandbox"
    name             = "thunder1"
    kms_key_name     = "key-hur1"
  }
}

mt_params = {
  mt1 = {
    ad               = 1
    compartment_name = "sandbox"
    name             = "mt1"
    subnet_name      = "hur1pub"
  }

  mt2 = {
    ad               = 1
    compartment_name = "sandbox"
    name             = "mt2"
    subnet_name      = "hur1pub"
  }
}

export_params = {
  mt1 = {
    export_set_name = "mt1"
    filesystem_name = "thunder1"
    path            = "/media"

    export_options = [
      {
        source   = "0.0.0.0/0"
        access   = "READ_WRITE"
        identity = "NONE"
        use_port = false
      },
    ]
  }
}

bucket_params = {
  hur-buck-1 = {
    compartment_name = "sandbox"
    name             = "hur-buck-1"
    access_type      = "NoPublicAccess"
    storage_tier     = "Standard"
    events_enabled   = false
    kms_key_name     = "key-hur2"
  }
}

vault_params = {
  vault-hur1 = {
    compartment_name = "sandbox"
    display_name     = "vault-hur1"
    vault_type       = "DEFAULT" # DEFAULT is VIRTUAL / Another one is VIRTUAL_PRIVATE
  }
}

key_params = {
  key-hur1 = {
    compartment_name        = "sandbox"
    display_name            = "key-hur1"
    vault_name              = "vault-hur1"
    key_shape_algorithm     = "AES"
    key_shape_size_in_bytes = 16 # 16 / 24 / 32
    rotation_version        = 3  # increment for rotation
  }
  key-hur2 = {
    compartment_name        = "sandbox"
    display_name            = "key-hur2"
    vault_name              = "vault-hur1"
    key_shape_algorithm     = "AES"
    key_shape_size_in_bytes = 24 # 16 / 24 / 32
    rotation_version        = 2  # increment for rotation
  }
  key-hur3 = {
    compartment_name        = "sandbox"
    display_name            = "key-hur3"
    vault_name              = "vault-hur1"
    key_shape_algorithm     = "AES"
    key_shape_size_in_bytes = 32 # 16 / 24 / 32
    rotation_version        = 0  # increment for rotation
  }
```

## Running the code

Go to thunder->examples->run->kms
```
# Run init to get terraform modules
$ terraform init

# Create the infrastructure
$ terraform apply

# If you are done with this infrastructure, take it down
$ terraform destroy
```

## Useful Links
[Key Overview](https://docs.cloud.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm)

[Assigning Keys](https://docs.cloud.oracle.com/en-us/iaas/Content/KeyManagement/Tasks/assigningkeys.htm)

[Use Keys](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/commonpolicies.htm#os-bv-admins-use-key-id)

[Services Use Keys](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/commonpolicies.htm#services-use-key)

## Known issues
In case you have keys with rotation_version greater than 0, you might get an error of this type while destroying KMS resources:
```
module.kms.oci_kms_key_version.this["key-hur1-2"]: Still destroying... [id=keys/ocid1.key.oc1.ap-mumbai-1.bzpfm4by...da4ui6g2pcqqgd4m477eph7m7nl2ywngiwwfta, 2m0s elapsed]

Error: Service error:Conflict. The Key Version ocid1.keyversion.oc1.ap-mumbai-1.bzpfm4byaadbg.dsu3lzl33baae.abrg6ljr2n55qsliirv5ivda4ui6g2pcqqgd4m477eph7m7nl2ywngiwwfta cannot be deleted because it is the current key version of the key. http status code: 409. Opc request id: d092ca17c9e18fe0c615c0a95001e709/4EE72D8FB2C0786F51F54A141BE86CDD/5DBC1009AB87BC48CC3AD886EDD75778

Error: Service error:Conflict. The Key Version ocid1.keyversion.oc1.ap-mumbai-1.bzpfm4byaadbg.dsu3lzl4i6aaa.abrg6ljrqxjsoc7bx3zbak7srdrqhunl6nylr4b4vnftu756vce7ncx2nksq cannot be deleted because it is the current key version of the key. http status code: 409. Opc request id: 284f14ff33177999e34911d56cdba231/33BE4E9B6399FFCAB25A2944479FF873/34EB3A80D19BB94FF4D030C91335EFF0
```

To solve the issue:
* Go to the OCI console
* Find the keys which are having problems with destroying the key versions
* Rotate each key so that it has a new active version
* Then destroy again from Terraform

