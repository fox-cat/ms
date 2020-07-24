import re, strutils, math

let 
  s = 1000.float
  m = s*60
  h = m*60
  d = h*24
  w = d*7
  y = d*365.25

proc plural (val: SomeNumber, valAbs: SomeNumber, n: SomeNumber, name: string): string =
  let isPlural = valAbs >= n*1.5
  var close = ""
  if isPlural: close = "s"
  return $(val/n).round().int & " " & name & close

proc ms* (str: string): float =
  ## Convert a time format into milliseconds
  if str =~ re"^(-?(?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|weeks?|w|years?|yrs?|y)?$":
    var 
      n = matches[0].parseFloat()
      kind = matches[1].toLowerAscii()
    
    case kind:
      of "years", "year", "yrs", "yr", "y":
        return n*y
      of "weeks", "week", "wks", "wk", "w":
        return n*w
      of "days", "day", "d":
        return n*d
      of "hours", "hour", "hrs", "hr", "h":
        return n*h
      of "minutes", "minute", "mins", "min", "m":
        return n*m
      of "seconds", "second", "secs", "sec", "s":
        return n*s
      of "milliseconds", "millisecond", "msecs", "msec", "ms":
        return n
  else: return 0

proc ms* (val: float): string =
  ## Convert milliseconds into a time format
  let valAbs = val.abs()
  if valAbs >= d: return $(val/d).round().int&"d"
  if valAbs >= h: return $(val/h).round().int&"h"
  if valAbs >= m: return $(val/m).round().int&"m"
  if valAbs >= s: return $(val/s).round().int&"s"
  return $val.int&"ms"

proc ms* (val: float, long: bool): string =
  ## Convert milliseconds into a time format.
  ## 
  ## Setting long to true will make the value long (e.g. `3 days` instead of `3d`)
  if not long: return val.ms()
  let valAbs = val.abs()
  if valAbs >= d: return val.plural(valAbs, d, "day")
  if valAbs >= h: return val.plural(valAbs, h, "hour")
  if valAbs >= m: return val.plural(valAbs, m, "minute")
  if valAbs >= s: return val.plural(valAbs, s, "second")
  return val.plural(valAbs, 1, "millisecond")