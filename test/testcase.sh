#!/bin/bash

#
# Usage: testcase.sh pidfile execpath
#
# WARNING: DO NOT havily rely on the results of this tests
#

export LOG_FILE=/tmp/init-functions-test.log

PID_FILE=/tmp/pidfile.pid
EXE_FILE=$(realpath -LP test/exe.sh)

. test/testsuite.sh
. ./init-functions

function test_pidofproc () {
  local RESULT=$(pidofproc -p $PID_FILE $EXE_FILE)

  [[ -n "$RESULT" ]] && return 0
  return 1
}

function test_start_daemon () {
  start_daemon -p $PID_FILE $EXE_FILE \
    && start_daemon -f -p $PID_FILE $EXE_FILE \
    && start_daemon -p $PID_FILE $EXE_FILE
}

function test_killproc () {
  killproc -p $PID_FILE $(<$PID_FILE)
}

[[ -r $PID_FILE ]] && rm -f $PID_FILE

test_do "start_daemon" test_start_daemon
sleep 1
test_do "pidofproc" test_pidofproc
sleep 1
test_do "killproc" test_killproc

test_summary
