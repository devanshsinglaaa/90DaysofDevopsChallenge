# Day 17 Challenge – Shell Scripting: Loops, Arguments & Error Handling

## Scripts Created

* for_loop.sh
* count.sh
* countdown.sh
* greet.sh
* args_demo.sh
* install_packages.sh
* safe_script.sh

---

## Script 1: for_loop.sh

```bash
#!/bin/bash

for fruit in apple banana mango orange grapes
do
    echo $fruit
done
```

![shell_script](../images/day17_01.png)

![shell_script](../images/day17_02.png)


---

## Script 2: count.sh

```bash
#!/bin/bash

for i in {1..10}
do
    echo $i
done
```

![shell_script](../images/day17_03.png)

![shell_script](../images/day17_04.png)

---

## Script 3: countdown.sh

```bash
#!/bin/bash

read -p "Enter the number for reverse countdown: " n

while [ $n -ge 0 ]
do
    echo $n
    n=$((n-1))
done

echo "Done, loop finished"
```

![shell_script](../images/day17_05.png)

![shell_script](../images/day17_07.png)


---

## Script 4: greet.sh

```bash
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: ./greet.sh <name>"
else
    echo "Greeting, $1"
fi
```

![shell_script](../images/day17_08.png)

![shell_script](../images/day17_09.png)


---

## Script 5: args_demo.sh

```bash
#!/bin/bash

echo "Script name: $0"
echo "Total arguments: $#"
echo "All arguments: $@"
```

![shell_script](../images/day17_10.png)

![shell_script](../images/day17_11.png)

---

## Script 6: install_packages.sh

```bash
#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

packages=(nginx curl wget)

for pkg in "${packages[@]}"
do
    if dpkg -s $pkg &> /dev/null; then
        echo "$pkg is already installed"
    else
        echo "Installing $pkg..."
        apt-get update
        apt-get install -y $pkg
    fi
done
```

![shell_script](../images/day17_12.png)

---

## Script 7: safe_script.sh

```bash
#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || { echo "Failed to enter directory"; exit 1; }

touch test.txt || echo "Failed to create file"

echo "Script completed successfully"
```


![shell_script](../images/day17_14.png)

![shell_script](../images/day17_15.png)


---

## Commands Used

```bash
chmod +x script.sh
./script.sh
vim script.sh
for item in list; do ... done
while [ condition ]; do ... done
$1 $2 $# $@
dpkg -s package
apt-get install -y
set -e
```

---

## What I Learned

1. Loops (for & while) help automate repetitive tasks
2. Command-line arguments ($1, $#, $@) make scripts dynamic and reusable
3. Error handling using `set -e` and `||` prevents failures and makes scripts production-ready

---

## Real-World Use

* Automating server setup
* Installing multiple packages efficiently
* Writing reusable CLI scripts
* Handling failures in DevOps pipelines
