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
    @test equals(Franc(5), Franc(5))
    @test !equals(Franc(5), Franc(6))
    @test !equals(Franc(5), Dollar(5))
end

@testset "FrancMultiplication" begin
    five = Franc(5)
    @test Franc(10) == times(five, 2)
    @test Franc(15) == times(five, 3)
end