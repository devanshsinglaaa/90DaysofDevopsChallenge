# Day 10 – File Permissions & File Operations

## Files Created

- devops.txt → created using touch  
- notes.txt → created using echo  
- script.sh → created using vim  
- project/ → directory created for testing  

---

## File Creation Commands

```bash
touch devops.txt
echo "This is my Day 10 practice file" > notes.txt
vim script.sh

```
![shell_script](../images/day10_01.png)
```bash

Inside script.sh:

echo "Hello DevOps"
Reading Files
cat notes.txt
vim -R script.sh
head -n 5 /etc/passwd
tail -n 5 /etc/passwd
Initial Permissions
ls -l

```
![shell_script](../images/day10_03.png)
```bash

Example:

-rw-rw-r-- devops.txt
-rw-rw-r-- notes.txt
-rw-rw-r-- script.sh

```
![shell_script](../images/day10_05.png)
```bash

Explanation
Owner → read + write
Group → read + write
Others → read only
No execute permission
Permission Changes
Make script executable
chmod +x script.sh
./script.sh

Output:

```
![shell_script](../images/day10_02.png)
```bash

```
![shell_script](../images/day10_04.png)
```bash

Hello DevOps
Make devops.txt read-only
chmod a-w devops.txt
Set notes.txt to 640
chmod 640 notes.txt

Meaning:

Owner → read + write
Group → read only
Others → no access
Create directory with 755
mkdir project
chmod 755 project

```
![shell_script](../images/day10_06.png)
```bash

Meaning:

Owner → full access
Group → read + execute
Others → read + execute
Testing Permissions
Write to read-only file
echo "test line" >> devops.txt

Output:

Permission denied
Execute without permission
chmod -x script.sh
./script.sh

Output:

```
![shell_script](../images/day10_07.png)
```bash

Permission denied
Commands Used
touch
echo
vim
cat
head
tail
chmod
ls -l
mkdir
What I Learned
Linux permissions control access using read, write, execute
chmod is used to modify permissions using symbolic and numeric methods
Execute permission is required to run scripts
Permission issues are very common in real-world DevOps
Understanding file permissions is important for system security