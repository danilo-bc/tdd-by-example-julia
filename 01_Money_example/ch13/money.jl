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
end

struct Sum <: Expression
    augend::Money
    addend::Money
end


plus(m1::Money, m2::Money) = Sum(m1, m2)
Money(m::Money) = m
Money(s::Sum, to::String) = Money(sum_reduce(s), to)
sum_reduce(s::Sum) = s.augend.amount+s.addend.amount
bank_reduce(b::Bank, source::Sum, to::String) = Money(source, to)
bank_reduce(b::Bank, m1::Money, to::String) = Money(m1)

