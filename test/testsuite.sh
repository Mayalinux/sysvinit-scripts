#!/bin/bash

#
# Test library
#

COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_DEFAULT="\033[39m"

TEST_TOTAL=0
TEST_SUCCESS=0
TEST_FAILED=0

#
# Synopsis: echo_colored COLOR [WORD...]
#
# Prints WORD(s) in COLOR.
#
function echo_colored () {
  local color=$(eval echo "\$$1"); shift

  echo -e "${color}$*${COLOR_DEFAULT}"
}

function test_success () {
  ((TEST_SUCCESS++))
  echo_colored COLOR_GREEN SUCCESS
}

function test_failure () {
  ((TEST_FAILED++))
  echo_colored COLOR_RED FAILURE
}

#
# Synopsis: test_do DESCRIPTION COMMAND [ARG...]
#
# Executes COMMAND with ARG(s) and prints the result
#
function test_do () {
  local desc="$1"; shift

  echo -n "Testing ${desc}... "

  "$*"

  if [[ $? -eq 0 ]]; then
    test_success
  else
    test_failure
  fi

  ((TEST_TOTAL++))
}

function test_summary () {
  echo -e "Performed: ${COLOR_YELLOW}$TEST_TOTAL${COLOR_DEFAULT}, Success/Failed: ${COLOR_GREEN}$TEST_SUCCESS${COLOR_DEFAULT}/${COLOR_RED}$TEST_FAILED${COLOR_DEFAULT}"
}
