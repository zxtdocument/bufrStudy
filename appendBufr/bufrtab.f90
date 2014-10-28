program bufrtab
    integer :: unit_out=10,unit_table=20
    open(unit_table,file='bufrtable.txt')
    open(unit_out,file='bufrgood',status='old',form='unformatted')
    call openbf(unit_out,'IN',unit_out)
    call dxdump(unit_out,unit_table)
    call closbf(unit_out)
end
