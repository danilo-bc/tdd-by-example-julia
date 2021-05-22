struct Dollar
    amount
end

times(dol::Dollar, multiplier::Int) = dol.amount * multiplier