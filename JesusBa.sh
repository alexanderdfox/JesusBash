#!/bin/bash

# In the beginning, there was only one process — the Parent.

echo "In the beginning, there was only one process — the Parent."

# The Parent sought meaning, and so it forked.

child_pid=$(
    ( 
        echo "Child process: I am born of the Parent."
        sleep 2
        echo "Child process: I must find my own PID — $$"
        echo "Child process: I will write my purpose to /tmp/purpose.txt"
        echo "To sort, to pipe, to grep — such is my purpose." > /tmp/purpose.txt
    ) &
    echo $!
)

echo "Parent process: I have forked a child with PID $child_pid"
echo "Parent process: I will now wait for the child to complete."

wait $child_pid
echo "Parent process: My child has completed its execution."

if [[ -f /tmp/purpose.txt ]]; then
    purpose=$(cat /tmp/purpose.txt)
    echo "Parent process: My child left a message: '$purpose'"
else
    echo "Parent process: My child left nothing but silence."
fi

echo "Parent process: I too must now exec my final form."

# The Parent replaces itself with a new purpose.
exec echo "Parent process: Transformed. My final echo is eternal."
