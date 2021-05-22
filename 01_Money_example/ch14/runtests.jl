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

@testset "Plus returns Sum" begin
    five = dollar(5)
    result = plus(five, five)
    sum = result
    @test five == sum.augend
    @test five == sum.addend
end

@testset "Reduce Sum" begin
    sum = Sum(dollar(3), dollar(4))
    bank = Bank()
    result = bank_reduce(bank, sum, "USD")
    @test dollar(7) == result
end

@testset "Reduce Money" begin
    bank = Bank()
    result = bank_reduce(bank, dollar(1), "USD")
    @test dollar(1) == result
end

@testset "Indentity Rate" begin
    @test get_rate(Bank(), "USD", "USD") == 1
end

@testset "New: Get different currencies' rate" begin
    bank = Bank()
    addRate(bank, "CHF", "USD", 2)
    result = get_rate(bank, "CHF", "USD")
    @test 2 == result
end

@testset "Reduce Money Different Currency" begin
    bank = Bank()
    addRate(bank, "CHF", "USD", 2)
    result = bank_reduce(bank, franc(2), "USD")
    @test dollar(1) == result
end

