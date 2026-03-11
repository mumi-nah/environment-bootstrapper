# Environment Bootstrapper
This repository contains a bash script to help engineers setup development environment. It creates a virtual environment (.venv), upgrades pip, setup .gitignore files, and install python packages like requests and pandas.

---

## Overvview
Beejan Tech is a company that maintains several python-based data pipelines and engineering projects. Each time a new engineer joins, they spend several hours manually setting up their dev environment. This script aims to takeaway the tedious process of manually setting up dev environments for engineers, and automate this process by running the script.

---

## How to execute it
1. Clone the repo

```
https://github.com/mumi-nah/environment-bootstrapper.git
cd environment-bootstrapper
```

2. Change permission
Grant execute permission to make the setup script executable

```
chmod +x setup.sh
```

3. Execute script
The scripts requires a file path as the argument. It could be an existing file path or a new one, the filepath will be created if it doesn't exist.

```
./setup.sh filepath
```
4. Verify Installation
- cd to the specified filepath
- A virtual environment (.venv) will be created (if it doesn't exist) and activated
- pip will be upgraded if necessary
- A .gitignore file (with standard ignore rules for python) will be created if it doesn't exist
- Logs will be written to setup.log

---

## Example Output

```
created project folder
[INFO] Wed Mar 11 17:33:57 WAT 2026: created virtual environment
[SUCCESS] Wed Mar 11 17:33:57 WAT 2026: activated virtual environment
[SUCCESS] Wed Mar 11 17:34:02 WAT 2026: pip ugrade successful!
[SUCCESS] Wed Mar 11 17:34:02 WAT 2026: .gitignore created successfully.
[INFO] Wed Mar 11 17:34:02 WAT 2026: Installing pandas...
[SUCCESS] Wed Mar 11 17:34:18 WAT 2026: pandas Installed successfully!.
[INFO] Wed Mar 11 17:34:18 WAT 2026: Installing requests...
[SUCCESS] Wed Mar 11 17:34:21 WAT 2026: requests Installed successfully!.
[SUCCESS] Wed Mar 11 17:34:21 WAT 2026: Environment setup completed!
```
---

## Challenges Faced
- One challenge faced was with the function for pip upgrade. The function runs each time the script is executed without checking if it's up to date or not. This made the script really slow, while using compute power unnecessarily. Same logic applies to the block of code that install packages
- The second challenge was with the packages function. At first, it was written individually after calling the 'main' function, and so it didn't not behave as expected.

---

## Lesson Learned
If-else is really important!