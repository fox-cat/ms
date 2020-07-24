import unittest, ms

test "seconds":
  check ms"1s" == 1000 

test "minutes":
  check ms"1m" == 60000

test "hours":
  check ms"1h" == 3600000

test "days":
  check ms"1d" == 86400000

test "weeks":
  check ms"1w" == 604800000

test "years":
  check ms"1y" == 31557600000.float