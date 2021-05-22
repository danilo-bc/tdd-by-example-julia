abstract type AbstractExpression end

struct Money <: AbstractExpression
    amount::Int64
    currency::String
end
dollar(amount::Int) = Money(amount, "USD")
franc(amount::Int) = Money(amount, "CHF")

times(m1::Money, multiplier::Int) = Money(m1.amount * multiplier, currency(m1))
equals(m1::Money, m2::Money) = (m1.amount == m2.amount) && (currency(m1) == currency(m2))
currency(m1::Money) = m1.currency

struct Expression <: AbstractExpression
    amount::Int64
    currency::String
end
Expression(m1::Money) = Expression(m1.amount, m1.currency)

currency(e1::Expression) = e1.currency
times(e1::Expression, multiplier::Int) = Expression(e1.amount * multiplier, currency(e1))

struct Sum <: AbstractExpression
    augend::AbstractExpression
    addend::AbstractExpression
end
function Sum(m1::Money, m2::Money) #Extra, book rollsback this change
    if currency(m1) == currency(m2)
        return Money(m1.amount+m2.amount, currency(m1))
    else
        return Sum(Expression(m1), Expression(m2))
    end
end

times(s1::Sum, multiplier::Int) = Sum(times(s1.augend, multiplier), times(s1.addend, multiplier))
plus(el1::AbstractExpression, el2::AbstractExpression) = Sum(el1, el2)

struct Bank
    rates::Dict{Tuple{String, String}, Int64}
end
Bank() = Bank(Dict{Tuple{String, String}, Int64}())

add_rate(bank::Bank, from::String, to::String, rate::Int) = push!(bank.rates, (from, to) => rate)
function get_rate(bank::Bank, from::String, to::String)
    if from == to return 1 end
    if haskey(bank.rates, (from, to))
        return bank.rates[(from, to)]
    else
        return 1
    end
end
bank_reduce(bank::Bank, source::Money, to::String) = bank_reduce(bank, Expression(source), to)
bank_reduce(bank::Bank, source::Sum, to::String) = sum_reduce(source, bank, to)
function bank_reduce(bank::Bank, e1::Expression, to::String)
    rate = get_rate(bank, currency(e1), to)
    return Money(e1.amount / rate, to)
end
function sum_reduce(s::Sum, bank::Bank, to::String)
    amount = bank_reduce(bank, s.augend, to).amount + bank_reduce(bank, s.addend, to).amount
    return Money(amount, to)
end



