Notice that, in the finished project, the IP addresses are stored as
integers in the DB. What are the pros and cons of this approach, compared
to storing the IP addresses as strings?

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