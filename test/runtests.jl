# Copyright 2017 Marcelo Forets
# See accompanying license file.

using Zonotopes
using Base.Test
using Compat

# Basic Methods
# =============

Z1 = Zonotope([1.; 1], [1. 1; -1 1])
Z2 = Zonotope([-1.; 1], eye(2))
A = [0.5 1; 1 0.5]

# Scaling and linear transformation
Z = 2.0 * Z1
@test Z.c == [2.00; 2.00] && Z.gi == [2.0 2.0; -2.0 2.0]
Z = A * Z1
@test Z.c == [1.50; 1.50] && Z.gi == [-0.5 1.5; 0.5 1.5]

# Minkowski sum
Z = Z1 + Z2
@test Z.c == [0.00; 2.00] && Z.gi == [1.0 1.0 1.0 0.0; -1.0 1.0 0.0 1.0]

# Cartesian product
Z = Z1 * Z2
@test Z.c == [1.00; 1.00; -1.00; 1.00] && Z.gi == [1. 1 0 0; -1. 1 0 0; 0 0 1 0; 0 0 0 1]

Z = Z2 * Z1
@test Z.c == [-1.; 1; 1; 1] && Z.gi == [1. 0 0 0; 0 1 0 0; 0 0 1 1; 0 0 -1 1]
