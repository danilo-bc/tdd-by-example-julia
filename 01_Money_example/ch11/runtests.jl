using Test
include("money.jl")

@testset "Multiplication" begin
    five = dollar(5)
    @test dollar(10) == times(five, 2)
    @test dollar(15) == times(five, 3)
end

@testset "Test equality" begin
    @test equals(dollar(5), dollar(5))
    @test !equals(dollar(5), dollar(6))
    @test !equals(franc(5), dollar(5))
end

@testset "Test currency" begin
    @test "USD" == currency(dollar(1))
    @test "CHF" == currency(franc(1))
end