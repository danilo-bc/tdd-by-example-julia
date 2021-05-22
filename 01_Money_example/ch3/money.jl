struct Dollar
    amount
end

times(dol::Dollar, multiplier::Int) = Dollar(dol.amount * multiplier)
equals(dol1::Dollar, dol2::Dollar) = dol1.amount == dol2.amount