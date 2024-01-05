#!/bin/bash

# test
echo 'hello'

# adding variables

WORD='script'

# executing variables 

echo "$WORD"

# Demonstrate that single quotes cause NOT expansion of variables
echo '$WORD'

# Combine variables with hard-coded text 
echo "This is a shell $WORD"

# Display the contents of the variables using an alternative method

echo "This is a shell ${WORD}"

# Append text to the variables
echo "${WORD}ing is fun!"

# Show how NOT to append text to a variable 
# This doesn't work:
echo "$WORDing is fun!"

# Create a new variable
ENDING='ed'

# Combine the two variables

echo "This is ${WORD}${ENDING}"

# Change the value stored in the ENDING variable (Reasigment) - everything after this Reasigment will use the new variable
ENDING='ing'
echo "${WORD}${ENDING} is fun!"

# Reasign value to ENDING
ENDING='s'
echo "You are going to write many ${WORD}${ENDING} in this class"

