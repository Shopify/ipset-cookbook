# 0.2.1

Add `flush` command to generated save file.  Otherwise, the `destroy`
command can fail with nested lists.  This is actually a more general
problem that needs to be fixed by creating temporary sets and swaping
them with the existing ones during an update.

# 0.2.0

Remove `ipset_entry` LWRP.  Entries are now passed in a hash directly
to the `ipset` resource.

# 0.1.0

Initial release of ipset
