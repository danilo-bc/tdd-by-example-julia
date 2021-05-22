abstract type Money end

struct Dollar <: Money
    amount
end

struct Franc <: Money
    amount
end

times(m1::T, multiplier::Int) where {T <: Money} = T(m1.amount * multiplier)

equals(m1::Money, m2::Money) = m1.amount == m2.amount