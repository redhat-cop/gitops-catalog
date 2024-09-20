# Auto-Create User Schemas

This component will signal the Crunchy Postgres Operator to automatically create a schema for each user it creates.

With Postgres 15, the default permissions of the "public" schema were reduced. Many applications assume that they have
permissions to create tables, which is no longer the case with the new permissions. Instead, the schema search order
is changed to "$user","public" -- this means that a schema with the username will be searched before the public schema.
By asking the operator to auto-create user schemas, applications may again operate without explicitly changing schema.

The "AutoCreateUserSchema" feature flag must be enabled on the operator for this component to take effect on deployed
databases.
