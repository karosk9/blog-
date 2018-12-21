### Staging debugging

In order to investigate bugs that are not possible to reproduce locally and have to be investigated on staging or production

Connect to running staging web container as described in Staging Access section
Open the file you want to debug. For example:
```
vim app/policies/any_policy.rb
```
Paste the debug command to the file

```
Rails.logger.debug string_or_object_to_return_in_logs
```
Save and exit the file 

```
touch /app/tmp/restart.txt
```
Show server logs and look for debugger results within them.
```
tail -f /app/log/staging.log
```
