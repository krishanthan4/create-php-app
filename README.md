# create-php-app
these scripts can make PHP MVC backend template with react/Vanila JS/Vue  frontend template with tailwindcss easily


# For Windows (create-php-app.ps1)

Open PowerShell:

Press Win + X and select "Windows PowerShell" or "PowerShell" from the menu.
You can also open PowerShell from the Start Menu or by searching for it.
Navigate to the Script's Directory:

Use the cd (Change Directory) command to navigate to the directory where your PowerShell script is located.

```shell
cd path\to\your\script\directory
Execution Policy:
```

By default, PowerShell may have restrictions on running scripts for security reasons. You might need to change the execution policy.

```shell
Set-ExecutionPolicy RemoteSigned
```
Choose a suitable execution policy. For development or testing, you can use RemoteSigned or Unrestricted. However, for security reasons, it's recommended to revert to a more restrictive policy after running your script.

Run the Script:

Use the .\ (dot-slash) notation to run the script.

```shell
.\your_script.ps1
```
Replace your_script.ps1 with the actual name of your PowerShell script.

If you encounter an error regarding script execution, you might need to use the -File parameter:

```shell
powershell -File .\your_script.ps1
```

Check for Errors:

Pay attention to any error messages that appear in the console. They can help you identify issues with your script.
Remember to revert the execution policy to a more secure setting after running your script. You can set it back to the default with:

```shell
Set-ExecutionPolicy Restricted
```

Please note that running scripts from untrusted sources can pose security risks. Make sure you understand the content of the script before executing it, especially if it comes from an unknown or untrusted source.


# for Linux (create-php-app.bash)

- navigate to the folder you want to create the project 
- bash create-php-app.bash
