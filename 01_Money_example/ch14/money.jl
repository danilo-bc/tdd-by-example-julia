struct Money
    amount::Int64
    currency::String
end
dollar(amount::Int) = Money(amount, "USD")
franc(amount::Int) = Money(amount, "CHF")
times(m1::Money, multiplier::Int) = Money(m1.amount * multiplier, currency(m1))
equals(m1::Money, m2::Money) = (m1.amount == m2.amount) && (currency(m1) == currency(m2))
currency(m1::Money) = m1.currency

abstract type Expression end

struct Bank
    rates::Vector{Vector{Any}}
end
Bank() = Bank(Vector{Vector{Any}}(undef, 0))

struct Sum <: Expression
    augend::Money
    addend::Money
end


plus(m1::Money, m2::Money) = Sum(m1, m2)
Money(m::Money) = m
Money(s::Sum, to::String) = sum_reduce(s, to)
sum_reduce(s::Sum, to::String) = Money(s.augend.amount+s.addend.amount, to)
bank_reduce(bank::Bank, source::Sum, to::String) = sum_reduce(source, to)

addRate(bank::Bank, from::String, to::String, rate::Int) = push!(bank.rates, [from, to, rate])
function get_rate(bank::Bank, from::String, to::String)
    if from == to return 1 end
    index = findfirst(x->(x[1] == from && x[2] == to), bank.rates)
    return bank.rates[index][3]
end

function bank_reduce(bank::Bank, m1::Money, to::String)
    rate = get_rate(bank, currency(m1), to)
    return Money(m1.amount / rate, to)
end

