using Test
include("money.jl")

@testset "Multiplication" begin
    five = Dollar(5)
    @test 10 == times(five, 2)
end

