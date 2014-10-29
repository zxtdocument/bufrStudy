program a
    implicit none
!-----in.txt----------------
    character(1024)::outName,inName
    integer(8)::beginT,endT
    integer(8)::dataT
    integer::unit_intxt=10,stat
!---------------------------

    character(80)::datastr1='YEAR MNTH DAYS HOUR MINU SECO'
    character(80)::datastr2='CLAT CLON SAID SIID FOVN LSQL'
    character(80)::datastr3='SAZA SOZA HOLS HMSL SOLAZI BEARAZ'
    character(80)::datastr4='CHNM TMBR CSTC'
    real(8)::data1(6),data2(6),data3(6),data4(3,15)
    integer::i,flag
    
    integer::ireadmg, ireadsb
    character(8) subset
    integer::unit_in=11,unit_out=12,unit_table=13
    integer::idate,iret,num_message,num_subset

    open(unit_intxt,file='in.txt')
    read(unit_intxt,'(A1024)') outName
    read(unit_intxt,'(I14)') beginT
    read(unit_intxt,'(I14)') endT
    read(unit_intxt,'(A1024)') inName
 
!    call system('cp -rf '//inName//' '//outName)

    open(unit_out,file=outName,status='new',form='unformatted')
    open(unit_in,file=inName,action='read',form='unformatted')
    open(unit_table,file='table.txt')
    call openbf(unit_in,'IN',unit_in)
    call dxdump(unit_in,unit_table)
    call closbf(unit_in)
    close(unit_in)
 
    call openbf(unit_out,'OUT',unit_table)
    do

        open(unit_in,file=inName,action='read',form='unformatted')
        call openbf(unit_in,'IN',unit_in)
        call datelen(10)
        write(*,*) 'Appending ',inName
    
            num_message=0
            msg_report: do while (ireadmg(unit_in,subset,idate)==0)
                num_message=num_message+1
                num_subset=0
!                write(*,'(I10,I4,a10)') idate,num_message,subset
                sb_report: do while (ireadsb(unit_in)==0)
                    num_subset=num_subset+1
                    call ufbint(unit_in,data1,6,1,iret,datastr1)
                    call ufbint(unit_in,data2,6,1,iret,datastr2)
                    call ufbint(unit_in,data3,6,1,iret,datastr3)
                    call ufbrep(unit_in,data4,3,15,iret,datastr4)
                    dataT=data1(1)*1e10 + data1(2)*1e8 + data1(3)*1e6 + data1(4)*1e4 + data1(5)*1e2 + data1(6)

                    if(dataT>endT .OR. dataT<beginT) cycle

!                    write(*,'(2I8,6f20.5)') num_subset,iret,data1(1:6)
!                    write(*,'(2I8,6f20.5)') num_subset,iret,data2(1:6)
!                    write(*,'(2I8,6f20.5)') num_subset,iret,data3(1:6)
    
!                    do i=1,15,1
!                        write(*,'(2I8,3f20.5)') num_subset,iret,data4(1:3,i)
!                    enddo
    
                    call openmb(unit_out,subset,idate)
                    call ufbint(unit_out,data1,6,1,iret,datastr1)
                    call ufbint(unit_out,data2,6,1,iret,datastr2)
                    call ufbint(unit_out,data3,6,1,iret,datastr3)
                    call ufbrep(unit_out,data4,3,15,iret,datastr4)
                    call writsb(unit_out)
                    
                enddo sb_report
            enddo msg_report
            call closbf(unit_in)

        read(unit_intxt,'(A1024)',iostat=stat) inName
        if(stat/=0)exit
    enddo
        call closbf(unit_out)
        close(unit_out)
        close(unit_intxt)
end
