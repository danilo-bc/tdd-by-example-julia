struct Money
    amount::Int64
    currency::String
end
dollar(amount::Int) = Money(amount, "USD")
franc(amount::Int) = Money(amount, "CHF")
times(m1::Money, multiplier::Int) = Money(m1.amount * multiplier, currency(m1))
equals(m1::Money, m2::Money) = (m1.amount == m2.amount) && (currency(m1) == currency(m2))
currency(m1::Money) = m1.currency

struct Expression
    amount::Int64
    currency::String
end
Expression(m1::Money) = Expression(m1.amount, m1.currency)
currency(e1::Expression) = e1.currency
equals(m1::Money, e2::Expression) = (m1.amount == e2.amount) && (currency(m1) == currency(e2))

struct Bank
    rates::Vector{Vector{Any}}
end
Bank() = Bank(Vector{Vector{Any}}(undef, 0))

struct Sum
    augend::Expression
    addend::Expression
end
Sum(m1::Money, m2::Money) = Sum(Expression(m1), Expression(m2))

plus(m1::Money, m2::Money) = plus(Expression(m1), Expression(m2))
plus(m1::Expression, m2::Expression) = Sum(m1, m2)
Money(m::Money) = m
Money(s::Sum, to::String) = sum_reduce(s, to)

add_rate(bank::Bank, from::String, to::String, rate::Int) = push!(bank.rates, [from, to, rate])
function get_rate(bank::Bank, from::String, to::String)
    if from == to return 1 end
    index = findfirst(x->(x[1] == from && x[2] == to), bank.rates)
    return bank.rates[index][3]
end

function sum_reduce(s::Sum, bank::Bank, to::String)
    amount = bank_reduce(bank, s.augend, to).amount + bank_reduce(bank, s.addend, to).amount
    return Money(amount, to)
end
bank_reduce(bank::Bank, source::Sum, to::String) = sum_reduce(source, bank, to)
bank_reduce(bank::Bank, source::Money, to::String) = bank_reduce(bank, Expression(source), to)
function bank_reduce(bank::Bank, e1::Expression, to::String)
    rate = get_rate(bank, currency(e1), to)
    return Money(e1.amount / rate, to)
end

