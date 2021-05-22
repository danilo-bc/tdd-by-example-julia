using Test
include("money.jl")

@testset "Multiplication" begin
    five = dollar(5)
    @test dollar(10) == times(five, 2)
    @test dollar(15) == times(five, 3)
end

@testset "Equality" begin
    @test equals(dollar(5), dollar(5))
    @test !equals(dollar(5), dollar(6))
    @test !equals(franc(5), dollar(5))
end

@testset "Currency" begin
    @test "USD" == currency(dollar(1))
    @test "CHF" == currency(franc(1))
end

@testset "Simple addition \$5 + \$5" begin
    five = dollar(5)
    money_sum = plus(five, five)
    bank = Bank()
    reduced_sum = bank_reduce(bank, money_sum, "USD")
    @test dollar(10) == reduced_sum
end