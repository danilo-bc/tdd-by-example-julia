using Test
include("money.jl")

@testset "Multiplication" begin
    five = Dollar(5)
    @test Dollar(10) == times(five, 2)
    @test Dollar(15) == times(five, 3)
end

@testset "Test equality" begin
    @test equals(Dollar(5), Dollar(5))
    @test !equals(Dollar(5), Dollar(6))
end