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

# This test interferes with the last behavior we want
# @testset "Plus returns Sum" begin
#     five = dollar(5)
#     result = plus(five, five)
#     sum = result
#     @test equals(five, sum.augend)
#     @test equals(five, sum.addend)
# end

@testset "Simple addition \$5 + \$5" begin
    five = dollar(5)
    money_sum = plus(five, five)
    bank = Bank()
    reduced_sum = bank_reduce(bank, money_sum, "USD")
    @test dollar(10) == reduced_sum
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
    add_rate(bank, "CHF", "USD", 2)
    result = get_rate(bank, "CHF", "USD")
    @test 2 == result
end

@testset "Reduce Money Different Currency" begin
    bank = Bank()
    add_rate(bank, "CHF", "USD", 2)
    result = bank_reduce(bank, franc(2), "USD")
    @test dollar(1) == result
end

@testset "Mixed addition" begin
    five_bucks = dollar(5)
    ten_francs = franc(10)
    bank = Bank()
    add_rate(bank, "CHF", "USD", 2)
    result = bank_reduce(bank, plus(five_bucks, ten_francs), "USD")
    @test dollar(10) == result
end

@testset "Sum plus Money" begin
    five_bucks = dollar(5)
    ten_francs = franc(10)
    bank = Bank()
    add_rate(bank, "CHF", "USD", 2)
    sum = plus(Sum(five_bucks, ten_francs), five_bucks)
    result = bank_reduce(bank, sum, "USD")
    @test dollar(15) == result
end

@testset "Sum times" begin
    five_bucks = dollar(5)
    ten_francs = franc(10)
    bank = Bank()
    add_rate(bank, "CHF", "USD", 2)
    sum = times(Sum(five_bucks, ten_francs), 2)
    result = bank_reduce(bank, sum, "USD")
    @test dollar(20) == result
end

@testset "Plus same currency returns Money" begin
    sum = plus(dollar(1), dollar(1))
    @test equals(sum, dollar(2))
end
