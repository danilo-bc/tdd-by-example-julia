struct Money
    amount::Int64
    currency::String
end

abstract type Dollar end
abstract type Franc end

Money(cur_type::Type{Dollar}, amount::Int) = Money(amount, "USD")
Money(cur_type::Type{Franc}, amount::Int) = Money(amount, "CHF")

times(m1::Money, multiplier::Int) = Money(m1.amount * multiplier, currency(m1))

equals(m1::Money, m2::Money) = (m1.amount == m2.amount) && (currency(m1) == currency(m2))

currency(m1::Money) = m1.currency