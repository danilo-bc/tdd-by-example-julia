struct Dollar
    amount
end

struct Franc
    amount
end

times(dol::Dollar, multiplier::Int) = Dollar(dol.amount * multiplier)
equals(dol1::Dollar, dol2::Dollar) = dol1.amount == dol2.amount

times(franc::Franc, multiplier::Int) = Franc(franc.amount * multiplier)
equals(franc1::Franc, franc2::Franc) = franc1.amount == franc2.amount