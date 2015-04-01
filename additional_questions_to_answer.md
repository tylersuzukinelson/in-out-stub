Notice that, in the finished project, the IP addresses are stored as
integers in the DB. What are the pros and cons of this approach, compared
to storing the IP addresses as strings?

Pros

* Saving the IP address as an integer takes less space in the database than storing it as a string
* Accessing the IP address as an integer takes less time than accessing it as a string (even moreso had it been stored as UTF-8)

Cons

* Converting between integer and string requires additional time

=====

Are there any security issues present in the app itself? (No need to
mention security vulnerabilities within external gems.) List any security
issues you found, and how to fix them. Also list any potential security
issues that you investigated which you believe the site to be free of.

-----

```ruby
@user.update_attributes(params[:user])
```

In ```/app/controllers/users_controller.rb```, updating attributes using only ```params[:user]``` allows people to pass in any attributes to the ```:user``` hash. For instance, they can insert an ```:id``` into the ```:user``` hash to edit the properties of another user.

To fix this, ```params[:user]``` should be replaced with something similar to ```params.require(:user).permit(:first_name, :last_name, :team_id)``` to only allow the update action to modify the ```:first_name, :last_name, :team_id``` attributes of the user.

-----

Files such as ```/config/initializers/secret_token.rb``` and ```/db/development.sqlite3``` are included in git commits. This can give the public access to information (eg. access keys, database information) that they should not have access to.

To fix this, these files can be included in the ```/.gitignore``` file. This will prevent git from including them in commits.

-----

The site has a CSRF token to protect against cross-site request forgery attacks, but it doesn't use it.

To use the token to effectively protect against these attacks, ```protect_from_forgery with: :exception``` needs to be included in the controllers (or just ```/app/controllers/application_controller.rb```).

-----

Although the site has a minimum password length requirement, it doesn't allow users to change their passwords. This makes it easier for account hijacking to take place.

Users should be allowed and encouraged to change their passwords often.

-----

Although devise has the optional ability to monitor login attempts to prevent brute-force attacks, this site currently does not leverage that capacity.

This feature should be added to protect against brute-force attacks.

-----

Passwords appear to be filtered out of the server logs.

-----

The site doesn't allow the user to upload potentially malicious files.

-----

The site doesn't allow the user to specify the destination of any ```redirect_to``` tags.

-----

The site doesn't seem to be at risk for SQL insertion.