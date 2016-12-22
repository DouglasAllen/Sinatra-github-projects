s="IyBUaGFua3MgZm9yIGxvb2tpbmcgYXQgbXkgY29kZ
S4KIwojIENvcHlyaWdodCAoQykgMjAwMiAgQ2hyaXN0a
WFuI      E       5       l       d     Wtpc
mNoZ  W       4      gP       G       N obmV
1a2l      y       Y 2hlb  k       B     nbWF
pbC5  j       b    20+CiM     K       I yBUa
GlzI      H       Byb2dyYW        0     gaXM
gZnJ  l       Z  SBzb2Z0d2F   y       Z Tsge
W91I      G     NhbiByZWRpc3      R     yaWJ
1dGU  g        aXQgYW5kL29yCi M       g bW9k
aWZ5      I   Gl0IHVuZGVyIHRoZ    S     B0ZX
Jtcy  B      vZiB0aGUgR05VIEdlb       m VyYW
wgUH      V      ibGljIExpY       2     Vuc2
UuCg  p       T VERPVVQuc3lu  Y       y A9IH
RydW      U    KZDEsIGQyID0gM     C     4xNS
wgMC  4       wNgpzID0gIk1lcnJ        5 IGNo
cmlz      d  G1hcywgLi4uIGFuZCB   h     IGhh
cHB5  I     G5ldyB5ZWFyIgptID0gJ      X d7LC
AuID       ogISArICogMCBPIEB9CnUg P     SAiI
CIgK  i   BzLnNpemUKCnByaW50ICJcci    A gI3t
1fVx      y   IjsKCigwLi4ocy5z    a     XplL
TEpK  S      50b19hLnNvcnRfYnkg       e yByY
W5kI      H 0uZWFjaCB7IHxyfAogIH  N     sZWV
wIGQ  x    CiAgbmV4dCBpZiBzW3JdID     0 9ICI
gIls      wXQogIG0uZWFjaCB7IHxrfAo      gICA
gdVt  y  XSA9IGsKICAgIHByaW50ICIgIC   N 7dX1
cciI    KICAgIHNsZWVwIGQyCiAgfQogIHV    bcl0
gPSB   zW3JdCiAgcHJpbnQgIiAgI3t1fVxyI g p9Cg
pzbG  VlcCBkMgpwcmludCAiICAje3V9IVxyI   jsKc
2xlZ  X       A    gMwpwc     m       l udCA
iICA      j        e3V9IS A       g     LS1j
aHJp  c       z    JcbiI7     C       g ojIG
ZpbG      x        lciBzc G       F     jZSA
jIyM  j       I    yMjIyM     j       I yMjI
yMjI      y       M       j       I     yMjI
yMK"

p = s.delete!(" \n").unpack("m*")[0]

puts p

# Thanks for looking at my code.
#
# Copyright (C) 2002  Christian Neukirchen <chneukirchen@gmail.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License.

STDOUT.sync = true
d1, d2 = 0.15, 0.06
s = "Merry christmas, ... and a happy new year"
m = %w{, . : ! + * 0 O @}
u = " " * s.size

print "\r  #{u}\r";

(0..(s.size-1)).to_a.sort_by { rand }.each { |r|
  sleep d1
  next if s[r] == " "[0]
  m.each { |k|
    u[r] = k
    print "  #{u}\r"
    sleep d2
  }
  u[r] = s[r]
  print "  #{u}\r"
}

sleep d2
print "  #{u}!\r";
sleep 3
print "  #{u}!  --chris2\n";

# filler space ########################