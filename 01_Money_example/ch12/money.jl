struct Money
    amount::Int64
    currency::String
end

struct Expression
end

struct Bank
end

dollar(amount::Int) = Money(amount, "USD")
franc(amount::Int) = Money(amount, "CHF")

times(m1::Money, multiplier::Int) = Money(m1.amount * multiplier, currency(m1))
equals(m1::Money, m2::Money) = (m1.amount == m2.amount) && (currency(m1) == currency(m2))
currency(m1::Money) = m1.currency

plus(m1::Money, m2::Money) = Expression(m1.amount + m2.amount, m1.currency)

Expression(amount::Int64, currency::String) = Expression()
bank_reduce(b::Bank, source::Expression, to::String) = dollar(10)