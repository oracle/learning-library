$DN = Get-ADDomain | select -ExpandProperty DistinguishedName
$DNSROOT = Get-ADDomain | select -ExpandProperty DNSRoot

$TESTUSERS = New-ADOrganizationalUnit DemoUsers -PassThru
$GROUPS = New-ADOrganizationalUnit Groups -PassThru

New-ADGroup Employees -Path $GROUPS.DistinguishedName -GroupScope DomainLocal
New-ADGroup OtherUsers -Path $GROUPS.DistinguishedName -GroupScope DomainLocal
New-ADGroup OurPartner -Path $GROUPS.DistinguishedName -GroupScope DomainLocal
New-ADGroup OurVendor -Path $GROUPS.DistinguishedName -GroupScope DomainLocal

$DCRANE = new-ADUser -name "Danny Crane" -samAccountName dcrane -UserPrincipalName dcrane@$DNSROOT -GivenName Danny -Surname Crane -Title 'Standard User' -EmailAddress demoidcs+user1@gmail.com -AccountPassword (ConvertTo-SecureString -asPlainText 'Oracle123' -Force) -Path $TESTUSERS.DistinguishedName -PassThru
Enable-ADAccount $DCRANE.DistinguishedName
add-ADGroupMember Employees $DCRANE.DistinguishedName

$SDOWNS = new-ADUser -name "Sally Downs" -samAccountName sdowns -UserPrincipalName sdowns@$DNSROOT -GivenName Sally -Surname Downs -EmailAddress demoidcs+user2@gmail.com -AccountPassword (ConvertTo-SecureString -asPlainText 'Oracle123' -Force) -Path $TESTUSERS.DistinguishedName -PassThru
Enable-ADAccount $SDOWNS.DistinguishedName
add-ADGroupMember OtherUsers $SDOWNS.DistinguishedName

$GDAVIS = new-ADUser -name "Grace Davis" -samAccountName gdavis -UserPrincipalName gdavis@$DNSROOT -GivenName Grace -Surname Davis -EmailAddress demoidcs+user3@gmail.com -AccountPassword (ConvertTo-SecureString -asPlainText 'Oracle123' -Force) -Path $TESTUSERS.DistinguishedName -PassThru
Enable-ADAccount $GDAVIS.DistinguishedName
add-ADGroupMember OurPartner $GDAVIS.DistinguishedName

$JWELLS = new-ADUser -name "John Wells" -samAccountName jwells -UserPrincipalName jwells@$DNSROOT -GivenName John -Surname Wells -EmailAddress demoidcs+user4@gmail.com -AccountPassword (ConvertTo-SecureString -asPlainText 'Oracle123' -Force) -Path $TESTUSERS.DistinguishedName -PassThru
Enable-ADAccount $JWELLS.DistinguishedName

Echo "Process Complete"
Pause
