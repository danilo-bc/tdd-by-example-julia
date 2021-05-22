using Test
include("money.jl")

@testset "Multiplication" begin
    five = Money(Dollar, 5)
    @test Money(Dollar, 10) == times(five, 2)
    @test Money(Dollar, 15) == times(five, 3)
end

@testset "Test equality" begin
    @test equals(Money(Dollar, 5), Money(Dollar, 5))
    @test !equals(Money(Dollar, 5), Money(Dollar, 6))
    @test equals(Money(Franc, 5), Money(Franc, 5))
    @test !equals(Money(Franc, 5), Money(Franc, 6))
    @test !equals(Money(Franc, 5), Money(Dollar, 5))
end

@testset "Test currency" begin
    @test "USD" == currency(Money(Dollar, 1))
    @test "CHF" == currency(Money(Franc, 1))
end