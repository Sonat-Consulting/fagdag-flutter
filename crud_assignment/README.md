Assignment 
-----------------------------
In this assignment we will integrate with an API that delivers JSON over HTTP, to manage a list of observations we have made!

The API can be started by doing.

``` docker-compose up -d ```

Which will start the API on ```localhost:8082```, this API has a artificial 1 second delay, so that we handle a slow API reasonably.

On Android, you can change the host in observations.dart to : ```10.0.2.2:8082``` to hit the local server.

### Assignment 1
Add the HTTP call and state changes necessary to update an existing observation in the list.

### Assignment 2
Error handling is non-existent, create a way to sensibly notify that an operation failed, and recover.

### Assignment 3
Right now the list of observations is not visible while updating. Ensure the list is visible while updating.
