using Test
include("money.jl")

@testset "Multiplication" begin
    five = Dollar(5)
    product = times(five, 2)
    @test 10 == product.amount
    product = times(five, 3)
    @test 15 == product.amount
end

@testset "Test equality" begin
    @test equals(Dollar(5), Dollar(5))
    @test !equals(Dollar(5), Dollar(6))
end