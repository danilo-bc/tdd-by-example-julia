struct Dollar
    amount
end

times(dol::Dollar, multiplier::Int) = Dollar(dol.amount * multiplier)