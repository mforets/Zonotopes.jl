# Copyright 2017 Marcelo Forets
# See accompanying license file.

module Zonotopes 

#===============================================================================
Basic types
===============================================================================#

"""
    Zonotope(c, gi)
    
A zonotope with given center and generators.

INPUT:

- c:  center
- gi: matrix whose columns are the generators

EXAMPLES:

Two-dimensional zonotope with floating point vertices:

    julia> Zonotope([0.9; 0], 0.1*eye(2))

    Zonotopes.Zonotope{Float64}([0.9,0.0],[0.1 0.0; 0.0 0.1])
"""
type Zonotope{T}
    c :: Vector{T}    
    gi :: Matrix{T}    
end
Zonotope() = Zonotope(Vector(), Matrix())   

#===============================================================================
Methods
===============================================================================#

"
    α × Z
    
Scale a zonotope by a numerical factor.

EXAMPLES::

We scale by a factor of sqrt(2)::

    julia>  Z = Zonotope([0.9; 0], 0.1*eye(2))
    Zonotopes.Zonotope{Float64}([0.9,0.0],[0.1 0.0; 0.0 0.1])
    julia> sqrt(2) * Z
    Zonotopes.Zonotope{Float64}([1.27279,0.0],[0.141421 0.0; 0.0 0.141421])
"
function Base.:*(α::Number, Z::Zonotope)
    
    return Zonotope(α * Z.c, α * Z.gi)
end

"
    M × Z
    
Apply a linear map to a zonotope.

EXAMPLES::

Applying a matrix to a two-dimensional zonotope:: 

    julia> Z = Zonotope([0.9; 0], 0.1*eye(2))
    Zonotopes.Zonotope{Float64}([0.387,0.603],[0.043 0.0051; 0.067 0.0724])
    julia> M = [0.43 0.051; 0.67 0.724]
    2×2 Array{Float64,2}:
     0.43  0.051
     0.67  0.724
    julia> M*Z
    Zonotopes.Zonotope{Float64}([0.387,0.603],[0.043 0.0051; 0.067 0.0724])
"
function Base.:*(M::Matrix, Z::Zonotope)
    
    return Zonotope(M * Z.c, M * Z.gi)
end

"""
    Z1 + Z2
    
Minkowski addition of two zonotopes.
"""
function Base.:+(Z1::Zonotope, Z2::Zonotope)
    
    return Zonotope(Z1.c + Z2.c, [Z1.gi Z2.gi])
end

"""
    Z1 * Z2
    
Cartesian product of two zonotopes.
"""
function Base.:*(Z1::Zonotope, Z2::Zonotope)
    
    return Zonotope([Z1.c ; Z2.c], cat([1, 2], Z1.gi, Z2.gi))
end

#===============================================================================
Special Zonotopes
===============================================================================#

"""
    Box(center, radius)
    
A box (or hypercube in n-dimensions) with given center and radius.

INPUT:

- center : vector, the center of the box
- radius : number, the radius of the box

EXAMPLES:

Three-dimensional box centered at the origin:

    julia> Box([0., 0, 0], 1.1)
    Zonotopes.Zonotope{Float64}([0.0,0.0,0.0],[1.1 0.0 0.0; 0.0 1.1 0.0; 0.0 0.0 1.1])
"""
function Box(center::Vector, radius::Number)

    # dimension
    n = length(center)

    return Zonotope(center, radius * eye(n))
end

#===============================================================================
Input/Output 
===============================================================================#

# - Plotting.
# - Saving and Loading zonotopes.
# - Interface with MATLAB's MPT (Multi-Parametric Toolbox).

#===============================================================================
Exports
===============================================================================#

# Types
export Zonotope

# Special zonotopes
export Box

end # module