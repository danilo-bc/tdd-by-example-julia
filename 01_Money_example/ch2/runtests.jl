using Test
include("money.jl")

@testset "Multiplication" begin
    five = Dollar(5)
    product = times(five, 2)
    @test 10 == product.amount
    product = times(five, 3)
    @test 15 == product.amount
end

